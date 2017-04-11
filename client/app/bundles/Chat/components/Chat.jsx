import React, { PropTypes } from 'react'
import Textarea from 'react-textarea-autosize'

require('../chat.scss')

export default class Chat extends React.Component {
  static propTypes = {
    channel: PropTypes.string.isRequired,
    messages: PropTypes.object.isRequired,
    newMessage: PropTypes.string.isRequired,
    actions: PropTypes.object.isRequired
  }

  constructor(props) {
    super(props)
    this.renderMessages = this.renderMessages.bind(this)
    this.timeOfMessage = this.timeOfMessage.bind(this)
    this.onNewMessageChange = this.onNewMessageChange.bind(this)
    this.onNewMessageKeyPress = this.onNewMessageKeyPress.bind(this)
    this.onSubmitClick = this.onSubmitClick.bind(this)
    this.submitNewMessage = this.submitNewMessage.bind(this)
    this.fetchHistory = this.fetchHistory.bind(this)
  }

  renderMessages() {
    if (this.props.messages.messageList.length > 0) {
      return this.props.messages.messageList.map(m => {
        return (
          <div className="message" key={m.entry.id}>
            {m.entry.message}
            {this.timeOfMessage(m.entry)}
          </div>
        )
      })
    }
    else {
      return <div className="no-messages">No messages</div>
    }
  }

  timeOfMessage(message) {
    return (
      <div className="right">
        {new Date(message.id).toLocaleTimeString()}
      </div>
    )
  }

  onNewMessageChange(event) {
    this.props.actions.changeNewMessage(event.target.value)
  }

  onNewMessageKeyPress(event) {
    if (event.key === 'Enter') {
      this.submitNewMessage(event.target.value)
    }
  }

  onSubmitClick() {
    this.submitNewMessage(this.props.newMessage)
  }

  submitNewMessage(msg) {
    const messageObj = {
      id: Date.now(),
      message: msg
    }

    this.pubnub.publish(
      {
        message: messageObj,
        channel: this.props.channel
      },
      function (status, response) {
        if (status.error) {
          // handle error
          console.log(status)
        } else {
          console.log("message Published w/ timetoken", response.timetoken)
        }
      }
    )

    this.props.actions.submitMessage()
  }

  fetchHistory() {
    this.pubnub.history({
      channel: this.props.channel,
      count: 30,
      start: this.props.messages.lastMessageTimestamp,
    }).then((response) => {

      // response is Array(3), where index 0 is an array of messages
      // and index 1 and 2 are start and end dates of the messages
      this.props.actions.addHistory(response.messages, response.startTimeToken)
    })
  }

  componentDidMount() {
    this.refs.messageInput.focus()

    this.pubnub = new PubNub({
      publishKey: "pub-c-7e4cb727-12f0-4f11-8d63-29b1a27bfe10",
      subscribeKey: "sub-c-c28a8948-f585-11e6-bb94-0619f8945a4f",
      ssl: true
    })

    this.pubnub.addListener({
      message: (message) => {
        this.props.actions.incomingMessage(message.message)
      }
    })

    this.pubnub.subscribe({
      channels: [this.props.channel]
    })

    this.fetchHistory()
  }

  componentDidUpdate() {
    this.refs.messages.scrollTop = this.refs.messages.scrollHeight
  }

  render() {
    return (
      <div className="chat-component">
        <div className="messages" ref="messages">{this.renderMessages()}</div>
        <div className="message-input">
          <Textarea
            wrap="hard"
            type="text"
            placeholder="Enter message here"
            ref="messageInput"
            value={this.props.newMessage}
            onChange={this.onNewMessageChange}
            onKeyPress={this.onNewMessageKeyPress}>
          </Textarea>
        </div>
        <div className="message-button">
          <button onClick={this.onSubmitClick}>Submit</button>
        </div>
      </div>
    )
  }
}

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
          <div className="message" key={m.id}>
            {m.message}
            {this.timeOfMessage(m)}
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

    this.PubNub.publish({
      channel: this.props.channel,
      message: messageObj,
      callback: function(m){
        console.log(m)
      }
    })

    this.props.actions.submitMessage()
  }

  fetchHistory() {
    this.PubNub.history({
      channel: this.props.channel,
      count: 20,
      start: this.props.messages.lastMessageTimestamp,
      callback: (data) => {
        // data is Array(3), where index 0 is an array of messages
        // and index 1 and 2 are start and end dates of the messages
        this.props.actions.addHistory(data[0], data[1])
      },
    })
  }

  componentDidMount() {
    this.refs.messageInput.focus()

    this.PubNub = PUBNUB.init({
      publish_key: 'pub-c-7e4cb727-12f0-4f11-8d63-29b1a27bfe10', // only required if publishing
      subscribe_key: 'sub-c-c28a8948-f585-11e6-bb94-0619f8945a4f', // always required
      ssl: (location.protocol.toLowerCase() === 'https:')
    })

    // The following PubNub initialization is for version 4.7.0 if used. Could not get
    //  it to work with React
    // this.PubNub = new PubNub({
    //   publishKey: "pub-c-7e4cb727-12f0-4f11-8d63-29b1a27bfe10",
    //   subscribeKey: "sub-c-c28a8948-f585-11e6-bb94-0619f8945a4f",
    //   ssl: true
    // })

    this.PubNub.subscribe({
      channel: this.props.channel,
      message: (msg) => this.props.actions.incomingMessage(msg)
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

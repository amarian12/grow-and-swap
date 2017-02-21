import React, { PropTypes } from 'react'
import Textarea from 'react-textarea-autosize'

require('../chat.scss')

export default class Chat extends React.Component {
  static propTypes = {
    messages: PropTypes.arrayOf(PropTypes.shape({
      id: PropTypes.number.isRequired,
      content: PropTypes.string.isRequired
    }).isRequired).isRequired,
    newMessage: PropTypes.string.isRequired,
    actions: PropTypes.object.isRequired
  }

  constructor(props) {
    super(props)
    this.onNewMessageChange = this.onNewMessageChange.bind(this)
    this.onNewMessageKeyPress = this.onNewMessageKeyPress.bind(this)
    this.onSubmitClick = this.onSubmitClick.bind(this)
    this.submitNewMessage = this.submitNewMessage.bind(this)
  }

  renderMessages() {
    if (this.props.messages.length > 0) {
      return this.props.messages.map(m => {
        return (
          <div className="message" key={m.id}>
            {m.content}
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
    this.props.actions.submitMessage()
    this.props.actions.incomingMessage(msg)
  }

  componentDidMount() {
    this.refs.messageInput.focus()
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

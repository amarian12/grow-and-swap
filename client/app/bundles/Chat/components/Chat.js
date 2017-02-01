import React, { PropTypes } from 'react';
// import actionCreators from '../chat-actions-creators';

const Chat = ({

	render() {

		return (
			<div className="chat">
				<div className="messages" ref="messages">{this.renderMessages()}</div>
			</div>
		);
	},

	renderMessages() {
		if (messages.length > 0) {
			return messages.map(m => {
				return <div className="message" key={m.id}>{m.content}</div>
			});
		}
		else {
			return <div className="no-messages">No messages</div>;
		}
	},

	// onNewMessageChange(event) {
	// 	actionCreators.changeNewMessage(event.target.value);
	// },

	// onSubmitClick() {
	// 	this.submitNewMessage();
	// },

	// submitNewMessage() {
	// 	actionCreators.submitNewMessage();
	// 	//actionCreators.checkGiphyCommand(this.props.newMessage);
	// },

	// onNewMessageKeyPress(event) {
	// 	if (event.key === 'Enter') {
	// 		this.submitNewMessage();
	// 	}
	// },

	componentDidMount() {
		this.refs.messageInput.focus();
	},

	componentDidUpdate() {
		this.refs.messages.scrollTop = this.refs.messages.scrollHeight;
	}
});

Chat.propTypes = {
	messages: PropTypes.arrayOf(PropTypes.shape({
		id: PropTypes.number.isRequired,
		content: PropTypes.text.isRequired
	}).isRequired).isRequired
};

export default Chat

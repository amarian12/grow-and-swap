import React from 'react';
// import store from './chat-store';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import actionCreators from '../chat-actions-creators';
// import ChatContainer from './chat-container.react';
// import Chat from '../components/Chat.js';
// import ChatMetrics from './chat-metrics.react';
// import ChatGiphys from './chat-giphys.react';
// import RequestStatus from './request-status.react.js';

// export default React.createClass({

// 	getInitialState() {
// 		return this._getState();
// 	},

// 	_getState() {
// 		return {
// 			messages: store.messages,
// 			newMessage: store.newMessage,
// 			// giphys: store.giphys,
// 			// giphyRequestStatus: store.giphyRequestStatus
// 		};
// 	},

// 	componentDidMount() {
// 		store.addChangeListener(this.handleChange);

// 	},

// 	handleChange() {
// 		this.setState(this._getState());
// 	},

// 	render() {
// 		return (
// 			<div className="chat-controller">
// 				<Chat messages={this.state.messages} newMessage={this.state.newMessage} />
// 				<ChatMetrics messages={this.state.messages} newMessage={this.state.newMessage} />
// 			</div>
// 		);
// 	},

// 	componentWillUnmount() {
// 		store.removeChangeListener(this.handleChange);
// 	}
// });


let addMessage = ({ dispatch }) => {
	return (
		<div className="chat-container">
			<div className="message-input">
				<input
					type="text"
					placeholder="Enter message here"
					ref="messageInput"
					value={this.props.newMessage}
					onChange={this.onNewMessageChange}
					onKeyPress={this.onNewMessageKeyPress}/>
			</div>
			<div className="message-button">
				<button onClick={this.onSubmitClick}>Submit</button>
			</div>
		</div>
	)

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
};


const mapStateToProps = (state) => {
	return {
		messages: state.messages
	}
};

const mapDispatchToProps = (dispatch) => ({
  actions: bindActionCreators(actionCreators, dispatch)
});

const ChatControl = connect(
	mapStateToProps,
	mapDispatchToProps
)(addMessage);

export default ChatControl

// event emitter is a node package that lets you emit events and listen for events
// import {EventEmitter} from 'events';
// import dispatcher from './chat-dispatcher';
import { combineReducers } from 'react-redux';
import actionCreators from './chat-actions-creators';
import messageApi from './message-api';

// class ChatStore extends EventEmitter {

// 	constructor() {
// 		super();
// 		this._messages = [];
// 		this._newMessage = '';

// 		dispatcher.register(this.handleAction.bind(this));
// 	}

// 	get messages() {
// 		return this._messages;
// 	}

// 	get newMessage() {
// 		return this._newMessage;
// 	}

// 	handleAction(action) {

// 		global.setTimeout(() => {
// 			console.log(action.type);
// 		},0);

// 		switch(action.type) {
// 			case 'change-new-message':
// 				this._newMessage = action.payload.newValue;
// 				this.emitChange();
// 				break;

// 			case 'submit-new-message':
// 				this._submitNewMessage();
// 				this.emitChange();
// 				break;

// 			case 'incoming-new-message':
// 				this._incomingNewMessage(action.payload.content);
// 				this.emitChange();
// 				break;

// 			default:
// 				break;
// 		}
// 	}

// 	_submitNewMessage() {
// 		if (this._newMessage.trim().length > 0) {
// 			messageApi.publish(this._newMessage);
// 			this._newMessage = '';
// 		}
// 	}

// 	_incomingNewMessage(content) {
// 		let messageObj = {
// 			id: Date.now(),
// 			content
// 		};

// 		this.push(messageObj);
// 	}

// 	emitChange() {
// 		this.emit('chat-store-change');
// 	}

// 	addChangeListener(callback) {
// 		this.on('chat-store-change', callback);
// 	}

// 	removeChangeListener(callback) {
// 		this.removeListener('chat-store-change', callback);
// 	}
// }

// let store = new ChatStore();

// export default store;












function messagesReducer(state = [], action) {
	global.setTimeout(() => {
		console.log(action.type);
	},0);

	switch(action.type) {
		case 'incoming-new-message':
			return Object.assign({},
				state._incomingNewMessage(action.payload.content)
			);

		default:
			return state;
	};

	function _incomingNewMessage(content) {
		let messageObj = {
			id: Date.now(),
			content
		};

		this.push(messageObj);
	};
};

function newMessageReducer(state = '', action) {
	global.setTimeout(() => {
		console.log(action.type);
	},0);

	switch(action.type) {
		case 'change-new-message':
			return Object.assign({},
				state = action.payload.newValue
			);

		case 'submit-new-message':
			return Object.assign({},
				_submitNewMessage()
			);

		default:
			return state;
	};

	function _submitNewMessage() {
		if (state.trim().length > 0) {
			messageApi.publish(state);
			state = '';
		}
	};
};

const reducer = combineReducers({
	messagesReducer,
	newMessageReducer
});

export default reducer

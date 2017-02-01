import React from 'react';
import Chat from './Chat'
import ChatControl from '../containers/ChatController'
// import {Link} from 'react-router';

require('../chat.scss');

const Main = () => {
	return (
		<div className="main-container">
			<h1>Chat</h1>
			<Chat />
			<ChatControl />
		</div>
	);
};

export default Main;

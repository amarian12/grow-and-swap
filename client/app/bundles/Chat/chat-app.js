import 'babel-polyfill';

import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';
import ReactOnRails from 'react-on-rails';
import reducer from './chat-reducer';
// import ChatController from './chat/chat-controller.react';
// import TrendingController from './chat/trending-controller.react';
// import { Router, Route, browserHistory } from 'react-router';
// import actionCreators from './chat/chat-actions-creators';
import Main from './components/Main';
// import giphyApi from './chat/giphy-api';

// let clearGiphys = function(routerState) {
// 	actionCreators.clearGiphys();
// 	giphyApi.trending(routerState.params.count);
// };

export default () => {
	const store = ReactOnRails.getStore(reducer);
	// const store = createStore(reducer);

		// const Routes = (
		// 	<Router history={browserHistory}>
		// 		<Route path="/" component={MainContainer}>
		// 			<Route path="chat" component={ChatController} />
		// 			<Route path="*" component={ChatController} />
		// 		</Route>
		// 	</Router>
		// );

	// ReactDOM.render(
	// 	<Provider store={store}>
	// 		<Main />
	// 	</Provider>,
	// 	document.getElementByID('root')
	// );

	return (
		<Provider store={store}>
			<Main />
		</Provider>
	);
};

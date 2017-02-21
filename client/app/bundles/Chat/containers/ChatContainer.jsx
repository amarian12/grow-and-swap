// Simple example of a React "smart" component
import React from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'

import Chat from '../components/Chat'
import * as actionCreators from '../actions/chatActionCreators'

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => ({
  messages: state.messages,
  newMessage: state.newMessage
})

const mapDispatchToProps = (dispatch) => ({
  actions: bindActionCreators(actionCreators, dispatch),
})

// Don't forget to actually use connect!
// Note that we don't export HelloWorld, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(Chat)

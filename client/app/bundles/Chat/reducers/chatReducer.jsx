import { combineReducers } from 'redux'

import {
  CHANGE_NEW_MESSAGE,
  SUBMIT_NEW_MESSAGE,
  ADD_HISTORY,
  INCOMING_NEW_MESSAGE
} from '../constants/chatConstants'

const channel = (state = '', action) => {
  return state
}

const initialState = {
  messageList: [],
  lastMessageTimestamp: null
}

const messages = (state = initialState, action) => {
  switch(action.type) {
    case ADD_HISTORY:
      let newMessageList = state.messageList
      newMessageList.unshift(...action.payload.messages)

      return {
        ...state,
        messageList: newMessageList,
        lastMessageTimestamp: action.payload.timestamp
      }
    case INCOMING_NEW_MESSAGE:
      return {
        ...state,
        messageList: state.messageList.concat(action.payload)
      }
    default:
      return state
  }
}

const newMessage = (state = '', action) => {
  switch(action.type) {
    case CHANGE_NEW_MESSAGE:
      return action.payload.newValue
    case SUBMIT_NEW_MESSAGE:
      return state = ''
    default:
      return state
  }
}

const railsContext = (state = {}, action) => {
  return state
}

const chatReducer = combineReducers({
  channel,
  messages,
  newMessage,
  railsContext
})

export default chatReducer

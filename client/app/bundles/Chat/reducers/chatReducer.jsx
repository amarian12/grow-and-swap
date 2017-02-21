import { combineReducers } from 'redux'

import {
  CHANGE_NEW_MESSAGE,
  SUBMIT_NEW_MESSAGE,
  INCOMING_NEW_MESSAGE
} from '../constants/chatConstants'

const messages = (state = [], action) => {
  // The following function was used in the Flux version of this chat app
  // global.setTimeout(() => {
  //  console.log(action.type)
  // },0)

  switch(action.type) {
    case INCOMING_NEW_MESSAGE:
      return [...state, action.payload]
    default:
      return state
  }
}

const newMessage = (state = '', action) => {
  // The following function was used in the Flux version of this chat app
  // global.setTimeout(() => {
  //  console.log(action.type)
  // },0)

  switch(action.type) {
    case CHANGE_NEW_MESSAGE:
      return action.payload.newValue
    case SUBMIT_NEW_MESSAGE:
      return state = ''
    default:
      return state
  }
}

const chatReducer = combineReducers({
  messages,
  newMessage
})

export default chatReducer

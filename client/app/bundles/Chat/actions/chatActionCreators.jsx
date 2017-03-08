/* eslint-disable import/prefer-default-export */

import {
  CHANGE_NEW_MESSAGE,
  SUBMIT_NEW_MESSAGE,
  ADD_HISTORY,
  INCOMING_NEW_MESSAGE
} from '../constants/chatConstants'

export const changeNewMessage = (newValue) => ({
  type: CHANGE_NEW_MESSAGE,
  payload: {
    newValue
  }
})

export const submitMessage = () => ({
  type: SUBMIT_NEW_MESSAGE
})

export const addHistory = (messages, timestamp) => ({
  type: ADD_HISTORY,
  payload: {
    messages,
    timestamp
  }
})

export const incomingMessage = (message) => ({
  type: INCOMING_NEW_MESSAGE,
  payload: message
})

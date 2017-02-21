/* eslint-disable import/prefer-default-export */

import {
  CHANGE_NEW_MESSAGE,
  SUBMIT_NEW_MESSAGE,
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

export const incomingMessage = (content) => ({
  type: INCOMING_NEW_MESSAGE,
  payload: {
    id: Date.now(),
    content
  }
})

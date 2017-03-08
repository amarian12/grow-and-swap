import { createStore } from 'redux'

import chatReducer from '../reducers/chatReducer'

const chatStore = (props, railsContext) => {
  const newProps = { ...props, railsContext }
  return createStore(chatReducer, newProps)
}

export default chatStore

import ReactOnRails from 'react-on-rails'
import 'semantic-ui-css/semantic.css'

import ChatApp from './ChatApp'
import chatStore from '../store/chatStore'

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({ ChatApp })

ReactOnRails.registerStore({ chatStore })

import ReactOnRails from 'react-on-rails'
import 'semantic-ui-css/semantic.css'

import ChatApp from './ChatApp'
import chatStore from '../store/chatStore'

ReactOnRails.register({ ChatApp })

ReactOnRails.registerStore({ chatStore })

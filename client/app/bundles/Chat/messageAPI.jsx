import * as actionCreators from './actions/chatActionCreators';

const pubnub = PubNub({
  subscribe_key: 'sub-c-c28a8948-f585-11e6-bb94-0619f8945a4f', // always required
  publish_key: 'pub-c-7e4cb727-12f0-4f11-8d63-29b1a27bfe10' // only required if publishing
});

pubnub.subscribe({
  channel: 'grow-and-swap',
  callback: function(m) {
    actionCreators.incomingMessage(m);
  },
  error: function(err) {
    console.log(err);
  }
});

const messageApi = {

  publish(message) {
    pubnub.publish({
      channel: 'grow-and-swap',
      message,
      callback: function(m){
        //console.log(m);
      }
    });
  }
};

export default messageAPI;

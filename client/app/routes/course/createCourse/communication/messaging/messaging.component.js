class MessagingCtrl {
  constructor() {
    "ngInject";
  }
}

let messaging = {
  template: require('./messaging.html'),
  controller: MessagingCtrl,
};

export default messaging;

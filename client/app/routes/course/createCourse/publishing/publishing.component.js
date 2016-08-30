class PublishingCtrl {
  constructor() {
    "ngInject";
  }
}

let publishing = {
  template: require('./publishing.html'),
  controller: PublishingCtrl,
};

export default publishing;

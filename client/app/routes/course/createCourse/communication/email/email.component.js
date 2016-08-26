class EmailCtrl {
  constructor() {
    "ngInject";
  }
}

let email = {
  template: require('./email.html'),
  controller: EmailCtrl,
};

export default email;

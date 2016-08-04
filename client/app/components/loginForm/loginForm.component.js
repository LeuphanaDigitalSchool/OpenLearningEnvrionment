class LoginFormCtrl {
  constructor($auth, $state, toastr) {
    "ngInject";
    this.$state = $state;
    this.$auth = $auth;
    this.toastr = toastr;
    this.loginForm = {};
  }

  login() {
    this.$auth
      .submitLogin(this.loginForm)
        .then(this.handleSuccess.bind(this))
        .catch(this.handleError.bind(this));
  }

  handleSuccess(response) {
    this.$state.go('home');
  }

  handleError(response) {
    this.toastr.error('Your credentials are wrong', 'Error');
  }
}

let loginForm = {
  template: require('./loginForm.html'),
  controller: LoginFormCtrl,
};

export default loginForm;

class LoginFormCtrl {
  constructor($auth, $state, toastr) {
    "ngInject";
    this.$state = $state;
    this.$auth = $auth;
    this.toastr = toastr;
    this.loginForm = {};
    this.waiting = false;
  }

  login() {
    this.waiting = true;
    this.$auth
      .submitLogin(this.loginForm)
        .then(this.handleSuccess.bind(this))
        .catch(this.handleError.bind(this));
  }

  handleSuccess(response) {
    this.waiting = false;
    this.$state.go('home');
  }

  handleError(response) {
    this.waiting = false;
    this.toastr.error('Your credentials are wrong', 'Error');
  }
  registerAsGuest() {
    this.$state.go('publicRegistration');
  }
  forgottenPassword() {
    this.$state.go('forgottenPassword');
  }
}

let loginForm = {
  template: require('./loginForm.html'),
  controller: LoginFormCtrl,
};

export default loginForm;

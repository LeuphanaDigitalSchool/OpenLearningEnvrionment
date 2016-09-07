export default class ResetPasswordCtrl {
  constructor($location, $stateParams, Restangular, toastr, $state){
    "ngInject";
    this.$location = $location;
    this.Restangular = Restangular;
    this.toastr = toastr;
    this.$state = $state;
    this.$stateParams= $stateParams;
    this.resetPasswordToken = this.$stateParams.token;
    this.baseResetPasswordUrl = this.Restangular.all('/api/v1/auth/password');
    this.initialData();
    this.checkIfTokenIsValid();
    this.user.reset_password_token = this.resetPasswordToken;
  }

  initialData() {
    this.send = true;
    this.sendData = {};
    this.user = {};
    this.client_id = '';
    this.token = '';
    this.uid = '';
  }

  checkIfTokenIsValid() {
    this.Restangular.oneUrl('resetPassword', '/api/v1/auth/password/edit?reset_password_token=' + this.resetPasswordToken + '&redirect_url=/localhost:8080').get().then(
      (response)=>{
        this.client_id = response.client_id;
        this.token = response.token;
        this.uid = response.uid;
      }, (error)=>{
      if(error.status === 406) {
        this.toastr.error('Invalid Token', 'Error');
        this.$state.go('login');
      }
    });
  }

  handleError(form, data){
    if(this.user.password !== this.user.password_confirmation) {
      this.toastr.error('Password Must Match', 'Error');
      this.errors += 1;
    }
  }

  submit(form, data){
    this.head = {
      'accept': 'application/json',
      'content-type': 'application/json',
      'client': this.client_id,
      'access-token': this.token,
      'uid': this.uid
    };

    this.resetData = {
      'password': this.user.password,
      'password_confirmation': this.user.password_confirmation
    }

    this.errors = 0;
    this.handleError(form, data);
    if(this.errors === 0) {
      this.send = false;
      this.baseResetPasswordUrl.customPUT(this.resetData, this.baseResetPasswordUrl, {}, this.head).then(()=>{
        this.toastr.success('Password change! Now you can login!', 'Success');
        this.$state.go('login');
        this.initialData();
      }, (response)=> {
        this.send = true;
        let status = response.statusText;
        this.toastr.error(status, 'Error');
      });
    }
  }
}

export default class RegisterPublicUserCtrl {
  constructor($state, toastr, Restangular){
    "ngInject";
    let user,
        errors,
        baseForgottenPassword,
        send;
    this.toastr = toastr;
    this.$state = $state;
    this.Restangular = Restangular;
    this.user = null;
    this.send = true;
    this.baseForgottenPassword = this.Restangular.all('/api/v1/auth/password');
  }

  submit(form, data){
    this.errors = 0;
    if(this.errors === 0) {
      this.send = false;
      this.user.redirect_url = 'http://localhost:8080';
      this.baseForgottenPassword.post(this.user).then(()=>{
        this.send = true;
        this.toastr.success('Reset password instruction was send', 'Success');
        this.loginPage();
      }, (response)=> {
        this.send = true;
        let status = response.data.errors.full_messages;
        for (var i = 0; i < status.length; i++) {
          this.toastr.error(status[i], 'Error');
        }
      });
    }
  }

  loginPage(){
    this.$state.go('login');
  }
}

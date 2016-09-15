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
      }, (reject)=> {
        this.send = true;
        this.toastr.error('The account that you tried to reach does not exist', 'Error');
      });
    }
  }

  loginPage(){
    this.$state.go('login');
  }
}

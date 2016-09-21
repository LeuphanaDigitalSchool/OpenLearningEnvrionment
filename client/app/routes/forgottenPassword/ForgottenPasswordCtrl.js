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
      this.baseForgottenPassword.post(this.user).then((response)=>{
        this.send = true;
        this.toastr.success(response.message, 'Success');
        this.loginPage();
      }, (response)=> {
        this.send = false;
        let status = response.data.errors;
        for (var i = 0; i < status.length; i++) this.toastr.error(status[i], 'Error');
      });
    }
  }

  loginPage(){
    this.$state.go('login');
  }
}

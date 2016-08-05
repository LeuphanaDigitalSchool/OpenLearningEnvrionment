export default class RegisterPublicUserCtrl {
  constructor($state, toastr, Restangular){
    "ngInject";
    let user,
        errors,
        basePublicUser,
        send;
    this.toastr = toastr;
    this.$state = $state;
    this.Restangular = Restangular;
    this.user = null;
    this.send = true;
    this.basePublicUser = this.Restangular.all('/api/v1/auth');
  }

  submit(form, data){
    this.errors = 0;
    this.handleError(form, data);
    if(this.errors === 0) {
      this.send = false;
      this.basePublicUser.post(this.user).then(()=>{
        this.send = true;
        this.toastr.success('Thank you for registering', 'Success');
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

  handleError(form, data){
    if(form.$error.required){
      this.toastr.error('You need to fill all required fields', 'Error');
      this.errors += 1;
    }
    if(!this.user.honor_code) {
      this.toastr.error('You need to accept honor code', 'Error');
      this.errors += 1;
    }
    if(!this.user.terms_and_conditions) {
      this.toastr.error('You need to accept terms and conditions', 'Error');
      this.errors += 1;
    }
    if(!this.user.data_privacy) {
      this.toastr.error('You need to accept data privacy', 'Error');
      this.errors += 1;
    }
  }

  loginPage(){
    this.$state.go('login');
  }
}

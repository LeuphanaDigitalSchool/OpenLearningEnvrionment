export default class RegisterPublicUserCtrl {
  constructor(toastr){
    "ngInject";
    let user,
        errors;
    this.toastr = toastr;
    this.user = null;
  }

  submit(form, data){
    this.errors = 0;
    this.user = data;
    this.handleError(form);
    if(this.errors === 0) {
      console.log('no errors');
    }
  }
  handleError(form){
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
}

export default class CreateProfileCtrl {
  constructor(countryList, $state, toastr, Restangular) {
    "ngInject";
    let userType;
    this.user = null;
    this.toastr = toastr;
    this.$state = $state;
    this.Restangular = Restangular;
    this.baseLephanaUser = this.Restangular.all('/api/v1/admin/users');
    this.genders = [
      'male',
      'female',
      'I d rather not say'
    ];
    this.roles = [
      'student',
      'teacher',
      'course director',
      'support'
    ];
    this.educational_attainments = [
      'None',
      'High School',
      'Bachelor or equivalent',
      'Master or equivalent',
      'PhD',
      'Professor'
    ];
    this.countries = countryList;
    this.waiting = false;
  }

  submit(form, data){
    this.errors = 0;
    this.handleError(form, data);
    if(this.errors === 0) {
      this.send = false;
      this.baseLephanaUser.post(userType, this.user).then(()=>{
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
  checkUserType(){
    if(this.role === 'student'){userType = 'students';}
    if(this.role === 'teacher'){userType = 'teachers';}
    if(this.role === 'course director'){userType = 'course_directors';}
    if(this.role === 'support'){userType = 'supports';}
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
}

export default class CreateProfileCtrl {
  constructor(countryList, $state, toastr, Restangular, Upload) {
    "ngInject";
    this.user = {};
    this.toastr = toastr;
    this.$state = $state;
    this.Upload = Upload;
    this.Restangular = Restangular;
    this.roles = [
      'student',
      'teacher',
      'course director',
      'support'
    ];
    this.countries = countryList;
    this.waiting = false;
  }

  submit(form, data){
    this.errors = 0;
    this.handleError(form, data);
    this.checkUserType();
    this.baseLephanaUser = this.Restangular.all('/api/v1/admin/users/' + this.userType);
    if(this.errors === 0) {
      this.send = false;
      this.baseLephanaUser.post(this.sendData).then(()=>{
        this.toastr.success('Thank you for registering new user', 'Success');
        this.initialData();
      }, (response)=> {
        this.send = true;
        let status = response.statusText;
        this.toastr.error(status, 'Error');
      });
    }
  }
  checkUserType(){
    if(this.role === 'student'){
      this.userType = 'students';
      this.sendData = {'student':{ }};
      this.sendData.student = this.user;
    }
    if(this.role === 'teacher'){
      this.userType = 'teachers';
      this.sendData = {'teacher':{ }};
      this.sendData.teacher = this.user;
    }
    if(this.role === 'course director'){
      this.userType = 'course_directors';
      this.sendData = {'course_director':{ }};
      this.sendData.course_director = this.user;
    }
    if(this.role === 'support'){
      this.userType = 'supports';
      this.sendData = {'support':{ }};
      this.sendData.support = this.user;
    }
  }

  handleError(form, data){
    if(this.user.password !== this.user.password_confirmation) {
      this.toastr.error('Password Must Match', 'Error');
      this.errors += 1;
    }
  }

  initialData() {
    this.send = true;
    this.sendData = {};
    this.user = {};
    this.role = null;
  }
}

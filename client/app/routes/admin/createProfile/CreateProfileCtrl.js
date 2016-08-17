export default class CreateProfileCtrl {
  constructor(countryList, $state, toastr, Restangular, Upload) {
    "ngInject";
    this.user = {};
    this.toastr = toastr;
    this.$state = $state;
    this.Upload = Upload;
    this.Restangular = Restangular;
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
    this.checkUserType();
    this.baseLephanaUser = this.Restangular.all('/api/v1/admin/users/' + this.userType);
    if(this.errors === 0) {
      this.send = false;
      this.baseLephanaUser.post(this.sendData).then(()=>{
        this.toastr.success('Thank you for registering new user', 'Success');
        this.initialData();
      }, (response)=> {
        this.send = true;
        console.log(response);
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
    if(this.role === 'student'){
      this.handleErrorStudents();
    }
    if(this.user.password !== this.user.password_confirmation) {
      this.toastr.error('Password Must Match', 'Error');
      this.errors += 1;
    }
  }

  handleErrorStudents() {
    if(!this.user.gender) {
      this.toastr.error('You need to select gender', 'Error');
      this.errors += 1;
    }
    if(!this.user.country) {
      this.toastr.error('You need to select country', 'Error');
      this.errors += 1;
    }
    if(!this.user.birthdate) {
      this.toastr.error('You need to fill birth date', 'Error');
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

  uploadImage(file, errFiles, $event) {
      if (file) {
          this.uploading = true;
          file.upload = this.Upload.base64DataUrl(file);
          file.upload.then( (response) => {
            this.user.avatar = response;
            this.uploading = false;
          }, (response)=> {
              if (response.status > 0)
                  $scope.errorMsg = response.status + ': ' + response.data;
          }, (evt)=> {
            file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
          });
      }
      if (errFiles[0]) {
        this.$mdDialog.show(
          this.$mdDialog.alert()
            .clickOutsideToClose(true)
            .title('Image size')
            .textContent('Yours file size is wrong (max height & width = 1000 px)')
            .ariaLabel('file size')
            .ok('ok')
            .targetEvent($event)
        );
      }
  }

  removeImage() {
    this.user.avatar = null;
  }
  initialData() {
    this.send = true;
    this.sendData = {};
    this.user = {};
    this.role = null;
  }
}

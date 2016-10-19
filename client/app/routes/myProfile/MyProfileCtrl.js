export default class MyProfileCtrl {
  constructor($location, Restangular, $scope, $mdDialog, toastr, Upload, countryList, $auth) {
    "ngInject";
    this.$mdDialog = $mdDialog;
    this.Restangular = Restangular;
    this.$location = $location;
    this.toastr = toastr;
    this.$auth = $auth;
    this.Upload = Upload;
    this.edit = false;
    this.getSelects();
    this.userData = {};
    this.countries = countryList;
    this.baseAvatarUrl = {};
    this.getMyCourses();
    this.regulationsApi = this.Restangular.oneUrl('files', '/api/v1/admin/regulations');
    this.getRegulations();
  }

  getMyCourses() {
    this.Restangular.oneUrl('courses', '/api/v1/courses').get().then(
      (response)=> {
        this.myCourses = response.courses;
      }
    );
  }

  getSelects() {
    this.Restangular.oneUrl('select', '/api/v1/admin/users/profile_selects').get().then(
      (response)=> {
        this.genders = [
          { 'value': '0', 'name': "Male"},
          { 'value': '1', 'name': "Female"},
          { 'value': '2', 'name': "I'd rather not say"}
        ];
        this.educational_attainments = [
          { 'value': '0', 'name': "I'd rather not say" },
          { 'value': '1', 'name': "High School" },
          { 'value': '2', 'name': "Bachelor's Degree" },
          { 'value': '3', 'name': "Master's Degree" },
          { 'value': '4', 'name': "PhD" },
          { 'value': '5', 'name': "Professor" }
        ];
      }
    );
  }
  editFn(data, avatarData) {
    if(this.edit){
      this.submit(data);
    } else {
      this.edit = true;
      if(avatarData) {
        this.baseAvatarUrl = avatarData;
        this.avatar = this.baseAvatarUrl;
      } else {
        this.avatar = null;
      }
    }
  }

  submit(data){
    this.checkUserRegulations();
    this.baseLephanaUser = this.Restangular.all('/api/v1/auth/');
    this.userData=data;
    this.userData.avatar = this.avatar;
    this.checkIfAvatarExist(this.userData);
    this.sending = true;
    this.$auth.updateAccount(this.userData).then(()=>{
      this.toastr.success('Thank you for edditing profile', 'Success');
      this.edit = false;
    }, (response)=> {
      this.sending = false;
      this.edit = false;
      let status = response.statusText;
      this.toastr.error(status, 'Error');
    });
  }

  uploadImage(file, errFiles, $event) {
      if (file) {
          this.uploading = true;
          file.upload = this.Upload.base64DataUrl(file);
          file.upload.then( (response) => {
            this.avatar = response;
            this.userData.avatar = this.avatar;
            this.uploading = false;
          }, (response)=> {
              if (response.status > 0)
                  $scope.errorMsg = response.status + ': ' + response.data;
          });
      }
      if (errFiles[0]) {
        this.handleError($event);
      }
  }

  removeImage() {
    this.avatar = null;
  }
  checkIfAvatarExist(data) {
    this.userData.remove_avatar = data.avatar === null;
  }
  handleError($event) {
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

  getRegulations() {
    this.regulationsApi.get().then(
      (response)=>{
        this.regulations = response.regulations;
    });
  }
  checkUserRegulations() {
    this.userData.terms_and_conditions = this.regulations[0];
    this.userData.data_privacy = this.regulations[1];
    this.userData.honor_code = this.regulations[2];
  }
}

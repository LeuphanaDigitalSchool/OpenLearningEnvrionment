export default class MyProfileCtrl {
  constructor($location, Restangular, $scope, $mdDialog, toastr, Upload, countryList) {
    "ngInject";
    this.$mdDialog = $mdDialog;
    this.Restangular = Restangular;
    this.$location = $location;
    this.toastr = toastr;
    this.Upload = Upload;
    this.getSelects();
    this.getBaseUrl();
    this.edit = false;
    this.userData = {};
    this.countries = countryList;
  }

  getSelects() {
    this.Restangular.oneUrl('select', '/api/v1/admin/users/profile_selects').get().then(
      (response)=> {
        this.genders = response.genders;
        this.educational_attainments = response.educational_attainments;
      }
    );
  }
  editFn(data) {
    if(this.edit){
      this.submit(data);
    } else {
      this.edit = true;
      this.avatar = data.avatar.url;
    }
  }
  submit(data){
    this.baseLephanaUser = this.Restangular.all('/api/v1/auth/');
    this.userData=data;
    this.sending = true;
    this.baseLephanaUser.customPUT(this.userData).then(()=>{
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

  getBaseUrl(){
    let BASE_API_PATH;
    switch(this.$location.host()){
      case 'localhost':
        BASE_API_PATH = 'http://localhost:3000';
      break;
      default:
        BASE_API_PATH = 'http://ap2.dev.akra.net';
    }
  this.baseUrl = BASE_API_PATH;
  }
}

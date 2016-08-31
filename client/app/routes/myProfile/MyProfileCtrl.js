export default class MyProfileCtrl {
  constructor($location, $mdSidenav, Restangular, $state, $scope, $mdDialog, countryList, toastr, Upload) {
    "ngInject";
    this.$location = $location;
    this.$state = $state;
    this.$mdSidenav = $mdSidenav;
    this.$mdDialog = $mdDialog;
    this.Restangular = Restangular;
    this.countries = countryList;
    this.toastr = toastr;
    this.Upload = Upload;
    this.getSelects();
    this.edit = false;
    this.userData = {};
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
    this.avatar = null;
  }
}

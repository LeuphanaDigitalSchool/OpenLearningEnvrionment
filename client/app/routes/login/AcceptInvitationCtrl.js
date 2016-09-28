export default class AcceptInvitationCtrl {
  constructor($location, $stateParams, Restangular, toastr, countryList, Upload, $state, $mdDialog){
    "ngInject";
    this.$location = $location;
    this.Restangular = Restangular;
    this.toastr = toastr;
    this.$state = $state;
    this.$mdDialog = $mdDialog;
    this.Upload = Upload;
    this.$stateParams = $stateParams;
    this.invitationToken = this.$stateParams.token;
    this.countries = countryList;
    this.baseAcceptInvitationUrl = this.Restangular.all('/api/v1/auth/invitation');
    this.regulationsApi = this.Restangular.oneUrl('files', '/api/v1/admin/regulations');
    this.head = {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        };
    this.initialData();
    this.checkIfTokenIsValid();
    this.user.invitation_token = this.invitationToken;
    this.getRegulations();
  }

  checkIfTokenIsValid() {
    this.Restangular.oneUrl('accept', '/api/v1/auth/invitation/accept?invitation_token=' + this.invitationToken).get().then(
      (response)=>{
        this.getSelects();
      }, (error)=>{
      if(error.status === 406) {
        this.toastr.error('Invalid Token', 'Error');
        this.$state.go('login');
      }
    });
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

  handleError(form, data){
    if(this.user.password !== this.user.password_confirmation) {
      this.toastr.error('Password Must Match', 'Error');
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
  initialData() {
    this.send = true;
    this.sendData = {};
    this.user = {};
  }

  submit(form, data){
    this.checkUserRegulations();
    this.errors = 0;
    this.handleError(form, data);
    if(this.errors === 0) {
      this.send = false;
      this.baseAcceptInvitationUrl.customPUT({'invitation_token': this.invitationToken, 'user': this.user},'',{}, this.head).then(()=>{
        this.toastr.success('Now you can login', 'Success');
        this.$state.go('login');
        this.initialData();
      }, (response)=> {
        this.send = true;
        console.log(response);
        let status = response.statusText;
        this.toastr.error(status, 'Error');
      });
    }
  }

  getRegulations() {
    this.regulationsApi.get().then(
      (response)=>{
        this.regulations = response.regulations;
    });
  }
  checkUserRegulations() {
    this.user.terms_and_conditions = this.regulationId[1];
    this.user.data_privacy = this.regulationId[2];
    this.user.honor_code = this.regulationId[3];
  }
}

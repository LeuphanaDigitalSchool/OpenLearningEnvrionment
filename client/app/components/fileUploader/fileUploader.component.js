class FileUploaderCtrl {
  constructor($mdDialog, $stateParams, $rootScope, Upload, Restangular, toastr, $auth) {
    "ngInject";
    this.$rootScope = $rootScope;
    this.$mdDialog = $mdDialog;
    this.Upload = Upload;
    this.toastr = toastr;
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.$auth = $auth;
    this.CurrentUser = null;
    this.courseId = $stateParams.id;
    this.coursesApi = this.Restangular.oneUrl('courses', '/api/v1/courses/'+this.$stateParams.id);

    this.storageTypes = [
      'File',
      'Link'
    ];

    this.initialData();
    this.checkCoursePermission();
    this.getCourse();
    this.getCurrentUser();
  }

  checkCoursePermission(){
    this.acceptFile = '.jpg,.pdf,.mp3,.mp4';
  }

  upload(file, errFiles, $event) {
    if (file) {
      this.uploading = true;
      this.fileName = file.name;
      file.upload = this.Upload.base64DataUrl(file);
      file.upload.then( (response) => {
        this.uploading = false;
        this.storage.file = response;
        this.checkWhatCanBeAddedToSpecificPhase();
      }, (response)=> {
        console.log('response', response);
      });
    }
  }

  clear() {
    this.fileName = null;
    this.storage.file = {};
  }
  cancel(){
    this.$mdDialog.cancel();
  }

  submit() {
    this.sending = true;
    if(this.phaseData)this.pushPhase();
    this.storage.source = 'file';
    this.storage.name = this.fileName;
    this.storage.user_id = this.$rootScope.user.id;
    this.data.storage = this.storage;
    this.coursesApi.customPOST(this.data,'storages')
    .then((response)=>{
        this.clear();
        this.cancel();
        this.toastr.success('You have successfully added new storage', 'Success');
        this.$rootScope.$broadcast('storage:created');
    })
    .catch((err)=>{
       this.toastr.error(err, 'Error');
    });
  }

  getCourse() {
    this.coursesApi.get().then(
      (response)=>{
        this.phases = response.course.course_phases;
    });
  }

  pushPhase() {
    this.storage.course_phase_ids = [];
    for (var k in this.phaseData) this.storage.course_phase_ids.push(k);
  }
  initialData() {
    this.phaseData = null;
    this.data = {};
    this.storage = {};
    this.storage.course_phase_ids = {};
  }

  getCurrentUser() {
    this.$auth.validateUser().then((data) => {
      this.CurrentUser = data;
    });
  }

  checkWhatCanBeAddedToSpecificPhase() {
    if(this.storage.storageType === 'url')
      this.checkToWhichPhaseUserCanAddUrl();
    else if(this.storage.storageType === 'file')
      this.checkToWhichPhaseUserCanAddFile();
  }

  checkToWhichPhaseUserCanAddUrl() {
    this.phases.forEach((phase) => {
      phase.course_phase_preferences_attributes.forEach((attr) => {
        if( attr.role_id === this.CurrentUser.role_id )
          phase.disabled = !attr.embed_external_links;
      });
    });
  }

  checkToWhichPhaseUserCanAddFile() {
    this.phases.forEach((phase) => {
      phase.course_phase_preferences_attributes.forEach((attr) => {
        if( attr.role_id === this.CurrentUser.role_id ) {
          phase.disabled = this.compareFileTypeWithAttrField(this.file.type, attr);
        }
      });
    });
  }

  compareFileTypeWithAttrField(type, attr) {

    let output;
    switch(type) {
      case 'image/jpeg':
        output = !attr.upload_jpg;
        break;
      case 'application/pdf':
        output = !attr.upload_pdf;
        break;
      case 'video/mp4':
        output = !attr.upload_mp4;
        break;
      case 'audio/mp3':
        output = !attr.upload_mp3;
        break;
      default:
        output = false;
    }
    return output;
  }

  checkIfUserSelectAtLeatOnePhase() {
    this.UserSelectAtLeatOnePhase = false;
    for(let phase in this.phaseData) {
      this.UserSelectAtLeatOnePhase = this.UserSelectAtLeatOnePhase || this.phaseData[phase];
    }
  }


}

let fileUploader = {
  template: require('./fileUploader.html'),
  controller: FileUploaderCtrl,
  bindings: {
    images: '=',
    userId: '=',
  }
};

export default fileUploader;

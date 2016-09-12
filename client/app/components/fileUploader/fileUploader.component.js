class FileUploaderCtrl {
  constructor($mdDialog, $stateParams, $rootScope, Upload, Restangular, toastr) {
    "ngInject";
    this.$rootScope = $rootScope;
    this.$mdDialog = $mdDialog;
    this.Upload = Upload;
    this.toastr = toastr;
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.courseId = $stateParams.id;
    this.coursesApi = this.Restangular.oneUrl('courses', '/api/v1/courses/'+this.$stateParams.id);
    this.initialData();
    this.checkCoursePermission();
    this.getCourse();
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
        this.toastr.success('You have successfully added new file', 'Success');
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
    for (var i = 1; i <= 6; i++) {
      if(this.phaseData[i]){
        this.storage.course_phase_ids.push(i);
      }
    }
  }
  initialData() {
    this.phaseData = null;
    this.data = {};
    this.storage = {};
    this.storage.course_phase_ids = {};
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

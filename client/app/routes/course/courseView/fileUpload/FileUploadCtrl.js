export default class CourseViewCtrl {
  constructor($mdDialog, Upload) {
    "ngInject";
    this.$mdDialog = $mdDialog;
    this.Upload = Upload;
    this.checkCoursePermission();
  }
  cancel(){
    console.log('cancel');
    this.$mdDialog.cancel();
  }
  checkCoursePermission(){
    this.acceptFile = 'image/*|.pdf|.mp3|.mp4';
  }
  upload(file, errFiles, $event) {
    if (file) {
      this.uploading = true;
      file.upload = this.Upload.base64DataUrl(file);
      file.upload.then( (response) => {
        this.uploading = false;
        this.file = response;
      }, (response)=> {
        console.log('response', response);
      });
    }
  }
}

export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.courseId = this.$stateParams.id - 1;
    this.$mdDialog = $mdDialog;
  }

  addNewFile(ev){
    this.$mdDialog.show({
      template: require('./fileUpload/fileUpload.html'),
      controller: 'FileUploadCtrl',
      controllerAs: 'FileUpload',
      targetEvent: ev,
      clickOutsideToClose: false
    });
  }
}

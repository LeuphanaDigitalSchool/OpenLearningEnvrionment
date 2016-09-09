export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams, Restangular) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.courseId = this.$stateParams.id - 1;
    this.$mdDialog = $mdDialog;
    this.courseData = {};
  }

  addNewFile(ev){
    this.$mdDialog.show({
      template: '<file-uploader class="file-uploader" userId="CourseView.userId"></file-uploader>',
      targetEvent: ev,
      clickOutsideToClose: false
    });
  }
}

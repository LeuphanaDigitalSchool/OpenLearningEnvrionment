export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.courseId = this.$stateParams.id - 1;
    this.$mdDialog = $mdDialog;
  }

  addNewFile(ev){
    this.$mdDialog.show({
      template: require('./addNewFile.html'),
      targetEvent: ev,
      clickOutsideToClose: false
    });
  }
}

export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams, Restangular, toastr, $scope) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.toastr = toastr;
    this.courseId = this.$stateParams.id;
    this.$mdDialog = $mdDialog;
    this.courseData = {};
    this.$scope = $scope;
    this.phasesApi = this.Restangular.oneUrl('course', '/api/v1/courses/'+this.courseId);

    this.getCourse();
    this.addListeners();
  }

  addNewFile(ev){
    this.$mdDialog.show({
      template: '<file-uploader class="file-uploader" userId="CourseView.userId"></file-uploader>',
      targetEvent: ev,
      clickOutsideToClose: false
    });
  }

  getCourse(){
    this.phasesApi.get().then((response)=>{
      this.course = response.course;
      this.findActiveTabIndex();
    });
  }

  findActiveTabIndex() {
    this.activeTabIndex = _.findIndex(this.course.course_phases, { active: true});
  }

  removeFile(courseId, storageId) {
    this.phasesApi.one('storages', storageId).remove().then(()=>{
      this.toastr.success('You have successfully removed this file', 'Success');
      this.$scope.$broadcast('storage:deleted');
    });
  }

  addListeners() {
    this.$scope.$on('storage:created', this.getCourse.bind(this));
    this.$scope.$on('storage:deleted', this.getCourse.bind(this));
  }
}

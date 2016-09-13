export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams, $rootScope, Restangular, toastr) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.toastr = toastr;
    this.courseId = this.$stateParams.id - 1;
    this.$mdDialog = $mdDialog;
    this.courseData = {};
    this.$rootScope = $rootScope;
    this.phasesApi = this.Restangular.oneUrl('courses', '/api/v1/courses/'+this.$stateParams.id);
    this.getPhases();
    this.addListeners();
  }

  addNewFile(ev){
    this.$mdDialog.show({
      template: '<file-uploader class="file-uploader" userId="CourseView.userId"></file-uploader>',
      targetEvent: ev,
      clickOutsideToClose: false
    });
  }
  getPhases(){
    this.phasesApi.customGET('phase/active').then((response)=>{
      this.files = response.course_phase.storages;
    });
  }

  removeFile(courseId, storageId) {
    this.phasesApi.one('storages', storageId).remove().then(()=>{
      this.toastr.success('You have successfully removed this file', 'Success');
      this.$rootScope.$broadcast('storage:deleted');
    });
  }

  addListeners() {
      this.$rootScope.$on('storage:created', this.getPhases.bind(this));
      this.$rootScope.$on('storage:deleted', this.getPhases.bind(this));
    }
}

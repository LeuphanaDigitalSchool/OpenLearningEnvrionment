export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams, $rootScope, Restangular, toastr) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.toastr = toastr;
    this.courseId = this.$stateParams.id;
    this.$mdDialog = $mdDialog;
    this.courseData = {};
    this.$rootScope = $rootScope;
    this.phasesApi = this.Restangular.oneUrl('course', '/api/v1/courses/'+this.courseId);
    this.getCourse();
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
  getCourse(){
    this.phasesApi.get().then((response)=>{
      this.course = response.course;
      console.log(this.course);
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

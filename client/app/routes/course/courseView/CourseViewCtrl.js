export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams, Restangular) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.courseId = this.$stateParams.id - 1;
    this.$mdDialog = $mdDialog;
    this.courseData = {};
    this.phasesApi = this.Restangular.oneUrl('courses', '/api/v1/courses/'+this.$stateParams.id);
    this.getPhases();
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
      console.log('response', response);
      this.files = response.course_phase.storages;
      console.log('this.files', this.files);
    });
  }
}

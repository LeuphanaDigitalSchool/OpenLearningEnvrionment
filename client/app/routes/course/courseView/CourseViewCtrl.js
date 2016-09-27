export default class CourseViewCtrl {
  constructor($mdDialog, $stateParams, Restangular, toastr, $scope, $auth) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.Restangular = Restangular;
    this.toastr = toastr;
    this.$auth = $auth;
    this.courseId = this.$stateParams.id;
    this.$mdDialog = $mdDialog;
    this.courseData = {};
    this.canDeleteResources ={};
    this.$scope = $scope;
    this.phasesApi = this.Restangular.oneUrl('course', '/api/v1/courses/'+this.courseId);

    this.getCourse();
    this.addListeners();
    this.getCurrentUser();
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
      console.log('this.course', this.course);
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

  editStorage(courseId, phaseId, storage) {
    function DialogCtrl($scope, storage) {
      "ngInject";
      $scope.storage = storage;
      $scope.courseId = +courseId;
      $scope.phaseId = +phaseId;
    }

    this.$mdDialog.show({
      template: `<edit-storage storage="storage" course-id="courseId", phase-id="phaseId"><edit-storage>`,
      clickOutsideToClose: false,
      controller: DialogCtrl,
      locals: {
        storage: storage,
        courseId: courseId,
        pahseId: phaseId
      }
    });
  }

  addListeners() {
    this.$scope.$on('storage:created', this.getCourse.bind(this));
    this.$scope.$on('storage:deleted', this.getCourse.bind(this));
  }

  getCurrentUser() {
    this.$auth.validateUser().then((data) => {
      this.CurrentUser = data;
    });
  }

  checkUserPermission(phaseId){
    this.userPermission = {};
    this.userPermission[phaseId] = _.findIndex(this.course.course_phases[phaseId].course_phase_preferences_attributes, {'role_id': this.CurrentUser.role_id});
    this.canDeleteResources[phaseId] = this.course.course_phases[phaseId].course_phase_preferences_attributes[this.userPermission[phaseId]].resources_del;
  }
}

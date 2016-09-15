export default class CourseParticipantsCtrl {
  constructor(Restangular, $stateParams) {
    "ngInject";
    this.Restangular = Restangular;
    this.courseId = $stateParams.id;
    this.participantsApi = this.Restangular.oneUrl('participants', '/api/v1/courses/'+this.courseId+'/participants');
    this.getParticipants();
  }

  getParticipants() {
    this.participantsApi.get().then(
      (response)=>{
        this.participants = response.users;
    });
  }
}

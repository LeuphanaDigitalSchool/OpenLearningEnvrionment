export default class CourseCrtl {
  constructor(Restangular, $stateParams) {
    "ngInject";
    this.Restangular = Restangular;
    this.$stateParams = $stateParams;
    this.courseId = $stateParams.id;
    this.coursesApi = this.Restangular.oneUrl('course', '/api/v1/courses/'+this.courseId);
    this.course();
  }
  course() {
    this.coursesApi.get().then(
    (response)=>{
      this.course = response.course;
      console.log('this.course', this.course);
    });
  }
}

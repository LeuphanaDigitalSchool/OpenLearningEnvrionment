export default class SideNavCtrl {
  constructor(Restangular, $interval) {
    "ngInject";
    this.Restangular = Restangular;
    this.coursesApi = this.Restangular.oneUrl('courses', '/api/v1/courses');
    this.$interval = $interval;

    this.getCoursesList();
    this.startCourseInterval();
}

  getCoursesList() {
    this.coursesApi.get().then(
      (response)=>{
        this.coursesList = response.courses;
    });
  }

  startCourseInterval() {
    let courseInterval = this.$interval(this.getCoursesList.bind(this), 1000);
    this.$onDestroy = () => {
      this.$interval.cancel(courseInterval);
    };
  }
}

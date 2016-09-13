export default class SideNavCtrl {
  constructor(Restangular) {
    "ngInject";
    this.Restangular = Restangular;
    this.coursesApi = this.Restangular.oneUrl('courses', '/api/v1/courses');
    this.getCoursesList();
}

  getCoursesList() {
    this.coursesApi.get().then(
      (response)=>{
        this.coursesList = response.courses;
    });
  }
}

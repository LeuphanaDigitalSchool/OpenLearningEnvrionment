export default class CoursesListCtrl {
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

  deleteCourse(courseId){
    this.Restangular.oneUrl('courses', '/api/v1/courses/'+courseId).remove().then(()=> {
      this.getCoursesList();
    });
  }
}

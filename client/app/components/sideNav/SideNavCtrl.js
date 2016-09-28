export default class SideNavCtrl {
  constructor(Restangular, $rootScope) {
    "ngInject";
    this.Restangular = Restangular;
    this.coursesApi = this.Restangular.oneUrl('courses', '/api/v1/courses');
    this.$rootScope = $rootScope;
    this.coursesList= [];
    this.subMenuClass = '';

    this.getCoursesList();
    this.addListeners();
    // this.startCourseInterval();
}

  getCoursesList() {
    this.coursesApi.get().then(
      (response)=>{
        if(this.coursesList.length !== response.courses.length)
          this.coursesList = response.courses;
    });
  }

  addListeners() {
      this.$rootScope.$on('course:created', this.getCoursesList.bind(this));
    }

  startCourseInterval() {
    let courseInterval = this.$interval(this.getCoursesList.bind(this), 1000);
    this.$onDestroy = () => {
      this.$interval.cancel(courseInterval);
    };
  }

  changeClass() {
    if (this.subMenuClass === 'active') {
      this.subMenuClass = '';
    } else {
      this.subMenuClass = 'active';
    }
  }
}

export default class ProfileCtrl {
  constructor($stateParams, $mdSidenav, Restangular, $state, $scope, countryList) {
    "ngInject";
    this.$stateParams = $stateParams;
    this.userId = $stateParams.id;
    this.$state = $state;
    this.$mdSidenav = $mdSidenav;
    this.Restangular = Restangular;
    this.countries = countryList;
    this.getSelects();
    this.profile = this.Restangular.one('/api/v1/profile/', this.userId).get().$object;
    this.getUserCourses();
  }

  getSelects() {
    this.Restangular.oneUrl('select', '/api/v1/admin/users/profile_selects').get().then(
      (response)=> {
        this.genders = response.genders;
        this.educational_attainments = response.educational_attainments;
      }
    );
  }

  getUserCourses() {
    this.Restangular.oneUrl('courses', '/api/v1/courses').get().then(
      (response)=> {
        this.userCourses = response.courses;
      }
    );
  }
}

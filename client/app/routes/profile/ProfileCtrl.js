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
        this.genders = [
          { 'value': '0', 'name': "Male"}, 
          { 'value': '1', 'name': "Female"}, 
          { 'value': '2', 'name': "I'd rather not say"} 
        ];
        this.educational_attainments = [
          { 'value': '0', 'name': "I'd rather not say" }, 
          { 'value': '1', 'name': "High School" }, 
          { 'value': '2', 'name': "Bachelor's Degree" }, 
          { 'value': '3', 'name': "Master's Degree" }, 
          { 'value': '4', 'name': "PhD" }, 
          { 'value': '5', 'name': "Professor" }
        ];
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

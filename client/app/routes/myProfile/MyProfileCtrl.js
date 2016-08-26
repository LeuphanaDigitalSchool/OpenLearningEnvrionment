export default class MyProfileCtrl {
  constructor($location, $mdSidenav, Restangular, $state, $scope, countryList) {
    "ngInject";
    this.$location = $location;
    this.$state = $state;
    this.$mdSidenav = $mdSidenav;
    this.Restangular = Restangular;
    this.countries = countryList;
    this.getSelects();
  }

  getSelects() {
    this.Restangular.oneUrl('select', '/api/v1/admin/users/profile_selects').get().then(
      (response)=> {
        this.genders = response.genders;
        this.educational_attainments = response.educational_attainments;
      }
    );
  }
}

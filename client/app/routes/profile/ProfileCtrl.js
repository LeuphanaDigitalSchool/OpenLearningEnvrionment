export default class ProfileCtrl {
  constructor($mdSidenav, Restangular, $state, $scope) {
    "ngInject";
    this.$state = $state;
    this.$mdSidenav = $mdSidenav;
    this.Restangular = Restangular;
    this.profile = this.Restangular.one('/api/v1/admin/users/students/', '9').get().$object;
  }
}

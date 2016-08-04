export default class HomeCtrl {
  constructor($http, $mdSidenav) {
    "ngInject";
    this.$http = $http;
    this.$mdSidenav = $mdSidenav;
  }

  getUsers(){
    this.$http
    .get('/users')
    .then(response => this.users = response.data);
  }

  openLeftMenu() {
      this.$mdSidenav('left').toggle();
  }
}

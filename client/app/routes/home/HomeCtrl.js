export default class HomeCtrl {
  constructor($http, $mdSidenav, appConfig) {
    "ngInject";
    this.$http = $http;
    this.$mdSidenav = $mdSidenav;
    this.appConfig = appConfig;
  }

  getUsers(){
    this.$http
    .get('/users')
    .then(response => this.users = response.data);
  }

  openLeftMenu() {
      console.log('test open left');
      this.$mdSidenav('left').toggle();
  }
}

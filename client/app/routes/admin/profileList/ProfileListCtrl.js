export default class ProfileListCtrl {
  constructor($mdSidenav, Restangular, $state, $scope, $location) {
    "ngInject";
    this.$state = $state;
    this.$mdSidenav = $mdSidenav;
    this.Restangular = Restangular;
    this.usersList();
    this.location = $location;
}

  refreshList() {
    this.Restangular.oneUrl('users', '/api/v1/admin/users').get().then(
      (response)=>{
        this.usersList = response.users;
    });
  }

  usersList() {
    this.Restangular.oneUrl('users', '/api/v1/admin/users').get().then(
      (response)=>{
        this.usersList = response.users;
    });
  }

  showProfile(userId) {
    this.location.path('/profile/' + userId);
  }

  deleteProfile(userId) {
    this.Restangular.oneUrl('users', '/api/v1/users/'+userId).remove().then(()=> {
      this.usersList();
    });
  }
}

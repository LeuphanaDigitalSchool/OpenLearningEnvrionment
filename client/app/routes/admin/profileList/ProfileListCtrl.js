export default class ProfileListCtrl {
  constructor($mdSidenav, $rootScope, Restangular, $state, $scope, $location) {
    "ngInject";
    this.$state = $state;
    this.$mdSidenav = $mdSidenav;
    this.Restangular = Restangular;
    this.location = $location;
    this.$rootScope = $rootScope;
    this.userApi = Restangular.all('/api/v1/admin/users/');
    this.usersList();
    this.addListeners();
}

  addListeners() {
      this.$rootScope.$on('user:created', this.usersList.bind(this));
      this.$rootScope.$on('user:deleted', this.usersList.bind(this));
    }

  deleteProfile(userId) {
    this.Restangular.oneUrl('users', '/api/v1/admin/users/users/'+userId).remove().then((response)=> {
      this.$rootScope.$broadcast('user:deleted');
    });
  }

  usersList() {
    this.userApi.customGET().then(
      (response)=>{
        this.usersList = response.users;
    });
  }

  showProfile(userId) {
    this.location.path('/profile/' + userId);
  }
}

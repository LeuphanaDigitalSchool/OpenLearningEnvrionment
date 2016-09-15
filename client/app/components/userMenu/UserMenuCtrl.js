export default class UserMenuCtrl {
  constructor($auth, $state, $cookies) {
    "ngInject";
    this.$auth = $auth;
    this.$state = $state;
    this.$cookies = $cookies;
  }
  logout() {
    this.$auth.signOut()
      .then(
        () => {
          this.$state.go('login');
        },
        () => {
          this.$cookies.remove('auth_headers');
          this.$state.go('login');
        }
      );
  }
  admin() {
    this.$state.go('home.admin');
  }
  profile() {
    this.$state.go('home.profile');
  }
  openMenu($mdOpenMenu, ev) {
    let originatorEv;
    originatorEv = ev;
    $mdOpenMenu(ev);
  }
}

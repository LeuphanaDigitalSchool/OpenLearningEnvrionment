export default class UserMenuCtrl {
  constructor($auth, $state) {
    "ngInject";
    this.$auth = $auth;
    this.$state = $state;
  }
  logout() {
    this.$auth.signOut()
      .then(()=>{
        this.$state.go('login');
      });
  }
  openMenu($mdOpenMenu, ev) {
    let originatorEv;
    originatorEv = ev;
    $mdOpenMenu(ev);
  }
}

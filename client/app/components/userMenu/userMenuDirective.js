export default function UserMenuDirective() {
  "ngInject";
  return {
    template: require('./userMenu.html'),
    restrict: 'E',
    controller: 'UserMenuCtrl',
    controllerAs: 'UserMenuCtrl'
  };
}

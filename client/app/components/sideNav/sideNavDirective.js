export default function sideNavDirective() {
  return {
    template: require('./sideNav.html'),
    restrict: 'E',
    controller: 'SideNavCtrl',
    controllerAs: 'SideNavCtrl'
  };
}

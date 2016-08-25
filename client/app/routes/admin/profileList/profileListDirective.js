export default function ProfileListDirective() {
  return {
    template: require('./profileList.html'),
    restrict: 'E',
    controller: 'ProfileListCtrl',
    controllerAs: 'ProfileListCtrl'
  };
}

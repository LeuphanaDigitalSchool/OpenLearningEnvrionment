export default function permissionsDirective() {
  "ngInject";
  return {
    template: require('./permissions.html'),
    restrict: 'E',
    controller: 'PermissionsCtrl',
    controllerAs: 'Permission'
  };
}

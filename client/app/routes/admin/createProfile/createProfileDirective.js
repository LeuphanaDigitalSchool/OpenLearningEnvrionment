export default function CreateProfileDirective() {
  return {
    template: require('./createProfile.html'),
    restrict: 'E',
    controller: 'CreateProfileCtrl',
    controllerAs: 'create'
  };
}

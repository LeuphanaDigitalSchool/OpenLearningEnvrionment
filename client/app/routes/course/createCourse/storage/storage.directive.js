export default function storageDirective() {
  "ngInject";
  return {
    template: require('./storage.html'),
    restrict: 'E',
    controller: 'StorageCtrl',
    controllerAs: 'Storage'
  };
}

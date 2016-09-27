export default function publishingDirective() {
  "ngInject";
  return {
    template: require('./publishing.html'),
    restrict: 'E',
    controller: 'PublishingCtrl',
    controllerAs: 'Publishing'
  };
}

export default function communicationDirective() {
  "ngInject";
  return {
    template: require('./communication.html'),
    restrict: 'E'
  };
}

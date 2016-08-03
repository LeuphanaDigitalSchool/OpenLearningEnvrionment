export default function mainNavbarDirective() {
  "ngInject";
  return {
    template: require('./mainNavbar.html'),
    restrict: 'E'
  };
}

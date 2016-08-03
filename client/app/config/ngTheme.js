export default function ngConfig($mdThemingProvider, $mdIconProvider) {
  "ngInject";
  $mdThemingProvider.theme('default')
    .primaryPalette('blue')
    .accentPalette('orange');
}

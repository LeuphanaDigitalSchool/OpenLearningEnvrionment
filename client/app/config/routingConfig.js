export default function routingConfig($urlRouterProvider, $locationProvider) {
  "ngInject";
  $locationProvider.html5Mode(false);
  $urlRouterProvider.otherwise('/');
}

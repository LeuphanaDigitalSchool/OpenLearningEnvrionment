export default function routes($stateProvider) {
  "ngInject";
  $stateProvider
    .state('login', {
      url: '/login',
      template: require('./routes/login/login.html'),
      controller: 'LoginCtrl',
      controllerAs: 'LoginCtrl'
    })

    .state('home', {
      url: '/',
      template: require('./routes/home/home.html'),
      controller: 'HomeCtrl',
      controllerAs: 'HomeCtrl'
    });
}

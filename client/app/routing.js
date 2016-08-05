export default function routing($stateProvider) {
  "ngInject";
  $stateProvider
    .state('login', {
      url: '/login',
      template: require('./routes/login/login.html'),
      controller: 'LoginCtrl',
      controllerAs: 'LoginCtrl'
    })
    .state('publicRegistration', {
      url:'/publicRegistration',
      template: require('./routes/registerPublicUser/registerPublicUser.html'),
      controller: 'HomeCtrl',
      controllerAs: 'HomeCtrl',
    })

    .state('home', {
      url: '/',
      template: require('./routes/home/home.html'),
      controller: 'HomeCtrl',
      controllerAs: 'HomeCtrl',
      resolve: {
          auth: function ($auth, $location) {
              return $auth.validateUser().catch(function(err){
                  $location.path('/login');
              });
          }
      }
    });
}

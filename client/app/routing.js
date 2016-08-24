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
      controller: 'RegisterPublicUserCtrl',
      controllerAs: 'RegisterPublicUserCtrl'
    })
    .state('acceptInvitation', {
      url:'/acceptInvitation',
      template: require('./routes/login/acceptInvitation.html'),
      controller: 'AcceptInvitationCtrl',
      controllerAs: 'Accept'
    })

    .state('home', {
      url: '/',
      template: require('./routes/home/home.html'),
      controller: 'HomeCtrl',
      controllerAs: 'HomeCtrl',
      resolve: {
          auth: function ($auth, $location) {
             $auth.validateUser();
              return $auth.validateUser().catch(function(err){
                  $location.path('/login');
              });
          }
      }
    })
    .state('home.admin', {
      url: 'admin',
      template: require('./routes/admin/admin.html'),
    });
}

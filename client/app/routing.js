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
      url:'/acceptInvitation/:token',
      template: require('./routes/login/acceptInvitation.html'),
      controller: 'AcceptInvitationCtrl',
      controllerAs: 'Accept'
    })
    .state('forgottenPassword', {
      url:'/forgottenPassword',
      template: require('./routes/forgottenPassword/forgottenPassword.html'),
      controller: 'ForgottenPasswordCtrl',
      controllerAs: 'ForgottenPasswordCtrl'
    })
    .state('resetPassword', {
      url:'/resetPassword/:token',
      template: require('./routes/forgottenPassword/resetPassword.html'),
      controller: 'ResetPasswordCtrl',
      controllerAs: 'ResetPassword'
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
      resolve: {
        permission: function ($auth, $location) {
          return $auth.validateUser().then((response) => {
            if(response.role_id !== 6) $location.path('permission-denied');
          });
        }
      }
    })

    .state('home.myProfile', {
      url: 'myProfile',
      template: require('./routes/myProfile/myProfile.html'),
      controller: 'MyProfileCtrl',
      controllerAs: 'MyProfileCtrl'
    })
    .state('home.profile', {
      url: 'profile/:id',
      template: require('./routes/profile/profile.html'),
      controller: 'ProfileCtrl',
      controllerAs: 'ProfileCtrl'
    })
    .state('home.create-course', {
      url: 'create-course',
      template: require('./routes/course/createCourse/createCourse.html'),
      controller: 'CreateCourseCtrl',
      controllerAs: 'Create',
      resolve: {
        permission: function ($auth, $location) {
          return $auth.validateUser().then((response) => {
            if(response.role_id < 4) $location.path('permission-denied');
          });
        }
      }
    })
    .state('home.courses-list', {
      url: 'courses-list',
      template: require('./routes/course/coursesList/coursesList.html'),
      controller: 'CoursesListCtrl',
      controllerAs: 'Courses',
      resolve: {
        permission: function ($auth, $location) {
          return $auth.validateUser().then((response) => {
            if(response.role_id < 4) $location.path('permission-denied');
          });
        }
      }
    })
    .state('home.course', {
      url: 'course/:id',
      template: require('./routes/course/course.html'),
      controller: 'CourseCrtl',
      controllerAs: 'Course',
      resolve: {
        permission: function ($auth, $location) {
          return $auth.validateUser().then((response) => {
            if(response.role_id < 4) $location.path('permission-denied');
          });
        }
      }
    })
    .state('home.course-view', {
      url: 'view/course/:id',
      template: require('./routes/course/courseView/courseView.html'),
      controller: 'CourseViewCtrl',
      controllerAs: 'CourseView'
    })
    .state('home.course-participants', {
      url: 'course/:id/participants',
      template: require('./routes/course/courseParticipants/courseParticipants.html'),
      controller: 'CourseParticipantsCtrl',
      controllerAs: 'CourseParticipants'
    })
    .state('home.soon-page', {
      url: 'soon',
      template: require('./routes/soon/soon.html'),
      controller: 'SoonCtrl',
      controllerAs: 'Soon'
    })
    .state('home.permission-denied', {
      url: 'permission-denied',
      template: require('./routes/permissionDenied/permissionDenied.html'),
      controller: 'PermissionDeniedCtrl',
      controllerAs: 'permissionDenied'
    });
}

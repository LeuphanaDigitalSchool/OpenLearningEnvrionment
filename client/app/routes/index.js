import angular from 'angular';

import home from './home/';
import login from './login';
import registerPublicUser from './registerPublicUser';
import forgottenPassword from './forgottenPassword';
// import resetPassword from './resetPassword';
import admin from './admin';
import countryList from '../lib/ng-country-list.js';
import myProfile from './myProfile';
import profile from './profile';
import course from './course';

export default angular.module('app.routes', [
    home,
    login,
    registerPublicUser,
    forgottenPassword,
    // resetPassword,
    admin,
    myProfile,
    profile,
    course
  ])
  .constant('countryList', countryList)
  .name;

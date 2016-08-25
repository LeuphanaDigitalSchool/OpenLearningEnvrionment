import angular from 'angular';

import home from './home/';
import login from './login';
import registerPublicUser from './registerPublicUser';
import admin from './admin';
import countryList from '../lib/ng-country-list.js';
import myProfile from './myProfile';
import profile from './profile';

export default angular.module('app.routes', [
    home,
    login,
    registerPublicUser,
    admin,
    myProfile,
    profile
  ])
  .constant('countryList', countryList)
  .name;

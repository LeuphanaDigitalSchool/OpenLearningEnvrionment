import angular from 'angular';

import home from './home/';
import login from './login';
import registerPublicUser from './registerPublicUser';
import admin from './admin';
import countryList from '../lib/ng-country-list.js';

export default angular.module('app.routes', [
    home,
    login,
    registerPublicUser,
    admin
  ])
  .constant('countryList', countryList)
  .name;

import angular from 'angular';

import home from './home/';
import login from './login';
import registerPublicUser from './registerPublicUser';
import admin from './admin';

export default angular.module('app.routes', [
    home,
    login,
    registerPublicUser,
    admin
  ]).name;

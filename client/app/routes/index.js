import angular from 'angular';

import home from './home/';
import login from './login';
import registerPublicUser from './registerPublicUser';

export default angular.module('app.routes', [
    home,
    login,
    registerPublicUser
  ]).name;

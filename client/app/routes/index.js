import angular from 'angular';

import home from './home/';
import login from './login';

export default angular.module('app.routes', [
    home,
    login
  ]).name;

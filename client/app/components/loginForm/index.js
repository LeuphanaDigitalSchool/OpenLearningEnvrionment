import angular from 'angular';
import ngtokenauth from '../../lib/ng-token-auth.min.js';
import uirouter from 'angular-ui-router';

import loginForm from './loginForm.component.js';

export default angular.module('app.components.loginForm', [uirouter, ngtokenauth])
  .component('loginForm', loginForm)
  .name;

import angular from 'angular';
import uirouter from 'angular-ui-router';
import angularMaterial from 'angular-material';

import userMenuDirective from './userMenuDirective';
import UserMenuCtrl from './UserMenuCtrl';

export default angular.module('app.components.userMenu', [uirouter, angularMaterial])
  .controller('UserMenuCtrl', UserMenuCtrl)
  .directive('userMenu', userMenuDirective)
  .name;

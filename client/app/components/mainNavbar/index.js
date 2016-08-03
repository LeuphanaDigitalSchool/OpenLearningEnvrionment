import angular from 'angular';
import uirouter from 'angular-ui-router';
import angularMaterial from 'angular-material';

import mainNavbarDirective from './mainNavbar.directive.js';

export default angular.module('app.components.mainNavbar', [uirouter, angularMaterial])
  .directive('mainNavbar', mainNavbarDirective)
  .name;

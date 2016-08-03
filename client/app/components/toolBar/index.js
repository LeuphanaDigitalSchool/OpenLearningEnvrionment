import angular from 'angular';
import uirouter from 'angular-ui-router';
import angularMaterial from 'angular-material';

import toolBarDirective from './toolBarDirective';

export default angular.module('app.components.toolBar', [uirouter, angularMaterial])
  .directive('toolBar', toolBarDirective)
  .name;

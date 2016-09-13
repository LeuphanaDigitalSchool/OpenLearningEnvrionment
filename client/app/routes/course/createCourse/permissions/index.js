import angular from 'angular';
import angularMaterial from 'angular-material';

import permissionsDirective from './permissions.directive';

export default angular.module('app.admin.course.permissions', [angularMaterial])
  .directive('permissionsDirective', permissionsDirective)
  .name;

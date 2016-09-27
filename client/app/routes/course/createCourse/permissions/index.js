import angular from 'angular';
import angularMaterial from 'angular-material';

import permissionsDirective from './permissions.directive';
import PermissionsCtrl from './PermissionsCtrl';

export default angular.module('app.admin.course.permissions', [angularMaterial])
  .directive('permissionsDirective', permissionsDirective)
  .controller('PermissionsCtrl', PermissionsCtrl)
  .name;

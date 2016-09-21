import angular from 'angular';
import angularMaterial from 'angular-material';

import PermissionDeniedCtrl from './PermissionDeniedCtrl';

export default angular.module('app.home.permission-denied', [angularMaterial])
  .controller('PermissionDeniedCtrl', PermissionDeniedCtrl)
  .name;

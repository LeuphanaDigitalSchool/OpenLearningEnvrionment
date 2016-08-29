import angular from 'angular';
import angularMaterial from 'angular-material';

import permissions from './permissions.component';

export default angular.module('app.admin.course.permissions', [angularMaterial])
  .component('permissions', permissions)
  .name;

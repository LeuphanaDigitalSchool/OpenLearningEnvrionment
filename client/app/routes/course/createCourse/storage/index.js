import angular from 'angular';
import angularMaterial from 'angular-material';

import storage from './storage.component';

export default angular.module('app.admin.course.storage', [angularMaterial])
  .component('storage', storage)
  .name;

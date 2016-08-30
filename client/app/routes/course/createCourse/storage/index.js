import angular from 'angular';
import angularMaterial from 'angular-material';

import storageDirective from './storage.directive';

export default angular.module('app.admin.course.storage', [angularMaterial])
  .directive('storageDirective', storageDirective)
  .name;

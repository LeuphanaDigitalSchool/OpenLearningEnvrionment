import angular from 'angular';
import angularMaterial from 'angular-material';

import storageDirective from './storage.directive';
import StorageCtrl from './StorageCtrl';

export default angular.module('app.admin.course.storage', [angularMaterial])
  .directive('storageDirective', storageDirective)
  .controller('StorageCtrl', StorageCtrl)
  .name;

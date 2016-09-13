import angular from 'angular';
import angularMaterial from 'angular-material';

import productivityDirective from './productivity.directive';
import personalWorkspace from './personalWorkspace/personalWorkspace.component';
import groupWorkspace from './groupWorkspace/groupWorkspace.component';

export default angular.module('app.admin.course.productivity', [angularMaterial])
  .directive('productivityDirective', productivityDirective)
  .component('personalWorkspace', personalWorkspace)
  .component('groupWorkspace', groupWorkspace)
  .name;

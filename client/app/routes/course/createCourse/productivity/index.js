import angular from 'angular';
import angularMaterial from 'angular-material';

import productivity from './productivity.component';
import personalWorkspace from './personalWorkspace/personalWorkspace.component';
import groupWorkspace from './groupWorkspace/groupWorkspace.component';

export default angular.module('app.admin.course.productivity', [angularMaterial])
  .component('productivity', productivity)
  .component('personalWorkspace', personalWorkspace)
  .component('groupWorkspace', groupWorkspace)
  .name;

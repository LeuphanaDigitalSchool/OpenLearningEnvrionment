import angular from 'angular';
import angularMaterial from 'angular-material';

import publishing from './publishing.component';

export default angular.module('app.admin.course.publishing', [angularMaterial])
  .component('publishing', publishing)
  .name;

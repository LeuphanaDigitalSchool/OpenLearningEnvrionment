import angular from 'angular';
import angularMaterial from 'angular-material';

import publishingDirective from './publishing.directive';

export default angular.module('app.admin.course.publishing', [angularMaterial])
  .directive('publishingDirective', publishingDirective)
  .name;

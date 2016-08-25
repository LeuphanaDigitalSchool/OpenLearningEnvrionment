import angular from 'angular';
import angularMaterial from 'angular-material';
import CreateCourseCtrl from './CreateCourseCtrl';

import communication from './communication';

export default angular.module('app.admin.course', [
  angularMaterial,
  communication
  ])
  .controller('CreateCourseCtrl', CreateCourseCtrl)
  .name;

import angular from 'angular';
import angularMaterial from 'angular-material';
import CreateCourseCtrl from './CreateCourseCtrl';

import communication from './communication';
import storage from './storage';

export default angular.module('app.admin.course', [
  angularMaterial,
  communication,
  storage
  ])
  .controller('CreateCourseCtrl', CreateCourseCtrl)
  .name;

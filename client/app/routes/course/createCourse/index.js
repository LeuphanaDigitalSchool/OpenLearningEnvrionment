import angular from 'angular';
import angularMaterial from 'angular-material';
import CreateCourseCtrl from './CreateCourseCtrl';

import communication from './communication';
import storage from './storage';
import productivity from './productivity';
import publishing from './publishing';
import permissions from './permissions';

export default angular.module('app.admin.course', [
  angularMaterial,
  communication,
  storage,
  productivity,
  publishing,
  permissions
  ])
  .controller('CreateCourseCtrl', CreateCourseCtrl)
  .name;

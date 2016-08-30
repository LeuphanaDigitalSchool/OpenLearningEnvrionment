import angular from 'angular';
import uirouter from 'angular-ui-router';

import CreateCourse from './createCourse';
import coursesList from './coursesList';
import CourseCrtl from './CourseCrtl';

export default angular.module('app.course', [
  uirouter,
  CreateCourse,
  coursesList
])
  .controller('CourseCrtl', CourseCrtl)
  .name;

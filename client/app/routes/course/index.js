import angular from 'angular';
import uirouter from 'angular-ui-router';

import CreateCourse from './createCourse';
import coursesList from './coursesList';
import CourseCrtl from './CourseCrtl';
import courseView from './courseView';
import courseParticipants from './courseParticipants';

export default angular.module('app.course', [
  uirouter,
  CreateCourse,
  coursesList,
  courseView,
  courseParticipants
])
  .controller('CourseCrtl', CourseCrtl)
  .name;

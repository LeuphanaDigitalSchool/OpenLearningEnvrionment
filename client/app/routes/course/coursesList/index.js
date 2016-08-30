import angular from 'angular';
import uirouter from 'angular-ui-router';

import CoursesListCtrl from './CoursesListCtrl';

export default angular.module('app.course.coursesList', [uirouter])
  .controller('CoursesListCtrl', CoursesListCtrl)
  .name;

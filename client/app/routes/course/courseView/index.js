import angular from 'angular';
import uirouter from 'angular-ui-router';

import CourseViewCtrl from './CourseViewCtrl';
import "./courseView.scss";

export default angular.module('app.course.courseView', [uirouter])
  .controller('CourseViewCtrl', CourseViewCtrl)
  .name;

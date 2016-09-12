import angular from 'angular';
import uirouter from 'angular-ui-router';

import CourseParticipantsCtrl from './CourseParticipantsCtrl';

export default angular.module('app.course.courseParticipants', [uirouter])
  .controller('CourseParticipantsCtrl', CourseParticipantsCtrl)
  .name;

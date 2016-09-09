import angular from 'angular';
import uirouter from 'angular-ui-router';

import CourseViewCtrl from './CourseViewCtrl';
import FileUploadCtrl from './fileUpload/FileUploadCtrl';

export default angular.module('app.course.courseView', [uirouter])
  .controller('CourseViewCtrl', CourseViewCtrl)
  .controller('FileUploadCtrl', FileUploadCtrl)
  .name;

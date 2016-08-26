import angular from 'angular';
import angularMaterial from 'angular-material';

import profileListDirective from './profileListDirective';
import ProfileListCtrl from './ProfileListCtrl';

export default angular.module('app.admin.profiles', [angularMaterial])
  .controller('ProfileListCtrl', ProfileListCtrl)
  .directive('profileListDirective', profileListDirective)
  .name;

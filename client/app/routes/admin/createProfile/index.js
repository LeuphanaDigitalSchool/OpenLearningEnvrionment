import angular from 'angular';
import angularMaterial from 'angular-material';

import createProfileDirective from './createProfileDirective';
import CreateProfileCtrl from './CreateProfileCtrl';

export default angular.module('app.admin.city', [angularMaterial])
  .controller('CreateProfileCtrl', CreateProfileCtrl)
  .directive('createProfileDirective', createProfileDirective)
  .name;

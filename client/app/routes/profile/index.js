import angular from 'angular';
import angularMaterial from 'angular-material';

import ProfileCtrl from './ProfileCtrl';

export default angular.module('app.home.profile', [angularMaterial])
  .controller('ProfileCtrl', ProfileCtrl)
  .name;

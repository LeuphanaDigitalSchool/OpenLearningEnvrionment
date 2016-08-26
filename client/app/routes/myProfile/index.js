import angular from 'angular';
import angularMaterial from 'angular-material';

import MyProfileCtrl from './MyProfileCtrl';

export default angular.module('app.home.myProfile', [angularMaterial])
  .controller('MyProfileCtrl', MyProfileCtrl)
  .name;

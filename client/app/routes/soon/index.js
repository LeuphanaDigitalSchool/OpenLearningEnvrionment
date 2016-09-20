import angular from 'angular';
import angularMaterial from 'angular-material';

import SoonCtrl from './SoonCtrl';

export default angular.module('app.home.soon', [angularMaterial])
  .controller('SoonCtrl', SoonCtrl)
  .name;

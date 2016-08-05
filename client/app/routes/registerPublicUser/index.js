import angular from 'angular';

import registerPublicUserCtrl from './registerPublicUserCtrl';

export default angular.module('app.registerPublicUser', [])
  .controller('registerPublicUserCtrl', registerPublicUserCtrl)
  .name;

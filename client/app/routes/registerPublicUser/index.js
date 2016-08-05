import angular from 'angular';

import RegisterPublicUserCtrl from './registerPublicUserCtrl';

export default angular.module('app.registerPublicUser', [])
  .controller('RegisterPublicUserCtrl', RegisterPublicUserCtrl)
  .name;

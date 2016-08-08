import angular from 'angular';

import RegisterPublicUserCtrl from './RegisterPublicUserCtrl';

export default angular.module('app.registerPublicUser', [])
  .controller('RegisterPublicUserCtrl', RegisterPublicUserCtrl)
  .name;

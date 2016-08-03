import angular from 'angular';

import LoginCtrl from './LoginCtrl';

export default angular.module('app.login', [])
  .controller('LoginCtrl', LoginCtrl)
  .name;

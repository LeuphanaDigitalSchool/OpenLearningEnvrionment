import angular from 'angular';

import LoginCtrl from './LoginCtrl';
import AcceptInvitationCtrl from './AcceptInvitationCtrl';

export default angular.module('app.login', [])
  .controller('LoginCtrl', LoginCtrl)
  .controller('AcceptInvitationCtrl', AcceptInvitationCtrl)
  .name;

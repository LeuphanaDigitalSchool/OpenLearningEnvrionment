import angular from 'angular';

import ForgottenPasswordCtrl from './ForgottenPasswordCtrl';
import ResetPasswordCtrl from './ResetPasswordCtrl';


export default angular.module('app.forgottenPassword', [])
  .controller('ForgottenPasswordCtrl', ForgottenPasswordCtrl)
  .controller('ResetPasswordCtrl', ResetPasswordCtrl)
  .name;

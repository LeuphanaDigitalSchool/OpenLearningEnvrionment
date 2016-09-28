import angular from 'angular';
import angularMaterial from 'angular-material';

import settingsDirective from './settingsDirective';
import SettingsCtrl from './SettingsCtrl';

export default angular.module('app.admin.settings', [angularMaterial])
  .controller('SettingsCtrl', SettingsCtrl)
  .directive('settingsDirective', settingsDirective)
  .name;

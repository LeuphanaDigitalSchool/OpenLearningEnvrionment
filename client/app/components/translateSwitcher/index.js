import angular from 'angular';

import translateSwitcher from './translateSwitcher.component';

export default angular.module('app.components.translateSwitcher', [])
  .component('translateSwitcher', translateSwitcher)
  .name;

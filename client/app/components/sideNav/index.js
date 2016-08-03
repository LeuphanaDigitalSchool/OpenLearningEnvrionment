import angular from 'angular';
import uirouter from 'angular-ui-router';
import angularMaterial from 'angular-material';

import sideNavDirective from './sideNavDirective';
import SideNavCtrl from './SideNavCtrl';

export default angular.module('app.components.sideNav', [uirouter, angularMaterial])
  .controller('SideNavCtrl', SideNavCtrl)
  .directive('sideNav', sideNavDirective)
  .name;

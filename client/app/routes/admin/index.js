import angular from 'angular';
import uirouter from 'angular-ui-router';

import CreateProfile from './createProfile';

export default angular.module('app.admin', [uirouter, CreateProfile])
  .name;

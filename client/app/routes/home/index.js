import angular from 'angular';
import uirouter from 'angular-ui-router';


import HomeCtrl from './HomeCtrl';

export default angular.module('app.home', [uirouter])
  .controller('HomeCtrl', HomeCtrl)
  .name;

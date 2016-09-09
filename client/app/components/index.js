import angular from 'angular';

import mainNavbar from './mainNavbar';
import sideNav from './sideNav';
import toolBar from './toolBar';
import loginForm from './loginForm';
import userMenu from './userMenu';
import translateSwitcher from './translateSwitcher';
import fileUploader from './fileUploader';

export default angular.module('app.components', [
    mainNavbar,
    sideNav,
    toolBar,
    translateSwitcher,
    loginForm,
    userMenu,
    fileUploader
  ]).name;

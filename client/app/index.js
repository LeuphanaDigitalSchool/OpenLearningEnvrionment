import angular from 'angular';
import uirouter from 'angular-ui-router';
import ngFileUpload from 'ng-file-upload';

import 'angular-cookie';
import ngMessages from 'angular-messages';
import ngtokenauth from 'ng-token-auth';

import routing from './routing';
import config from './config';

import components from './components';
import routes from './routes';

import style from './assets/stylesheets/style.css';
import angularAnimate from 'angular-animate';
import angularMaterial from 'angular-material';

import angularTranslate from 'angular-translate';
import angularTranslateLoaderUrl from 'angular-translate-loader-url';
import angularTranslateStorageCookie from 'angular-translate-storage-cookie';
import ipCookie from 'angular-cookies';
import toastr from 'angular-toastr';
import restangular from 'restangular-umd';

import 'angular-material/angular-material.css';
import 'angular-toastr/dist/angular-toastr.css';


const ngModule = angular
      .module('app', [
        // External modules
        uirouter,
        ngtokenauth,
        angularMaterial,
        angularAnimate,
        ngMessages,
        angularTranslate,
        angularTranslateLoaderUrl,
        angularTranslateStorageCookie,
        ipCookie,
        toastr,
        restangular,
        ngFileUpload,

        // Configs
        config,
        routing,

        // Internal modules
        components,
        routes
      ]);

import appConfig from './constants';

export default function translateConfig($translateProvider) {
  "ngInject";
  $translateProvider.useUrlLoader(appConfig.apiUrl+'/locales');
  $translateProvider.useCookieStorage();
  $translateProvider.registerAvailableLanguageKeys(['en', 'pl'], {
    'en-*': 'en',
    'pl-*': 'pl'
  });
  $translateProvider.preferredLanguage('en');
}

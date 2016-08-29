import appConfig from './constants';

export default function translateConfig($translateProvider) {
  "ngInject";
  $translateProvider.useUrlLoader(appConfig.apiUrl+'/locales');
  $translateProvider.useCookieStorage();
  $translateProvider.registerAvailableLanguageKeys(['en', 'de', 'pl'], {
    'en-*': 'en',
    'de-*': 'de',
    'pl-*': 'pl'
  });
  $translateProvider.preferredLanguage('en');
}

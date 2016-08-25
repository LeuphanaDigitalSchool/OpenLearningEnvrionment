import appConfig from './constants';

export default function translateConfig($translateProvider) {
  "ngInject";
  $translateProvider.useUrlLoader(appConfig.apiUrl+'/locales');
  $translateProvider.useCookieStorage();
  $translateProvider.registerAvailableLanguageKeys(['en', 'de'], {
    'en-*': 'en',
    'de-*': 'de'
  });
  $translateProvider.preferredLanguage('en');
}

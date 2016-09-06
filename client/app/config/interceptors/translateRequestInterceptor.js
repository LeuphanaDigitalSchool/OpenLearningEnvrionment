export default function translateRequestInterceptor ($translate) {
  "ngInject";
  let browserLanguage = window.navigator.userLanguage || window.navigator.language;
  let storageLanguage = $translate.storage().get($translate.storageKey());
  let userLanguage = storageLanguage || browserLanguage;

  return {
    request(config) {
      config.headers['User-Language'] = userLanguage;

      return config;
    }
  };
}

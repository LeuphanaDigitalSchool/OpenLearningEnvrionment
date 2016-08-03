export default function translateResponseInterceptor($translate) {
  "ngInject";
  return {
    response (response) {
      let userLanguage = response.headers('User-Language');
      userLanguage && $translate.use(userLanguage);

      return response;
    }
  };
}
import appConfig from './constants';

export default function authConfig($authProvider) {
  "ngInject";
  $authProvider.configure({
    apiUrl: appConfig.apiUrl
  });
}

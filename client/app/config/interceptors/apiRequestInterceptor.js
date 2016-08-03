export default function apiRequestInterceptor ($location) {
  "ngInject";
  let BASE_API_PATH;

  switch($location.host()){
    case 'localhost':
      BASE_API_PATH = 'http://localhost:3000';
    break;
    default:
      BASE_API_PATH = 'http://leuphana.dev.akra.net';
  }

  return {
    request(config) {
      if(config.url.includes('/api/v1/')){
        config.url = BASE_API_PATH + config.url;
      }
      return config;
    }
  };
}

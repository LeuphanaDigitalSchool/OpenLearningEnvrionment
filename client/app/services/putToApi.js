export default function putToApi($http, appConfig, $q, $mdDialog, getFromApi) {
"ngInject";
let deferObject,
    data,
    putApi = {
    put: (api, data)=> {
      deferObject = $q.defer();

      let promise = $http.put(appConfig.apiUrl+api, data);
      promise.then(
        (response)=> {
          deferObject.resolve(response);
        }
      );

      return deferObject.promise;
    }
  };
  return putApi;
}

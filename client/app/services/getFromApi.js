export default function getFromApi($http, appConfig, $q) {
"ngInject";
let deferObject,
    getApi = {

    getPromise: (path)=> {
      let promise = $http.get(appConfig.apiUrl+path),
          deferObject = deferObject || $q.defer();

          promise.then(
            (response)=> {
              deferObject.resolve(response);
            }
          );
      return deferObject.promise;
    }
  };
  return getApi;
}

export default function deleteFromApi($http, appConfig, $q, $mdDialog, getFromApi) {
"ngInject";
let deferObject,
    getApi = {
    ask: (api, ev, name)=> {
      deferObject = $q.defer();
      let confirm = $mdDialog.confirm()
            .title('Chcesz usunąć '+name+'?')
            .ariaLabel('Usuwanie '+name)
            .targetEvent(ev)
            .ok('Tak')
            .cancel('Nie');
      $mdDialog.show(confirm).then(()=> {
        let promise = $http.delete(appConfig.apiUrl+api);
        promise.then(
          (response)=> {
            deferObject.resolve(response);
          }
        );
        return deferObject.promise;
      });
      return deferObject.promise;
    }
  };
  return getApi;
}

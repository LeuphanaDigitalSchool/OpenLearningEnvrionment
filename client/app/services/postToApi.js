export default function postToApi($http, appConfig, $q, $mdDialog, getFromApi) {
"ngInject";
let deferObject,
    data,
    postApi = {
    post: (api, ev, title)=> {
      deferObject = $q.defer();
      let confirm = $mdDialog.prompt()
            .title(title)
            .placeholder('nazwa')
            .ariaLabel('nazwa')
            .targetEvent(ev)
            .ok('Dodaj')
            .cancel('Anuluj');
      $mdDialog.show(confirm).then((result)=> {
        data = { name: result };
        let promise = $http.post(appConfig.apiUrl+api, data);
        promise.then(
          (response)=> {
            deferObject.resolve(response);
          }
        );
        return deferObject.promise;
      }, ()=> {
        console.log('klknięcie w anuluj');
        return;
      });
      return deferObject.promise;
    }
  };
  return postApi;
}

class editStorageCtrl {
  constructor($mdDialog, Restangular, $http, $rootScope) {
    "ngInject";
    this.$mdDialog = $mdDialog;
    this.$http = $http;
    this.$rootScope = $rootScope;
  }

  submit(storageForm) {
    let url =  (`/api/v1/courses/${this.courseId}/phases/${this.phaseId}/storages/${this.storage.id}`);
    this.$http.put(url, this.storage).then((response) => {
      this.cancel();
      this.$rootScope.$broadcast('storage:created');
    });
  }

  cancel() {
    this.$mdDialog.cancel();
  }
}

let editStorage = {
  template: require('./editStorage.html'),
  controller: editStorageCtrl,
  bindings: {
    storage: "<",
    courseId: "<",
    phaseId: "<"
  }
};

export default editStorage;
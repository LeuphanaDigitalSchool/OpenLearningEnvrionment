class translateSwitcherCtrl {
  constructor($scope, $translate, $rootScope, $http) {
    "ngInject";
    this.$translate = $translate;
    this.$rootScope = $rootScope;
    this.$scope = $scope;
    this.$http = $http;

    this.addListerer();
  }

  changeLanguage (lang) {
    this.$translate.use(lang);
    this.$http.get('/api/v1/locales?lang=' + lang);
  }

  addListerer (){
    this.$rootScope.$on('$translateChangeEnd', (event, data) => {
      this.$scope.currentLanguage = data.language;
    });
  }
}

let translateSwitcher = {
  template: require('./translateSwitcher.html'),
  controller: translateSwitcherCtrl,
};

export default translateSwitcher;

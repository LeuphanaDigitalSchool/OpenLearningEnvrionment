class translateSwitcherCtrl {
  constructor($scope, $translate, $rootScope) {
    "ngInject";
    this.$translate = $translate;
    this.$rootScope = $rootScope;
    this.$scope = $scope;

    this.addListerer();
  }

  changeLanguage (lang) {
    this.$translate.use(lang);
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

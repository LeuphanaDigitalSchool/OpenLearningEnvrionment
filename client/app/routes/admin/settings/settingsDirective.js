export default function settingsDirective() {
  return {
    template: require('./settings.html'),
    restrict: 'E',
    controller: 'SettingsCtrl',
    controllerAs: 'SettingsCtrl'
  };
}

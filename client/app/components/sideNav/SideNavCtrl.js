export default class SideNavCtrl {
  constructor($location) {
    "ngInject";
    this.location = $location;
  }
  goToUrl(path) {
    this.location.path(path);
  }
}

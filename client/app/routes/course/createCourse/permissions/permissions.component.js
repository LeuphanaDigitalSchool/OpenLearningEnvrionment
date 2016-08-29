class PermissionsCtrl {
  constructor() {
    "ngInject";
  }
}

let permissions = {
  template: require('./permissions.html'),
  controller: PermissionsCtrl,
};

export default permissions;

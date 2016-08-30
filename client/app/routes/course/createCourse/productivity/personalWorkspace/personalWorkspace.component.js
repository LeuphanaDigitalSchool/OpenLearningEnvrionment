class PersonalWorkspaceCtrl {
  constructor() {
    "ngInject";
  }
}

let personalWorkspace = {
  template: require('./personalWorkspace.html'),
  controller: PersonalWorkspaceCtrl,
};

export default personalWorkspace;

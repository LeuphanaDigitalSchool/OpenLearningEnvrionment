class CommunicationCtrl {
  constructor($scope) {
    "ngInject";
  }
}

let communication = {
  template: require('./communication.html'),
  controller: CommunicationCtrl,
  controllerAs: 'Communication'
};

export default communication;

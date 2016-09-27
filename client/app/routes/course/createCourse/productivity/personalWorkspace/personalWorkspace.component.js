class PersonalWorkspaceCtrl {
  constructor() {
    "ngInject";
    this.status = false;
  }
  chooseAllWorkspace(){
    this.status = !this.status;
    this.personalDefineVisibility = this.status;
    this.personalShareWorkspaceWithOthers = this.status;
    this.personalFileSharing = this.status;
    this.personalEmbedFromExternalWebsites = this.status;
    this.personalShareOwnMaterialOnPlatform = this.status;
    this.personalPublishingOfDrafts = this.status;
    this.personalPublishingOfFinalSubmission = this.status;
    this.personalDefineVisibilityOfFiles = this.status;
    this.personalCalendar = this.status;
    this.personalPersonalCalendar = this.status;
    this.personalGroupCalendar = this.status;
    this.personalShowCoursePhases = this.status;
    this.personalCoursePhases = this.status;
    this.personalShowCoursePhases = this.status;
    this.personalTeacherDefineCourseStartEnd = this.status;
    this.personalDefineCoursePhases = this.status;
    this.personalDefineFrozenContent = this.status;
    this.personalMatchPlatformContentWithEespectivePhase = this.status;
    this.personalDefineNewSectionsInEach = this.status;
  }
}

let personalWorkspace = {
  template: require('./personalWorkspace.html'),
  controller: PersonalWorkspaceCtrl,
};

export default personalWorkspace;

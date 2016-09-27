class GroupWorkspaceCtrl {
  constructor() {
    "ngInject";
    this.status = false;
  }
  chooseAllWorkspace(){
    this.status = !this.status;
    this.groupDefineVisibility = this.status;
    this.groupShareWorkspaceWithOthers = this.status;
    this.groupFileSharing = this.status;
    this.groupEmbedFromExternalWebsites = this.status;
    this.groupShareOwnMaterialOnPlatform = this.status;
    this.groupPublishingOfDrafts = this.status;
    this.groupPublishingOfFinalSubmission = this.status;
    this.groupDefineVisibilityOfFiles = this.status;
    this.groupCalendar = this.status;
    this.groupGroupCalendar = this.status;
    this.groupShowCoursePhases = this.status;
    this.groupCoursePhases = this.status;
    this.groupTeacherDefineCourseStartEnd = this.status;
    this.groupDefineCoursePhases = this.status;
    this.groupDefineFrozenContent = this.status;
    this.groupMatchPlatformContentWithEespectivePhase = this.status;
    this.groupDefineNewSectionsInEach = this.status;
  }
}

let groupWorkspace = {
  template: require('./groupWorkspace.html'),
  controller: GroupWorkspaceCtrl,
};

export default groupWorkspace;

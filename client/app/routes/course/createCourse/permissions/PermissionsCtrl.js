export default class PermissionsCtrl {
  constructor() {
    "ngInject";
    this.status = false;
  }
  chooseAllPermissions(){
    this.status = !this.status;
    this.permissionToPublishContentOutsideOfPlatform = this.status;
    this.permissionToOverrideStandardNotificationSettings = this.status;
    this.permissionToInviteAdditionalUsersToPlatform = this.status;
    this.permissionToBuildTeams = this.status;
    this.teacherGivesPermissionsToIndividualUsers = this.status;
    this.teacherPermissionToPublishContentOutsideOfPlatform = this.status;
    this.teacherPermissionToOverrideStandardNotificationSettings = this.status;
    this.teacherPermissionToInviteAdditionalUsersToPlatform = this.status;
    this.teacherPermissionToBuildTeams = this.status;
    this.defineStudentBody = this.status;
    this.defineTeamMatchingCriteria = this.status;
  }
}

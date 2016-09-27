class EmailCtrl {
  constructor() {
    "ngInject";
    this.status = false;
  }
  chooseAllEmail(){
    this.status = !this.status;
    this.notificationsByEmail = this.status;
    this.sendUserMessagesAsEmailOptional = this.status;
    this.sendMessagesViaEmailWithinPlatform = this.status;
    this.emailNotifications = this.status;
    this.sendMessagesToUserGroups = this.status;
    this.replyToForumPostsViaEmail = this.status;
    this.inviteUserToPlatformByEmail = this.status;
  }
}

let email = {
  template: require('./email.html'),
  controller: EmailCtrl,
};

export default email;

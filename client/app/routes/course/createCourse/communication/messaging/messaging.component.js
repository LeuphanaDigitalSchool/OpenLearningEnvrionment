class MessagingCtrl {
  constructor() {
    "ngInject";
    this.message = {};
    this.status = false;
  }
  chooseAllMessages() {
    this.status = !this.status;
    console.log('this.status', this.status);
    this.single = this.status;
    this.group = this.status;
    this.addingOfIndividualUsers = this.status;
    this.postingMessageContent = this.status;
    this.notifications = this.status;
    this.replyByMail = this.status;
    this.attachments = this.status;
    this.embedresources = this.status;
    this.markingAndOrganizingOfMessages = this.status;
    this.tagging = this.status;
    this.emailNotifications = this.status;
    this.readUnread = this.status;
    this.sendMessagesWithHighPriority = this.status;
    this.notificationsDependentOnPriorityOfMessage = this.status;
    this.setRemindersForMessages = this.status;
    this.markAsReadUnread = this.status;
    this.receiveReadReceipts = this.status;
    this.sendPlatformInviteToEmailAddress = this.status;
    this.enterSubjectToMessage = this.status;
    this.sortMessages = this.status;
  }
}

let messaging = {
  template: require('./messaging.html'),
  controller: MessagingCtrl,
};

export default messaging;

class ForumCtrl {
  constructor() {
    "ngInject";
    this.status = false;
  }
  chooseAllForum(){
    this.status = !this.status;
    this.threadedConversations = this.status;
    this.taggingOfUsers = this.status;
    this.forumNotifications = this.status;
    this.emailNotifications = this.status;
    this.taggingOfUserGroups = this.status;
    this.forumTeachers = this.status;
    this.forumStudents = this.status;
    this.TaggingForumNotifications = this.status;
    this.emailNotifications = this.status;
    this.quoteFromForums = this.status;
    this.embedContentInForumPost = this.status;
    this.video = this.status;
    this.pictures = this.status;
    this.upvotingDownvoting = this.status;
    this.createTopics = this.status;
    this.createThreads = this.status;
    this.sortForum = this.status;
    this.filterForum = this.status;
    this.embedExternalLinks = this.status;
    this.embedInternalLinks = this.status;
  }
}

let forum = {
  template: require('./forum.html'),
  controller: ForumCtrl,
};

export default forum;

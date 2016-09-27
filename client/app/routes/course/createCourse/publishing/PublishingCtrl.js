export default class PublishingCtrl {
  constructor() {
    "ngInject";
    this.status = false;
  }
  chooseAllPublishing(){
    this.status = !this.status;
    this.publishForumPostsOutsideOfPlatform = this.status;
    this.publishResourcesOutsideOfPlatform = this.status;
    this.embed = this.status;
    this.link = this.status;
    this.publishMessagesOutsideOfPlatform = this.status;
    this.publishNewsPostsAsWordpressPostsOutsideOfPlatform = this.status;
    this.publishNewsPostsAsAsSocialMediaPosts = this.status;
    this.twitter = this.status;
    this.facebook = this.status;
    this.googlePlus = this.status;
    this.instagram = this.status;
  }
}

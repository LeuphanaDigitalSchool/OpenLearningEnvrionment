class VideoCtrl {
  constructor() {
    "ngInject";
    this.status = false;
  }
  chooseAllVideo(){
    this.status = !this.status;
    this.scheduleVideoMeetings = this.status;
    this.sendOutInvitesToVideo = this.status;
    this.defineVisibilityOfVideoMeeting = this.status;
    this.public = this.status;
    this.privateAmongParticipants = this.status;
    this.recordMeetings = this.status;
    this.shareRecording = this.status;
  }
}

let videoComponent = {
  template: require('./video.html'),
  controller: VideoCtrl,
};

export default videoComponent;

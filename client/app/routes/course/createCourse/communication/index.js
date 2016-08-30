import angular from 'angular';
import angularMaterial from 'angular-material';

import messaging from './messaging/messaging.component';
import communication from './communication.component';
import forum from './forum/forum.component';
import email from './email/email.component';
import videocomponent from './videocomponent/video.component';

export default angular.module('app.admin.course.communication', [angularMaterial])
  .component('communication', communication)
  .component('messaging', messaging)
  .component('forum', forum)
  .component('email', email)
  .component('videoComponent', videocomponent)
  .name;
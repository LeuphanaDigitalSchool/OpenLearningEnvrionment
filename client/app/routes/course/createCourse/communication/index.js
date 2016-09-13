import angular from 'angular';
import angularMaterial from 'angular-material';

import messaging from './messaging/messaging.component';
import communicationDirective from './communication.directive';
import forum from './forum/forum.component';
import email from './email/email.component';
import videocomponent from './videocomponent/video.component';

export default angular.module('app.admin.course.communication', [angularMaterial])
  .directive('communicationDirective', communicationDirective)
  .component('messaging', messaging)
  .component('forum', forum)
  .component('email', email)
  .component('videoComponent', videocomponent)
  .name;

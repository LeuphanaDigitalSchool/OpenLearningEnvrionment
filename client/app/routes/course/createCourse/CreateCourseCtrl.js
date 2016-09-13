export default class CreateCourseCtrl {
  constructor(countryList, $state, $scope, toastr, Restangular, Upload) {
    "ngInject";
    this.user = {};
    this.toastr = toastr;
    this.$state = $state;
    this.$scope = $scope;
    this.Restangular = Restangular;
    this.initialData();
  }

  submit(){
    this.course.course_preferences_attributes = [];
    this.teacherPermission();
    this.studentPermission();
    this.baseLephanaUser = this.Restangular.all('/api/v1/courses/');
    this.data.course=this.course;
    this.sending = true;
    this.baseLephanaUser.post(this.data).then(()=>{
      this.toastr.success('Thank you for addding new course', 'Success');
      this.initialData();
    }, (response)=> {
      this.sending = false;
      let status = response.statusText;
      this.toastr.error(status, 'Error');
    });
  }

  prevTab() {
    var index = (this.selectedIndex == this.max) ? 0 : this.selectedIndex - 1;
    this.selectedIndex = index;
  }

  nextTab() {
    var index = (this.selectedIndex == this.max) ? 0 : this.selectedIndex + 1;
    this.selectedIndex = index;
  }

  teacherPermission(){
    this.course.course_preferences_attributes.push({
      "role_id": 4,
      "upload_pdf": this.$scope.teacher.uploadPDF,
      "upload_jpg": this.$scope.teacher.uploadJpg,
      "upload_mp3": this.$scope.teacher.uploadMp3,
      "upload_mp4": this.$scope.teacher.uploadMp4,
      "resources_del": this.$scope.teacher.teacherCanDeleteResources,
      "resource_description_add": this.$scope.teacher.teacherCanAddResourceDescription,
      "resource_description_del": "false",
      "schedule_publishing": this.$scope.teacher.teacherCanSchedulePublishing,
      "embed_external_links": this.$scope.teacher.teacherEmbedExternalLinks
    });
  }

  studentPermission(){
    this.course.course_preferences_attributes.push({
      "role_id": 2,
      "upload_pdf": this.$scope.student.uploadPDF,
      "upload_jpg": this.$scope.student.uploadJpg,
      "upload_mp3": this.$scope.student.uploadMp3,
      "upload_mp4": this.$scope.student.uploadMp4,
      "resources_del": this.$scope.student.teacherCanDeleteResources,
      "resource_description_add": this.$scope.student.teacherCanAddResourceDescription,
      "resource_description_del": "false",
      "schedule_publishing": this.$scope.student.teacherCanSchedulePublishing,
      "embed_external_links": this.$scope.student.studentEmbedExternalLinks
    });
  }

  addNewStorage(){
    this.course.course_phases_attributes.push({});
  }

  initialData() {
    this.course = {};
    this.$scope.teacher = {};
    this.$scope.student = {};
    this.data= {};
    this.sending = false;
    this.course.course_preferences_attributes = [];
    this.course.course_phases_attributes = [];
    this.buttonTitle = 'Next';
    this.max = 6;
    this.selectedIndex = 0;
  }
}

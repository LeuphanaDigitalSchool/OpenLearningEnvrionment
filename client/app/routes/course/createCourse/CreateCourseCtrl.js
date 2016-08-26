export default class CreateCourseCtrl {
  constructor(countryList, $state, $scope, toastr, Restangular, Upload) {
    "ngInject";
    this.user = {};
    this.toastr = toastr;
    this.$state = $state;
    this.$scope = $scope;
    this.Restangular = Restangular;
    this.course = {};
    this.teacher = {};
    this.course.course_preferences_attributes = [];
    this.buttonTitle = 'Next';

    this.max = 3;
    this.selectedIndex = 0;
    this.nextTab = function() {
      var index = (this.selectedIndex == this.max) ? 0 : this.selectedIndex + 1;
      this.selectedIndex = index;
      if(this.selectedIndex === 2){
        this.buttonTitle = 'Add Course';
      }
      if(this.selectedIndex === 3){
        this.teacherPermission();
      }
    };
    this.prevTab = function() {
      var index = (this.selectedIndex == this.max) ? 0 : this.selectedIndex - 1;
      this.selectedIndex = index;
      if(this.selectedIndex !== 2){
        this.buttonTitle = 'Next';
      }
    };
  }

  submit(form, data){
    this.baseLephanaUser = this.Restangular.all('/api/v1/admin/users/' + this.userType);
    if(this.errors === 0) {
      this.send = false;
      this.baseLephanaUser.post(this.sendData).then(()=>{
        this.toastr.success('Thank you for registering new user', 'Success');
        this.initialData();
      }, (response)=> {
        this.send = true;
        console.log(response);
        let status = response.statusText;
        this.toastr.error(status, 'Error');
      });
    }
  }

  teacherPermission(){
    this.course.course_preferences_attributes.push({
      "role_id": 4,
      "upload_pdf": this.teacher.uploadPDF,
      "upload_jpg": this.teacher.uploadJpg,
      "upload_mp3": this.teacher.uploadMp3,
      "upload_mp4": this.teacher.uploadMp4,
      "resources_del": this.teacher.teacherCanDeleteResources,
      "resource_description_add": this.teacher.teacherCanAddResourceDescription,
      "resource_description_del": "false",
      "schedule_publishing": this.teacher.teacherCanSchedulePublishing,
      "embed_external_links": this.teacher.studentEmbedExternalLinks
    });
  }

  studentPermission(){
    this.course.course_preferences_attributes.push({
      "role_id": 2,
      "upload_pdf": this.student.uploadPDF,
      "upload_jpg": this.student.uploadJpg,
      "upload_mp3": this.student.uploadMp3,
      "upload_mp4": this.student.uploadMp4,
      "resources_del": this.student.teacherCanDeleteResources,
      "resource_description_add": this.student.teacherCanAddResourceDescription,
      "resource_description_del": "false",
      "schedule_publishing": this.student.teacherCanSchedulePublishing,
      "embed_external_links": this.student.studentEmbedExternalLinks
    });
  }

  initialData() {
  }
}

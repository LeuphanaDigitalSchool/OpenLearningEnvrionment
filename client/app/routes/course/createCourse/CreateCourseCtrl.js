export default class CreateCourseCtrl {
  constructor(countryList, $state, $scope, toastr, Restangular, Upload, $rootScope) {
    "ngInject";
    this.user = {};
    this.toastr = toastr;
    this.$state = $state;
    this.$scope = $scope;
    this.$rootScope = $rootScope;
    this.Restangular = Restangular;
    this.status = false;
    this.initialData();
  }

  submit(form){
    if(form.$valid){
      this.course.course_phases_attributes = [];
      this.teacherPermission();
      this.baseLephanaUser = this.Restangular.all('/api/v1/courses/');
      this.data.course=this.course;
      this.sending = true;
      this.baseLephanaUser.post(this.data).then(()=>{
        this.toastr.success('Thank you for addding new course', 'Success');
        this.$rootScope.$broadcast('course:created');
        this.initialData();
        this.$scope.courseForm.$setUntouched();
        this.$scope.courseForm.$setPristine();
      }, (response)=> {
        this.sending = false;
        let status = response.statusText;
        this.toastr.error(status, 'Error');
      });
    }
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
    for (let i = 0; i < this.$scope.phases.length; i++) {
      this.course.course_phases_attributes.push({
        "title": this.$scope.phases[i].title,
        "description": this.$scope.phases[i].description,
        "start_date": this.$scope.phases[i].start_date,
        "end_date": this.$scope.phases[i].end_date,
        "course_phase_preferences_attributes" : [
          {
            "role_id": 2,
            "upload_pdf": this.$scope.phases[i].studentUploadPDF,
            "upload_jpg": this.$scope.phases[i].studentUploadJpg,
            "upload_mp3": this.$scope.phases[i].studentUploadMp3,
            "upload_mp4": this.$scope.phases[i].studentUploadMp4,
            "resources_del": this.$scope.phases[i].studentCanDeleteResources,
            "resource_description_add": this.$scope.phases[i].studentCanAddResourceDescription,
            "resource_description_del": "false",
            "schedule_publishing": this.$scope.phases[i].studentCanSchedulePublishing,
            "embed_external_links": this.$scope.phases[i].studentEmbedExternalLinks
          },
          {
            "role_id": 4,
            "upload_pdf": this.$scope.phases[i].teacherUploadPDF,
            "upload_jpg": this.$scope.phases[i].teacherUploadJpg,
            "upload_mp3": this.$scope.phases[i].teacherUploadMp3,
            "upload_mp4": this.$scope.phases[i].teacherUploadMp4,
            "resources_del": this.$scope.phases[i].teacherCanDeleteResources,
            "resource_description_add": this.$scope.phases[i].teacherCanAddResourceDescription,
            "resource_description_del": "false",
            "schedule_publishing": this.$scope.phases[i].teacherCanSchedulePublishing,
            "embed_external_links": this.$scope.phases[i].teacherEmbedExternalLinks
          },
          {
            "role_id": 6,
            "upload_pdf": "true",
            "upload_jpg": "true",
            "upload_mp3": "true",
            "upload_mp4": "true",
            "resources_del": "true",
            "resource_description_add": "true",
            "resource_description_del": "true",
            "schedule_publishing": "true",
            "embed_external_links": "true"
          }
        ]
      });
    }
  }

  addNewPhase(){
    this.$scope.phases.push({});
  }

  removePhase(idx) {
    this.$scope.phases.splice(idx, 1);
  }

  initialData() {
    this.course = {};
    this.$scope.teacher = [];
    this.$scope.student = {};
    this.teacher = [];
    this.student = [];
    this.data= {};
    this.sending = false;
    this.$scope.phases = [];
    this.buttonTitle = 'Next';
    this.max = 6;
    this.selectedIndex = 0;
  }

  chooseAllStorage(){
    this.status = !this.status;
    for (let i = 0; i < this.$scope.phases.length; i++) {
      this.teacher.push({});
      this.student.push({});
      this.teacher[i].teacherCanUploadFiles = this.status;
      this.student[i].studentCanUploadFiles = this.status;
      this.$scope.phases[i].studentUploadPDF = this.status;
      this.$scope.phases[i].studentUploadJpg = this.status;
      this.$scope.phases[i].studentUploadMp3 = this.status;
      this.$scope.phases[i].studentUploadMp4 = this.status;
      this.$scope.phases[i].studentCanDeleteResources = this.status;
      this.$scope.phases[i].studentCanAddResourceDescription = this.status;
      this.$scope.phases[i].studentCanSchedulePublishing = this.status;
      this.$scope.phases[i].studentEmbedExternalLinks = this.status;
      this.$scope.phases[i].teacherUploadPDF = this.status;
      this.$scope.phases[i].teacherUploadJpg = this.status;
      this.$scope.phases[i].teacherUploadMp3 = this.status;
      this.$scope.phases[i].teacherUploadMp4 = this.status;
      this.$scope.phases[i].teacherCanDeleteResources = this.status;
      this.$scope.phases[i].teacherCanAddResourceDescription = this.status;
      this.$scope.phases[i].teacherCanSchedulePublishing = this.status;
      this.$scope.phases[i].teacherEmbedExternalLinks = this.status;
    }
  }
}

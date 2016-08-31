export default class CourseCrtl {
  constructor(Restangular, $stateParams, $filter, toastr, $scope) {
    "ngInject";
    this.Restangular = Restangular;
    this.$stateParams = $stateParams;
    this.courseId = $stateParams.id;
    this.$scope = $scope;
    this.toastr = toastr;
    this.coursesApi = this.Restangular.oneUrl('course', '/api/v1/courses/'+this.courseId);
    this.course();
    this.edit = false;
    this.data= {};
  }
  course() {
    this.coursesApi.get().then(
    (response)=>{
      this.$scope.courseData = response.course;
    });
  }
  editFn() {
    if(this.edit){
      this.submit();
    } else {
      this.edit = true;
    }
  }

  submit(){
    this.baseLephanaUser = this.Restangular.all('/api/v1/courses/');
    this.data.course=this.$scope.courseData;
    this.sending = true;
    this.baseLephanaUser.customPUT(this.data, this.courseId).then(()=>{
      this.toastr.success('Thank you for edditing course', 'Success');
      this.edit = false;
    }, (response)=> {
      this.sending = false;
      this.edit = false;
      let status = response.statusText;
      this.toastr.error(status, 'Error');
    });
  }
}

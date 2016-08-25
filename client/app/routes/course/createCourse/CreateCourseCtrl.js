export default class CreateCourseCtrl {
  constructor(countryList, $state, toastr, Restangular, Upload) {
    "ngInject";
    this.user = {};
    this.toastr = toastr;
    this.$state = $state;
    this.Restangular = Restangular;
    // $scope.max = 2;
    // $scope.selectedIndex = 0;
    // $scope.nextTab = function() {
    //   var index = ($scope.selectedIndex == $scope.max) ? 0 : $scope.selectedIndex + 1;
    //   $scope.selectedIndex = index;
    // };
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

  initialData() {
  }
}

export default class CreateCourseCtrl {
  constructor(countryList, $state, $scope, toastr, Restangular, Upload) {
    "ngInject";
    this.user = {};
    this.toastr = toastr;
    this.$state = $state;
    this.$scope = $scope;
    this.Restangular = Restangular;
    this.max = 2;
    this.selectedIndex = 0;
    this.nextTab = function() {
      var index = (this.selectedIndex == this.max) ? 0 : this.selectedIndex + 1;
      this.selectedIndex = index;
    };
    this.prevTab = function() {
      var index = (this.selectedIndex == this.max) ? 0 : this.selectedIndex - 1;
      this.selectedIndex = index;
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

  initialData() {
  }
}

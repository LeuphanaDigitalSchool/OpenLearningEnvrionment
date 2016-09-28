export default class SettingsCtrl {
  constructor(Upload, Restangular, toastr, $rootScope) {
    "ngInject";
    this.Upload = Upload;
    this.Restangular = Restangular;
    this.$rootScope = $rootScope;
    this.toastr = toastr;
    this.data = {};
    this.coursesApi = this.Restangular.oneUrl('files', '/api/v1/admin/regulations');
    this.getRegulations();
    this.addListeners();
  }
  addListeners(){
    this.$rootScope.$on('file:added', this.getRegulations.bind(this));
  }

  upload(file, errFiles, $event, fileId, name) {
    if (file) {
      this.uploading = true;
      file.upload = this.Upload.base64DataUrl(file);
      file.upload.then( (response) => {
        this.data.file = response;
        this.submit(this.data, fileId, name);
      });
    }
  }

  submit(data, Id, name) {
    this.data.name = name;
    console.log('this.data', this.data);
    this.coursesApi.customPUT(data, ''+Id)
    .then((response)=>{
        this.toastr.success('You have successfully added new file', 'Success');
        this.$rootScope.$broadcast('file:added');
        this.uploading = false;
        this.data = {};
    })
    .catch((err)=>{
       this.toastr.error(err, 'Error');
       this.uploading = false;
    });
  }

  getRegulations() {
    this.coursesApi.get().then(
      (response)=>{
        this.regulations = response.regulations;
    });
  }
}

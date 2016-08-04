export default function toastrConfig(toastrConfig) {
  "ngInject";
  angular.extend(toastrConfig, {
    positionClass: 'toast-top-center',
    progressBar: 'true'
  });
}

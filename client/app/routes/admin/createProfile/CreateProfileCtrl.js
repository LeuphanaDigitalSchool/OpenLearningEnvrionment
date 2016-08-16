export default class CreateProfileCtrl {
  constructor(countryList) {
    "ngInject";
    this.user = null;
    this.genders = [
      'male',
      'female',
      'I d rather not say'
    ];
    this.roles = [
      'student',
      'teacher',
      'course director',
      'support'
    ];
    this.educational_attainments = [
      'None',
      'High School',
      'Bachelor or equivalent',
      'Master or equivalent',
      'PhD',
      'Professor'
    ];
    this.countries = countryList;
  }
}

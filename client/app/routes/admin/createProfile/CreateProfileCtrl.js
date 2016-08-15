export default class CreateProfileCtrl {
  constructor(countryList) {
    "ngInject";
    this.user = null;
    this.genders = [
      'male',
      'female',
      'I d rather not say'
    ];
    this.countries = countryList;
    console.log(this.countries);
  }
}

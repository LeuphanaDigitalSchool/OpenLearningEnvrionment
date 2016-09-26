var moment = require('moment');

export default function mdDateLocale($mdDateLocaleProvider) {
  "ngInject";
  $mdDateLocaleProvider.formatDate = function(date) {
    return date ? moment(date).format('DD MMM YYYY') : '';
  };
}

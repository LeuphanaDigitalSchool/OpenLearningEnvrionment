// This file is an entry point for angular tests

import 'angular';
import 'angular-mocks/angular-mocks';

if (!String.prototype.includes) {
  String.prototype.includes = function() {'use strict';
    return String.prototype.indexOf.apply(this, arguments) !== -1;
  };
}

var testsContext = require.context("./app/", true, /.test$/);
testsContext.keys().forEach(testsContext);
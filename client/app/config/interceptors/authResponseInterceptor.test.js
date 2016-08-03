import authResponseInterceptor from './authResponseInterceptor';

describe('authResponseInterceptor', () => {

  let fakedData = {};
  let mocks = {};
  let interceptor, $rootScope, $httpProvider, $location;

  fakedData.rejection = {
    status: 401
  };

  fakedData.success = {
    status: 200
  };


  beforeEach(() => {
    angular
      .module('mock.app.config', [])
        .service('authResponseInterceptor', authResponseInterceptor)
        .config(function($httpProvider) {
          $httpProvider.interceptors.push('authResponseInterceptor');
        });

    angular.mock.module('mock.app.config', (_$httpProvider_) => {
      $httpProvider = _$httpProvider_;
    });

    mocks.$location = jasmine.createSpyObj('$location', ['path']);
    mocks.$q = jasmine.createSpyObj('$q', ['reject']);

    window.module($provide => {
      $provide.value('$location', mocks.$location);
      $provide.value('$q', mocks.$q);
    });

    window.inject((_authResponseInterceptor_) => {
      interceptor = _authResponseInterceptor_;
    });
  });



  it('should redirect to /login if status eq 404', () => {
    interceptor.responseError(fakedData.rejection);

    expect(mocks.$location.path).toHaveBeenCalledWith('/login');
  });

  it('should do nothing if status is different', () => {
    interceptor.responseError(fakedData.success);

    expect(mocks.$location.path).not.toHaveBeenCalledWith('/login');
  });



});
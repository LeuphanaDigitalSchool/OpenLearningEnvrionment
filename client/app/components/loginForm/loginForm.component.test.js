import loginForm  from './loginForm.component';

describe('Components/loginForm', () => {
  // Define all variables for inject
  let fakedData = {};
  let mocks = {};   
  let $componentController, $q, $controller, $rootScope, $compile, element; 

  // Pupulate faked data
  fakedData.loginForm = {name: 'Bartek'};

  // Pupulate all mocks
  mocks.$auth = {
    submitLogin: () => {
      return $q.when({});
    }
  };

  mocks.$state = {
    go: () => {}
  };

  beforeEach(() => { // all this functions will be evaluate before each tests
    angular
      .module('mock.app.components.loginForm', []) // create new angular fake module
      .component('loginForm', loginForm); // add our controller to this module
    angular.mock.module('mock.app.components.loginForm'); // create mock for new created fake module

    window.module($provide => { // window.module comes from angular-mock lib
      $provide.value('$auth', mocks.$auth); // mock $auth service as a empty object
      $provide.value('$state', mocks.$state);// mock $state service as a empty object
    });

    // inject our previously declared variable to module, just do like that, do not try to undarstand 
    window.inject((_$q_, _$componentController_, _$rootScope_, _$compile_) => {
      $q = _$q_;
      $componentController = _$componentController_;
      $rootScope = _$rootScope_;
      $compile = _$compile_;
    });

   

  });

  it('should contain form with ng-submit', () => {
    element = $compile('<login-form></login-form>')($rootScope);
    $rootScope.$digest();

    expect(element.html()).toContain('ng-submit="$ctrl.login($ctrl.loginForm)"');
  });

  it('define loginForm as empty object', () => {
    $controller = $componentController('loginForm', null);
    
    expect($controller.loginForm).toEqual({});
  });

  describe('Method: login', () => {
    
    it('should call $auth.submitLogin service with this.loginForm params', () => {
      spyOn($controller.$auth, 'submitLogin').and.callThrough();
      $controller.loginForm = fakedData.loginForm;
      $controller.login();

      expect($controller.$auth.submitLogin).toHaveBeenCalledWith(fakedData.loginForm);
    });

    describe('Service $auth.submitLogin', () => {
      it('on success call $state.go with home as param', () => {
        spyOn($controller.$state, 'go');
        $controller.login();
        $rootScope.$digest();

        expect($controller.$state.go).toHaveBeenCalledWith('home');
      });

      it('on error call handleError', () => {
        spyOn($controller.$auth, 'submitLogin').and.returnValue($q.reject({}));
        spyOn($controller,'handleError');
        $controller.login();
        $rootScope.$digest();

        expect($controller.handleError).toHaveBeenCalled();
      });
    });
    
  });
});
import translateSwitcher  from './translateSwitcher.component';

describe('translateSwitcher', () => {
  let fakeData = {};
  let mocks = {};
  let $compile, $rootScope, $componentController, component;

  fakeData.language = 'xxx';

  beforeEach(() => {
    angular
      .module('mock.app.components.translateSwitcher', [])
        .component('translateSwitcher', translateSwitcher);
    angular.mock.module('mock.app.components.translateSwitcher');

    mocks.$translate = jasmine.createSpyObj('$translate', ['use']);

    window.module($provide => {
      $provide.value('$translate', mocks.$translate);
    });

    window.inject((_$compile_, _$rootScope_, _$componentController_) => {
      $componentController = _$componentController_;
      $compile = _$compile_;
      $rootScope = _$rootScope_;
    });

  });

  it('should render propere html', () => {
    let element = $compile("<translate-switcher></translate-switcher>")($rootScope);

    expect(element.html()).toContain('ng-click="$mdOpenMenu($event)"');
    expect(element.html()).toContain('{{ currentLanguage }}');
    expect(element.html()).toContain("changeLanguage('pl')");
    expect(element.html()).toContain('en');
  });

  it('changeLanguage should call $translate.use with proper params', () => {
    let element = $compile("<translate-switcher></translate-switcher>")($rootScope);
    $rootScope.$digest();

    component = $componentController('translateSwitcher', null);
    component.changeLanguage(fakeData.language);

    expect(mocks.$translate.use).toHaveBeenCalledWith(fakeData.language);
  });

  it('translateChangeEnd should be called and set currentLanguage', () => {
    let element = $compile("<translate-switcher></translate-switcher>")($rootScope);
    $rootScope.$digest();

    component = $componentController('translateSwitcher', null);
    $rootScope.$broadcast('$translateChangeEnd', fakeData);

    expect(component.$scope.currentLanguage).toEqual(fakeData.language);
  });

});

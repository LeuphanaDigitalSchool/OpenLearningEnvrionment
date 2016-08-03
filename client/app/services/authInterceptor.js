export default function authInterceptor($q, $location) {
  return {
    responseError (rejection) {
      if (rejection.status === 401){
        $location.path('/login')
        console.log("Response Error 401");
      }
      return $q.reject(rejection);
  }
  }
}

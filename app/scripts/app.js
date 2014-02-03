(function() {
  "use strict";
  angular.module("vivoconfApp", ["ngCookies", "ngResource", "ngSanitize", "ngRoute"]).config(function($routeProvider, $locationProvider, $httpProvider) {
    $routeProvider.when("/", {
      templateUrl: "partials/main",
      controller: "MainCtrl"
    }).when("/login", {
      templateUrl: "partials/login",
      controller: "LoginCtrl"
    }).when("/signup", {
      templateUrl: "partials/signup",
      controller: "SignupCtrl"
    }).when("/conferences", {
      templateUrl: "partials/conference_list",
      controller: "ConferenceListCtrl"
    }).when("/conferences/:id", {
      templateUrl: "partials/conference",
      controller: "ConferenceCtrl"
    }).when("/settings", {
      templateUrl: "partials/settings",
      controller: "SettingsCtrl",
      authenticate: true
    }).otherwise({
      redirectTo: "/"
    });
    $locationProvider.html5Mode(true);
    return $httpProvider.interceptors.push([
      "$q", "$location", function($q, $location) {
        return {
          responseError: function(response) {
            if (response.status === 401 || response.status === 403) {
              $location.path("/login");
              return $q.reject(response);
            } else {
              return $q.reject(response);
            }
          }
        };
      }
    ]);
  }).run(function($rootScope, $location, Auth) {
    return $rootScope.$on("$routeChangeStart", function(event, next) {
      if (next.authenticate && !Auth.isLoggedIn()) {
        return $location.path("/login");
      }
    });
  });

}).call(this);

//# sourceMappingURL=../../app/scripts/app.js.map

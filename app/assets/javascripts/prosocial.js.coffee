@prosocial = angular.module('prosocial', ['ngRoute', 'facebook'])

@prosocial.config ($routeProvider, FacebookProvider) ->
  $routeProvider.
    when('/events', {
      templateUrl: '/events',
      controller: 'EventsCtrl'
    }).
    otherwise({
      templateUrl: '/landing',
      controller: 'LandingCtrl'
    })

  FacebookProvider.init("431196430356878")

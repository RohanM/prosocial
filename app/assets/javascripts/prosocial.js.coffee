@prosocial = angular.module('prosocial', ['ngRoute', 'facebook', 'angularMoment'])

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

  FacebookProvider.init("431195277023660")

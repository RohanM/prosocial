@prosocial = angular.module('prosocial', ['ngRoute', 'facebook'])

@prosocial.config ($routeProvider, FacebookProvider) ->
  $routeProvider.
    otherwise({
      templateUrl: '/events',
      controller: 'EventsCtrl'
    })

  FacebookProvider.init("431196430356878")

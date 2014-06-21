@prosocial = angular.module('prosocial', ['ngRoute'])

@prosocial.config ($routeProvider) ->
  $routeProvider.
    otherwise({
      templateUrl: '/events',
      controller: 'EventsCtrl'
    })

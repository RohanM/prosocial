@fblite = angular.module('fblite', ['ngRoute'])

@fblite.config ($routeProvider) ->
  $routeProvider.
    otherwise({
      templateUrl: '/events',
      controller: 'EventsCtrl'
    })

@prosocial.controller 'EventsCtrl', ($scope, $timeout, Facebook) ->
  $scope.user = {}
  $scope.events = []
  $scope.logged_in = false;

  $scope.$watch (->
    Facebook.isReady()
  ), (newVal) ->
    if newVal
      $scope.facebookReady = true
      $scope.displayLoggedIn()

  $scope.displayLoggedIn = ->
    $scope.logged_in = true
    $scope.me()


  $scope.me = ->
    Facebook.api "/me", (response) ->
      $scope.$apply ->
        $scope.user = response

        Facebook.api "/#{$scope.user.id}/events", (response) ->
          $scope.events = response.data;


  $scope.logout = ->
    Facebook.logout ->
      $scope.$apply ->
        $scope.user = {}
        $scope.events = []
        $scope.logged_in = false

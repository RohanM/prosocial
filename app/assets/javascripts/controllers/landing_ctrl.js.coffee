@prosocial.controller 'LandingCtrl', ($scope, $location, Facebook) ->
  $scope.user = {}
  $scope.logged_in = false;

  $scope.$watch (->
    Facebook.isReady()
  ), (newVal) ->
    $scope.facebookReady = true  if newVal


  $scope.IntentLogin = ->
    Facebook.getLoginStatus (response) ->
      if response.status == "connected"
        $scope.displayLoggedIn()
      else
        $scope.login()


  $scope.login = ->
    Facebook.login (response) ->
      if response.status == "connected"
        $scope.displayLoggedIn()


  $scope.displayLoggedIn = ->
    $location.path "/events"

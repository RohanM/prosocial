@prosocial.controller 'LandingCtrl', ($scope, $location, Facebook) ->
  $scope.logged_in = false;

  $scope.$watch (->
    Facebook.isReady()
  ), (isReady) ->
    $scope.facebookReady = true  if isReady


  $scope.startLogin = ->
    Facebook.getLoginStatus (response) ->
      if response.status == "connected"
        $scope.afterLogin()
      else
        $scope.login()


  $scope.login = ->
    Facebook.login (response) ->
      if response.status == "connected"
        $scope.afterLogin()


  $scope.afterLogin = ->
    $location.path "/events"

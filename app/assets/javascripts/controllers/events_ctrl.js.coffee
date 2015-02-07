@prosocial.controller 'EventsCtrl', ($scope, Facebook) ->
  $scope.user = {}
  $scope.events = []
  $scope.logged_in = false;

  $scope.$watch (->
    Facebook.isReady()
  ), (isReady) ->
    if isReady
      $scope.facebookReady = true
      $scope.afterLogin()

  $scope.afterLogin = ->
    Facebook.getLoginStatus (response) ->
      if response.status == "connected"
        $scope.logged_in = true
        $scope.loadData()


  $scope.loadData = ->
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

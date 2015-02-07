@prosocial.controller 'EventsCtrl', ($scope, $location, Facebook) ->
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
      else
        $scope.afterLogout()


  $scope.afterLogout = ->
    $location.path "/"


  $scope.loadData = ->
    Facebook.api "/me", (response) ->
      $scope.$apply ->
        $scope.user = response
        # Fetching additional fields:
        # ?fields=id,cover,location,name,start_time
        Facebook.api "/#{$scope.user.id}/events", (response) ->
          $scope.events = response.data;
          $scope.loadEvent(event) for event in $scope.events


  $scope.loadEvent = (event) ->
    Facebook.api "/#{event.id}/picture?type=normal", (response) ->
      event.picture_url = response.data.url

  $scope.logout = ->
    Facebook.logout ->
      $scope.$apply ->
        $scope.user = {}
        $scope.events = []
        $scope.logged_in = false
        $scope.afterLogout()

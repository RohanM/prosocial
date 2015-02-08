@prosocial.controller 'EventsCtrl', ($scope, $location, Facebook) ->
  $scope.user = {}
  $scope.events = []
  $scope.logged_in = false;
  $scope.show_past_events = false

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


  $scope.togglePastEvents = ->
    $scope.show_past_events = !$scope.show_past_events


  $scope.eventPast = (event) ->
    end_time = if event.end_time? then event.end_time else event.start_time
    new Date(end_time) < new Date()


  $scope.logout = ->
    Facebook.logout ->
      $scope.$apply ->
        $scope.user = {}
        $scope.events = []
        $scope.logged_in = false
        $scope.afterLogout()

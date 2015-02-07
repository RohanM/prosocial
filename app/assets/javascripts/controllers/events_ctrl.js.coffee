@prosocial.controller 'EventsCtrl', ($scope, $timeout, Facebook) ->
  $scope.user = {}
  $scope.events = []
  $scope.logged_in = false;
  $scope.byebye = false;
  $scope.salutation = false;

  $scope.$watch (->
    Facebook.isReady()
  ), (newVal) ->
    if newVal
      $scope.facebookReady = true
      $scope.displayLoggedIn()

  $scope.displayLoggedIn = ->
    $scope.logged_in = true
    $scope.salutation = true
    $scope.byebye = false
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
        $scope.salutation = false
        $scope.byebye = true

        # Dismiss byebye message after two seconds
        $timeout (->
          $scope.byebye = false
        ), 2000

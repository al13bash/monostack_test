angular.module('monostackTest')
.controller('AuthCtrl', [
'$scope',
'$state',
'Auth',
'$auth',
function($scope, $state, Auth, $auth){
  $scope.authenticate = function(provider) {
    $auth.authenticate(provider);
  };

  $scope.login = function() {
    Auth.login($scope.user).then(function(){
      $state.go('home');
    });
  };

  $scope.register = function() {
    Auth.register($scope.user).then(function(){
      $state.go('home');
    });
  };
}]);
angular.module('monostackTest')
.controller('MainCtrl', [
'$scope',
'posts',
function($scope, posts){
  $scope.posts = posts.posts;

  $scope.addPost = function(){
    if(!$scope.title || $scope.title === '' && !$scope.body || $scope.body === '') { return; }
    posts.create({
      title: $scope.title,
      body: $scope.body,
      price: $scope.price
    });
    $scope.title = '';
    $scope.body = '';
    $scope.price = '';
  };
}]);
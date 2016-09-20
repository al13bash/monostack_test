angular.module('monostackTest')
.controller('MainCtrl', [
'$scope',
'posts',
function($scope, posts){
  $scope.posts = posts.posts;
  $scope.categoriesSingle = posts.categories;
  $scope.categories = posts.categories;

  $scope.fClick = function(data){
    posts.getAllInCategory(data.id);
  };

  $scope.fReset = function(){
    posts.getAll();
  };

  $scope.addPost = function(){
    if(!$scope.title || $scope.title === '' &&
      !$scope.body || $scope.body === '' &&
      !$scope.selectedCategories ||
      $scope.selectedCategories.length == 0) { return; }
    posts.create({
      title: $scope.title,
      body: $scope.body,
      price: $scope.price,
      categories: $scope.selectedCategories
    });
    $scope.title = '';
    $scope.body = '';
    $scope.price = '';
    $scope.selectedCategories = [];
  };
}]);

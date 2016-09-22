angular.module('monostackTest')
.controller('MainCtrl', [
'$scope',
'posts',
'Auth',
function($scope, posts, Auth){
  $scope.posts = posts.posts;
  $scope.categoriesSingle = posts.categories;
  $scope.categories = posts.categories;

  $scope.fClick = function(data){
    posts.getAllInCategory(data.id);
  };

  $scope.fReset = function(){
    posts.getAll();
  };

  $scope.$on('devise:new-session', function(e, user){
    $scope.user = user;
  });

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
    angular.forEach($scope.categories, function(category) {
      category.ticked = false;
    })
  };
}]);

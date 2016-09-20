angular.module('monostackTest')
.factory('posts', [
'$http',
function($http){
  var o = {
    posts: [],
    categories: []
  };

  o.getAllInCategory = function(category_id) {
    return $http.get('/categories/' + category_id + '.json').success(function(data){
      angular.copy(data, o.posts);
    });
  };

  o.getAll = function() {
    $http.get('/categories.json').success(function(data){
      angular.copy(data, o.categories);
    });
    return $http.get('/posts.json').success(function(data){
      angular.copy(data, o.posts);
    });
  };

  o.get = function(id) {
    return $http.get('/posts/' + id + '.json').then(function(res){
      return res.data;
    });
  };

  o.create = function(post) {
    return $http.post('/posts.json', post).success(function(data){
      //o.posts.push(data);
    });
  };

  return o;
}]);
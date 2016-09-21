angular.module('monostackTest', ['satellizer', 'ui.router', 'templates', 'Devise', 'isteven-multi-select'])
.config([
'$stateProvider',
'$urlRouterProvider',
'$authProvider',
function($stateProvider, $urlRouterProvider, $authProvider) {
  $stateProvider
    .state('home', {
      url: '/home',
      templateUrl: 'home/_home.html',
      controller: 'MainCtrl',
      resolve: {
        postPromise: ['posts', function(posts){
          return posts.getAll();
        }]
      }
    })
    .state('posts', {
      url: '/posts/{id}',
      templateUrl: 'posts/_posts.html',
      controller: 'PostsCtrl',
      resolve: {
        post: ['$stateParams', 'posts', function($stateParams, posts) {
          return posts.get($stateParams.id);
        }]
      }
    })
    .state('login', {
      url: '/login',
      templateUrl: 'auth/_login.html',
      controller: 'AuthCtrl',
      onEnter: ['$state', 'Auth', function($state, Auth) {
        Auth.currentUser().then(function(){
          $state.go('home');
        })
      }]
    })
    .state('register', {
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      onEnter: ['$state', 'Auth', function($state, Auth) {
        Auth.currentUser().then(function(){
          $state.go('home');
        })
      }]
    });

  $authProvider.facebook({
    clientId: '1607361349517928'
  });

  $authProvider.oauth2({
    name: 'vkontakte',
    url: '/auth/vk',
    redirectUri:window.location.origin || window.location.protocol + '//' + window.location.host,
    clientId: '4982591',
    authorizationEndpoint: 'http://oauth.vk.com/authorize',
    scope: 'friends, photos, email, photo_big',
    display: 'popup',
    responseType: 'code',
    requiredUrlParams: ['response_type', 'client_id', 'redirect_uri', 'display', 'scope', 'v'],
    scopeDelimiter: ',',
    v: '5.37'
  });

  $urlRouterProvider.otherwise('home');
}]);

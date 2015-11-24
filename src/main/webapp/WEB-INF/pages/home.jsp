<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Article Page</title>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath }/css/phearun.css"/>
		
	</head>
	<body ng-app="myApp" ng-controller="myCtrl">
		
		<div class="main-container">
		
			<jsp:include page="include/header.jsp"></jsp:include>
			
			<div class="a-container">
			
				<div class="a-row">
					<div class="a-left-side">
						<ul class="a-category">
							<li><i class="fa fa-tags"></i>All Categories</li>
							<li ng-repeat="category in categories" ng-click="articleCategory(category.id)" value="{{category.id}}"><i class="fa fa-angle-down"></i>{{category.name}}</li>
						</ul>
					</div><!--/end a-left-side  -->
					
					<div class="a-body">
						<div class="article-block">
							<div class="article-item" ng-repeat="article in articles">
								<div class="article-info">
									<img ng-click="articleUser(article.user.uid)" src="{{article.user.uimage}}"/>
									<p ng-click="articleUser(article.user.uid)">{{article.user.uname | uppercase}}</p><br>
									<pre>{{article.postdate | date:'medium'}}</pre>	
									<div class="clear"></div>								
								</div>
								<div class="article-components">
									<div class="article-image">
										<a href="detail/{{article.id}}" target="_blank"><img src="{{article.image}}"/></a>
									</div>
									<div class="article-desc">
											<h3><a href="detail/{{article.id}}" target="_blank">{{article.title}}</a></h3>
											<p><a href="detail/{{article.id}}" target="_blank">{{article.description | limitTo:200}}</a></p>
									</div>
								</div>
								<div class="article-action">
									<div class="action">
										<pre><span>1002K Likes</span><span>       500K Comments</span><span>       100K Shares</span></pre>
									</div>
								</div>
							</div>
						</div>
					</div><!--/end a-body  -->
					
					<div class="a-right-side">
						<ul class="a-popular">
							<li><i class="fa fa-area-chart"></i>Popular Articles</li>
							<li ng-repeat="popular in populars">
								<div class="a-popular-item">
									<a href="detail/{{popular.id}}" target="_blank"><img src="{{popular.image}}"/></a>
									<p><a href="detail/{{popular.id}}" target="_blank">{{popular.title}}</a></p>
									<div class="clear"></div>
								</div>
							</li>
						</ul>
					</div><!--/end a-right-side  -->
					
				</div><!--/end a-row  -->
				
			</div><!--/end a-container  -->
			
		</div><!--/end main container  -->
		
		
		
		<script>
			var app = angular.module('myApp', []);
			app.controller('myCtrl', function($scope, $window, $http){
				
				$scope.articles = [];
				$scope.categories = [];
				$scope.populars = [];
				$scope.navCategory = [];
				
				$scope.uid = 0;
				$scope.cid = 0;
				$scope.page = 0;
				$scope.key = "";
				
				$scope.loadCategories = function(){
					$http.get('api/category/').success(function (response) {
				    	angular.forEach(response.RESPONSE_DATA, function(data, key) {
				    		  $scope.categories.push(data);
				    		  if(key<5)
				    		  	$scope.navCategory.push(data);
				    	});
				    });
				};
				
				$scope.loadArticles = function(){
					$scope.page += 1;
					$http({
                        method: "POST",
                        url: "api/article/listarticle",
                        params: {
                            key: $scope.key,
                            page:$scope.page,
                            uid:$scope.uid,
                            cid:$scope.cid
                        }
                    })
                    .success(function (response) {
                    	if(response.STATUS == "404"){
                    		console.log('no more article..!');
							return;                    		
                    	}
                    	angular.forEach(response.RESPONSE_DATA, function(data, key) {
				    		  $scope.articles.push(data);
				    	});
				    });
				};
					
				$scope.loadCategories();
				$scope.loadArticles();
				
				angular.element($window).bind("scroll", function() {
                    var windowHeight = "innerHeight" in window ? window.innerHeight: document.documentElement.offsetHeight;
                    var body = document.body, html = document.documentElement;
                    var docHeight = Math.max(body.scrollHeight,body.offsetHeight, html.clientHeight,html.scrollHeight, html.offsetHeight);
                    windowBottom = windowHeight + window.pageYOffset;

                    if (windowBottom >= docHeight) {
                    	$scope.$apply($scope.loadArticles());
                    }
     	        });
     	    	
				$scope.loadPopulars = function(){
					$http({
                        method: "POST",
                        url: "api/article/listarticle",
                        params: {
                            key: "",
                            page:1,
                            uid:0,
                            cid:0
                        }
                    })
                    .success(function (response) {
                    	angular.forEach(response.RESPONSE_DATA, function(data, key) {
				    		if(key>5) return;  
                    		$scope.populars.push(data);
				    	});
                    	console.log($scope.populars);
				    });
				};
				$scope.loadPopulars();
				
				$scope.articleCategory = function(cid){
					$scope.page = 0;
					$scope.uid = 0;
					$scope.cid = cid;
					$scope.articles = [];
					
					$scope.loadArticles();
				};
				
				$scope.articleUser = function(uid){
					$scope.page = 0;
					$scope.uid = uid;
					$scope.cid = 0;
					$scope.articles = [];
					
					$scope.loadArticles();
				};
				
				$scope.searchArticles = function(){
					$scope.page = 0;
					$scope.uid = 0;
					$scope.cid = 0;
					
					$scope.articles = [];
					
					$scope.loadArticles();
				};
			});
		
		</script>
	</body>
</html>
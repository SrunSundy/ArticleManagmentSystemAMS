<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Detail Page</title>

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
						<div class="a-detail">
							<div class="d-title">
								<p>{{article.title}}</p>
								<pre>{{article.postdate |date:'medium'}}</pre>
							</div>	
							<div class="d-body">
								{{article.contents}}
								<br><br><pre>Author : {{article.poster | uppercase}}</pre>
							</div>
							<div class="a-share">
								<pre><span>Facebook</span><span>    Youtube</span><span>   Twitter</span></pre>
							</div>					
						</div>
					</div><!--/end a-body  -->
					
					<div class="a-right-side">
						<ul class="a-popular">
							<li><i class="fa fa-area-chart"></i>Popular Articles</li>
							<li ng-repeat="popular in populars">
								<div class="a-popular-item">
									<a href="../detail/{{popular.id}}" target="_blank"><img src="{{popular.image}}"/></a>
									<p><a href="../detail/{{popular.id}}" target="_blank">{{popular.title}}</a></p>
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
			app.controller('myCtrl', function($scope, $http){
				
				$scope.categories = [];
				$scope.populars = [];
				$scope.article = {};
				$scope.navCategory = [];
				
				$scope.loadCategories = function(){
					$http.get('../category/listcategory').success(function (response) {
				    	angular.forEach(response.RESPONSE_DATA, function(data, key) {
				    		  $scope.categories.push(data);
				    		  if(key<5)
					    		  $scope.navCategory.push(data);
				    	});
				    });
				};
				$http.get('../admin/listarticle/${articleid}').success(function (response) {
					var data = response.RESPONSE_DATA;
		    		$scope.article = {
						title: data.title,
						contents: data.contents,
						postdate: data.postdate,
						poster: data.user.uname
					};
			    });

				$scope.loadCategories();
				
				$scope.loadPopulars = function(){
					$http({
                        method: "POST",
                        url: "../admin/listarticles",
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
			});
		
		</script>
	</body>
</html>
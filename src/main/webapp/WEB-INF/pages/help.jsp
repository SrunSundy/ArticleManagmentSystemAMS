<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Help Page</title>

		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<style>
			*{
				margin: 0 auto;  /* make it center */
				padding: 0px;
				box-sizing: border-box;
				border-radius: 3px;
				border:none;
			}
			
			label{
				font-family:'arial';
			}
			.table{
				margin-bottom: 10px;
				margin-top:10px;
				width: 100%;
			}
			.table td, .table th{
				border:1px solid #fff;
				padding:3px 3px;
				color:#fff;
			}
			td button{
				float:right;
				background-color:#1D9C31;
				padding: 5px 7px;	
			}
			td label{
				background-color:blue;
				padding:2px 10px;
			}
			th{
				background-color:blue;
				font-family:'arial';
			}
			button{
				background-color:blue;
				color:#fff;
				cursor:pointer;
			}
			.button > label{
				font-size:20px;
				color:red;
				float:right;
				background-color:blue;
				color:#fff;
				padding: 0px 10px;
			}
			input, select, button{
				padding: 2px 4px;	
			}
			body{
				background-color: rgba(176, 176, 176, 0.4);
			}
			.a-row{
				width: 90%;
			}
			.a-row > pre{
				margin-top: 10px;
				border: 1px solid blue;
				padding: 15px;
				text-align:center;
				font-size:30px;
				color :blue;
				border-bottom: 1px solid blue;
			}
			.action-url{
				margin-bottom: 10px;
				align:center;
			}
			.tb-action{
				width: 100%;
			}
			.tb-action td{
			}
			.tb-action input{
				width: 100%;
				padding:5px 10px;
				text-transform:lowercase;
			}
			.tb-action button{
				padding: 5px 10px;
				width: 100%;
			}
			.tb-action td label{
				width:100%;
				background-color:#AC1313;
				color:#fff;
				padding: 4px 10px;
			}
			.tb-action td#method{
				width:10px;
			}
			.tb-action td#send{
				width:100px;
			}
			.data-block textarea{
				width: 100%;
				height: 220px;
				margin-bottom: 10px;
				padding: 5px;
			}
			.button{
				margin-top: 10px;
			}
			.button button{
				padding: 5px;
				background-color: blue;
				color:#fff;
				cursor:pointer;
			}
			.data-block .resp-data{
				height: 300px;
			}
		</style>
	</head>
	<body ng-app="myApp" ng-controller="myCtrl">
		
		<div class="main-container">
		
			<div class="a-container">
			
				<div class="a-row">
					<pre>Article Web API | help</pre>
					<div class="action-block">
						<div class="button">
							<button ng-click="showTable('article')">ARTICLE</button>
							<button ng-click="showTable('user')">USER</button>
							<button ng-click="showTable('category')">CATEGORY</button>
							<label>URL : https://article-api.herokuapp.com/</label>
						</div>
						<div class="table-block">
							<table class="table">
								<tr>
									<th>RELATIVE_URL</th>
									<th>METHOD</th>
									<th>DESCRIPTION</th>
								</tr>
								<tr ng-repeat="api in apiDocuments">
									<td><label>{{api.url}}</label><button ng-click="copy(api.url, api.method)">t r y</button></td>
									<td><label>{{api.method}}</label></td>
									<td><label>{{api.description}}</label></td>
								</tr>
							</table>
						</div>
						
						<div class="action-url">
							<table class="tb-action">
								<tr>
									<td id="method"><label>{{method}}</label></td>
									<td id="url"><input type="text" placeholder="Enter request URL here" ng-model="url"/></td>
									<td id="send"><button ng-click="sendData()">SEND</button></td>
								</tr>
							</table>
						</div>
						
						<div class="data-block">
							<textarea class="input-data" ng-show="dataStatus">{{masterSample | json}}</textarea>
							<textarea class="resp-data">{{responseData | json}}</textarea>
						</div>
						
					</div>
				</div><!--/end a-row  -->
				
			</div><!--/end a-container  -->
			
		</div><!--/end main container  -->
		
		
		
		<script>
			var app = angular.module('myApp', []);
			app.controller('myCtrl', function($scope, $http){
				
				$scope.articleSample = {id : 1, title : "phearun", description : "rathphearun123@gmail.com", image : "orange.png", contents : "orange juice", status : 1, category : { id : 1 }, user : { uid : 1 }};
				$scope.userSample = {uid : 1, uname : "phearun", uemail : "phearun@gmail.com", ugender : "male", upassword : "12345", utype : 1, ustatus : 1, uimage : "me.png"};
				$scope.categorySample = {id : 1, name : "technology", description : "talk about technology", status : 1};
				$scope.method = "GET";
				
				$scope.dataStatus = false;
				
				$scope.masterSample = {};
				
				$scope.showTable = function(type){
					
					$scope.responseData = "RESPONSE_DATA";
					
					$http.get('api/doc/'+type).success(function(response){
						$scope.url = "";
						$scope.apiDocuments = response;
					});
					
					if(type == "article") 
						$scope.masterSample = $scope.articleSample;
					else if(type == "user") 
						$scope.masterSample = $scope.userSample;
					else 
						$scope.masterSample = $scope.categorySample;
					
				};
				
				$scope.showTable('article');
				
				$scope.copy = function(url, method){
					
					$scope.responseData = "RESPONSE_DATA";
					
					if(method == "POST" || method == "PUT")
						$scope.dataStatus = true;
					else
						$scope.dataStatus = false;
					
					$scope.method = method;
					$scope.url = url;
				};
				
				
				$scope.sendData = function(){
					
					if($scope.method == "POST" || $scope.method == "PUT"){
						$http({
							method: $scope.method,
							url: $scope.url,
							data: JSON.stringify($scope.masterSample)
						}).success(function(response){
							$scope.responseData = response;
						});
					}else{
						$http({
							method: $scope.method,
							url: $scope.url
						}).success(function(response){
							$scope.responseData = response;
						});
					}
					/*.then(function(response){
						$scope.responseData = response;
					}); //provide more info */
				};
				
			});
		
		</script>
	</body>
</html>
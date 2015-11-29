<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<div class="a-nav">
	<div class="nav-search">
		<i class="fa fa-search"></i>
		<input type="text" name="searchkey" placeholder="search here..." ng-model="key"/>
		<button ng-click="searchArticles()">search</button>
	</div>
	<div class="nav-category">
		<ul>
			<li><a href="${pageContext.request.contextPath }"><i class="fa fa-home"></i>Home</a></li>
			<li ng-repeat="category in navCategory" ng-click="articleCategory(category.id)">{{category.name}}</li>
		</ul>
	</div>
	
</div>
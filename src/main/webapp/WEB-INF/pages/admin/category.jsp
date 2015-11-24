<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <%@ taglib prefix="frm" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@include file="include/header.jsp" %>



<title>category</title>
 <style>
		.tablex th, .tablex td { 
    		 border-top: none !important; 
 		}
 		input[type=checkbox]{
		   background: #888 !important;
		   border: none !important;
		   color: #000 !important;
		}
 </style>
</head>
<body>
	<%@include file="include/topmenu.jsp"%>

<div id="wrapper" style="margin-top: 54px;">

<%@include file="include/leftbar.jsp"%>

	<div class="col-sm-12" ng-app="myApp" ng-controller="myCtrl" >
	    
		<h1> WELCOME CATEGORY PAGE</h1>
		
		<button type="button" class="btn btn-success btn-msg" data-toggle="modal" data-target="#myAdd" ng-click="viewCategory(cat.id)"><i class="fa fa-plus"></i>Add</button>
		<br/><br/>

		<table class="table">
			    <tr>
			    	<th> ID </th>
			    	<th> NAME </th>
			    	<th> DESCRIPTION </th>
			    	<th> STATUS </th>
			    	<th> ACTION </th>
			    </tr>
				<tr ng-repeat="cat in category.RESPONSE_DATA" >
					<td>{{ $index+1 }} <input type="hidden" value="{{ cat.id }}"/></td>
				    <td>{{ cat.name }} </td>
				    <td>{{ cat.description }} </td>
				    <td>
				       <div>
			               <input type="checkbox" value={{cat.status}} ng-click="statusCategory(cat.id,cat.status)" checked ng-if="cat.status == 1 " 
			               	data-toggle="modal" data-target="#myCheck" />
			               <input type="checkbox" value={{cat.status}} ng-click="statusCategory(cat.id,cat.status)" ng-if="cat.status == 0" 
			               data-toggle="modal" data-target="#myCheck"/>
				       </div>
				    	
				   
				    	
				    </td>
				    <td>
				    	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#myView" ng-click="viewCategory(cat.id)"><i class="fa fa-desktop"></i>View</button>
				    	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myEdit" ng-click="viewCategory(cat.id)"><i class="fa fa-pencil"></i>Edit</button>
				     </td>
				</tr>
			</table>
			
			<!-- Modal Check -->
			<div class="modal fade" id="myCheck" role="dialog">
		    <div class="modal-dialog modal-sm">
		    
		      <!-- Modal content-->
		      <div class="modal-content">

		        <div class="modal-body">
					<h4 ng-if="bool==true"><div class="alert alert-danger">
					  		<strong>Status {{cstatus}}</strong> 
						</div>
					</h4>
					
					<h4 ng-if="bool==false"><div class="alert alert-info">
					  		<strong>Status {{cstatus}}</strong> 
						</div>
					</h4>
		        </div>
	
		      </div>		      
		    </div>
		  </div>
		  
		  	<!-- Modal Add Msg-->
			<div class="modal fade" id="myAddMsg" role="dialog">
		    <div class="modal-dialog modal-sm">
		    
		      <!-- Modal content-->
		      <div class="modal-content">

		        <div class="modal-body">
					<h4><div class="alert alert-success">
					  		<strong>Add Success!</strong> 
						</div>
					</h4>
		        </div>
	
		      </div>		      
		    </div>
		  </div>
		  
		  	<!-- Modal Edit Msg -->
			<div class="modal fade" id="myEditMsg" role="dialog">
		    <div class="modal-dialog modal-sm">
		    
		      <!-- Modal content-->
		      <div class="modal-content">

		        <div class="modal-body">
					<h4><div class="alert alert-success">
					  		<strong>Update Success!</strong> 
						</div>
					</h4>
		        </div>
	
		      </div>		      
		    </div>
		  </div>
		  
		  
			<!-- Modal View -->
		  <div class="modal fade" id="myView" role="dialog" data-keyboard="false" data-backdrop="static">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title"><i class="fa fa-line-desktop"></i><i class="fa fa-desktop"></i>View Category</h4>
		        </div>
		        <div class="modal-body">
		          <table class="table table-border tablex">

		          	<tr>
		          		<th>NAME</th>
		          		<td>{{ name }}</td>
		          	</tr>
		          	<tr>
		          		<th>Description</th>
		          		<td>{{ description }}</td>
		          	</tr>
		            <tr>
		          		<th>Status</th>
		          		<td>{{ status }}</td>
		          	</tr>
		          </table>
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
		      </div>
		      
		    </div>
		  </div>
		  
		  			<!-- Modal Update -->
		  <div class="modal fade" id="myEdit" role="dialog" data-keyboard="false" data-backdrop="static">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title"><i class="fa fa-pencil"></i> Update Category</h4>
		        </div>
		        <div class="modal-body">
		        <frm:form id="frmedit" class="form-horizontal" modelAttribute="category" ng-submit="updateCategory($event)">
					<table class="table table-border tablex">
		          	<tr>
		          		<input type="hidden" value="{{id}}" id="id" name="id"/>
		          		<th>NAME</th>
		          		<td><input type="text" class="form-control" value="{{name}}" name="name" required id="name" placeholder="Category Name"/></td>
		          	</tr>
		          	<tr>
		          		<th>Description</th>
		          		<td><input type="text" class="form-control" value="{{description}}" name="description" id="description" placeholder="Category Description"/></td>
		          	</tr>
		          	<tr>
		          		<th></th>
		          		<td>
		          			<button type="submit" class="btn btn-success"><i class="fa fa-pencil" data-toggle="modal" data-target="#myEdit"></i>SUBMIT</button>
		          			<button type="button" class="btn btn-warning" ng-click="updateClear()"><i class="fa fa-eraser"></i>CLEAR</button>
		          		</td>
		          	</tr>
		          </table>
				 </frm:form>

		          
		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
		      </div>
		      
		    </div>
		  </div>
		  
		  <!-- Modal Add -->
		  <div class="modal fade" id="myAdd" role="dialog" data-keyboard="false" data-backdrop="static">
		    <div class="modal-dialog">
		    
		      <!-- Modal content-->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title"><i class="fa fa-plus"></i>Add Category</h4>
		        </div>
		        <div class="modal-body">
		        <frm:form id="frmadd" class="form-horizontal" modelAttribute="category" ng-submit="addCategory($event)">
					<table class="table table-border tablex">
		          	<tr>
		          		<input type="hidden" id="id" name="id" />
		          		<th>NAME</th>
		          		<td><input type="text" class="form-control"  name="name" required id="name" placeholder="Category Name" /></td>
		          	</tr>
		          	<tr>
		          		<th>Description</th>
		          		<td><input type="text" class="form-control"  name="description" id="description" placeholder="Category Description" /></td>
		          	</tr>
		          	<tr>
		          		<th></th>
		          		<td>
		          			<button type="submit" class="btn btn-success" ><i class="fa fa-plus"></i>SUBMIT</button>
		          			<button type="button" class="btn btn-warning" ng-click="addClear()"><i class="fa fa-eraser"></i>CLEAR</button>
		          		</td>
		          	</tr>
		          </table>
				 </frm:form>

		        </div>
		        <div class="modal-footer">
		          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
		      </div>
		      
		    </div>
		  </div>
	
	</div>
	
	 <script>
	 	var app = angular.module('myApp',[]);
		app.controller('myCtrl',function($scope,$http,$timeout){
			   
			   $scope.category={};
			   
			   // Load list category			   
			   $scope.categoryfunc = function(){
				  $http.get('${pageContext.request.contextPath}/category/listcategory')
				  .success(function(data, status, headers, config) {
					  
				      $scope.category = data;
				      console.log($scope.category);
				      
				    }).
				    error(function(data, status, headers, config) {
				    	console.log('load data error...');
				    });
			   }
			   
			   // call list funciton
			   $scope.categoryfunc();
			   
			   $scope.id = "";
			   $scope.name = "";
			   $scope.description = "";
			   //view category by id
			 	$scope.viewCategory = function(id){
					$http.get('${pageContext.request.contextPath}/category/getcategory/'+id).
				    success(function(data, status, headers, config) {

				      console.log(data);

				      $scope.id = data.RESPONSE_DATA.id;
				      $scope.name = data.RESPONSE_DATA.name;
				      $scope.description = data.RESPONSE_DATA.description;
				      
				      angular.element("#frmedit input[name='id']").val($scope.id);
				      angular.element("#frmedit input[name='name']").val($scope.name);
				 	  angular.element("#frmedit input[name='description']").val($scope.description);
				 		
				      $scope.status = 0;
				      if ( data.RESPONSE_DATA.status == 1){
				    	  $scope.status = "Enable";
				      }else{
				    	  $scope.status = "Disable";
				      }
				      
				    }).
				    error(function(data, status, headers, config) {
				    	console.log('load data error...');
				    });
				}
			   
			   
			   //update category path object
			 	$scope.updateCategory = function($event){				   
				   $event.preventDefault();
					console.log( angular.element("#frmedit input[name='description']").val() );
					
					var dataObj = {
							"id" : angular.element("#frmedit input[name='id']").val(),
							"name" : angular.element("#frmedit input[name='name']").val(),
							"description" : angular.element("#frmedit input[name='description']").val()
					};	
					$http.put('${pageContext.request.contextPath}/category/updatecategory',dataObj).
				    success(function(data, status, headers, config) {
				      console.log(data);
				   
				      
				      angular.element('#myEdit').modal('hide');
				      $scope.categoryfunc();				      
				      
				      angular.element('#myEditMsg').modal('show');
				      $timeout(function() { angular.element('#myEditMsg').modal('hide'); }, 2000);
  	
				    }).
				    error(function(data, status, headers, config) {
				    	console.log('load data error...');
				    });
					
  					

				}
			   
				   //add category path object
			 	$scope.addCategory = function($event){				   
				   $event.preventDefault();
					console.log( angular.element("#frmadd input[name='description']").val() );
					
					var dataObj = {
							"name" : angular.element("#frmadd input[name='name']").val(),
							"description" : angular.element("#frmadd input[name='description']").val()
					};	
					$http.post('${pageContext.request.contextPath}/category/addcategory',dataObj).
				    success(function(data, status, headers, config) {
				      console.log(data);
				      
				      angular.element('#myAdd').modal('hide');
				      $scope.categoryfunc();
				      angular.element('#myAddMsg').modal('show');
				      $timeout(function() { angular.element('#myAddMsg').modal('hide'); }, 2000);
				      
				      
				    }).
				    error(function(data, status, headers, config) {
				    	console.log('load data error...');
				    });
					
					$scope.addClear();
				}
				   
				
				// category change status
			 	$scope.statusCategory = function(id,status){

			 		$scope.cstatus = "";
			 		$scope.bool = false;
			 		if (status == 0){
			 			$scope.cstatus = "Enables";
			 			$scope.bool = false;
			 		}else if (status == 1){
			 			$scope.cstatus = "Disables";
			 			$scope.bool = true;
			 		}
			 		
			 		$timeout(function() { angular.element('#myCheck').modal('hide'); }, 2000);	
					$http.put('${pageContext.request.contextPath}/category/statuscategory/'+id+'/'+status).
				    success(function(data, status, headers, config) {
				    	
				      	
				      $scope.categoryfunc();
				      console.log(data);
				    }).
				    error(function(data, status, headers, config) {
				    	console.log('load data error...');
						$scope.cstatus = "Error...";
						//setTimeout(function() { $('#myCheck').modal('hide'); }, 2000);
				    });
					

				}
			 	
			 	// clear form
			 	$scope.updateClear = function(){
			 		
			 		angular.element("#frmedit input[name='name']").val("");
			 		angular.element("#frmedit input[name='description']").val("");
	
				}
	
			 	$scope.addClear = function(){
			 		
			 		angular.element("#frmadd input[name='name']").val("");
			 		angular.element("#frmadd input[name='description']").val("");
	
				}


		});

	</script>





	
</div>
<%@include file="include/footer.jsp" %>


</body>
</html>
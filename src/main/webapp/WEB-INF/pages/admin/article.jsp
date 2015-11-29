<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="include/header.jsp"%>
<%@include file="include/footer.jsp"%>
<title>Insert title here</title>
</head>
<body>
      	
	<%@include file="include/topmenu.jsp"%>

<div id="wrapper" style="margin-top: 54px;">
<%@include file="include/leftbar.jsp"%>


		<div style="height:20px;"  class="col-sm-12"></div>
		<div id="content" class="col-sm-12">
			<fieldset>
				<legend><span style="font-weight:bold;font-size:20px;">ARTICLE</span><span style="font-size:14px;"> Management</span></legend>
			
			<form role="form" method="POST" id="formarticle">
			
				<div class="col-sm-6">
					<div class="form-group">
					  <label for="cat">News-Cat</label>
					 <div id="cateoption"></div>
					</div>
				</div>
				<div class="col-sm-6">
					 <div class="form-group">
			    		<label for="title">Title:</label>
			   			 <input type="text" class="form-control" id="title" name="title">
			  		</div>
			  	</div>
			  	<div class="col-sm-6">
				  	<div class="form-group">

							<div class="fileinput fileinput-new" data-provides="fileinput">
								<div class="fileinput-preview thumbnail"
									data-trigger="fileinput" id='disimage'
									style="width: 400px; height: 200px;"></div>
								<div>
									<span class="btn btn-default btn-file"><span
										class="fileinput-new">Select image</span><span
										class="fileinput-exists">Change</span><input id='image'
										type="file" name="image"></span> <a href="#"
										class="btn btn-default fileinput-exists"
										data-dismiss="fileinput">Remove</a>
								</div>
							</div>
						</div>
			 
			  <!-- <button type="submit" class="btn btn-default">Submit</button> -->
				
				</div>
				<div class="col-sm-6">
					<div class="form-group">
							<label for="comment">Description:</label>
							<textarea class="form-control" rows="5" id="description" name="description"></textarea>
						</div>
				</div>
				
				<div class="col-sm-12">
								<textarea name="contents" id="contents">&lt;p&gt;Initial editor content.&lt;/p&gt;</textarea>

								<script>
									CKEDITOR
											.replace(
													'contents',
													{
														filebrowserBrowseUrl : 'plugin/Filemanager-master/index.html',

													});
								</script>
				</div>
			 	
			 	<div class="col-sm-12" style="padding-bottom:20px;">
			 		<input type="button" onclick="insertArticle()" style='width:200px;height:50px;margin-top:5px; background:#388E3C;border:1px;color:white;font-size:25px;' value="Insert" id="insertarticle" />
			 	</div>
			</form>	
			</fieldset>
			
		</div>
		
	
</div>

 <script>
		var imagech=0;
		getCategoty();
		var id="${param.id}";
	
		if(!(id==null || id=="")){
			requestArticle();
			$("#insertarticle").attr("onclick","updateArticle("+id+")")
							.val("Edit");
		}
		$("#image").change(function(){
			imagech=1;
		});
		
		
	
		
		function getCategoty(){
			
			  $.ajax({
					type: "GET",
		            url: "${pageContext.request.contextPath}/api/category/", 
		            success: function(data){ 
		            	var select=" <select class='form-control' id='category' name='category'>";
		            	for(var i=0;i<data.RESPONSE_DATA.length;i++){
		            		select+="<option value='"+data.RESPONSE_DATA[i].id+"'>"+data.RESPONSE_DATA[i].name+"</option>";
		            	}
		            	select+=" </select>";
		            	$("#cateoption").html(select);
		            },
		            error: function(data){
		            	alert("Unsuccess" + data);
		            	console.log("ERROR..." + data);
		            }
				});
		}
		//requestArticle();
		function insertArticle(){
			var filename = $("#image").val().split('\\').pop();
			var value = CKEDITOR.instances['contents'].getData();
			json={
					title : $("#title").val(),
	            	description : $("#description").val(),
	            	image : filename,
	            	contents : value,
	            	user : { 
	            		uid : 1
	            	},
	            	category : {
	            		id : $("#category").val()
	            	}      	
			}; 
		
			$.ajax({
				type: "POST",
				contentType : "application/json",
	            url: "${pageContext.request.contextPath}/api/article/", 
	            data : JSON.stringify(json),
	            success: function(data){ 
	            	alert(data);
	            	uploadAImage();
	            },
	            error: function(data){
	            	alert("Unsuccess" + data);
	            	console.log("ERROR..." + data);
	            }
			});
			
		}
		function uploadAImage(){
			var data1;
		    data1 = new FormData($(this)[0]);
		    data1.append('file', $('#image')[0].files[0]);
			$.ajax({
				url : "${pageContext.request.contextPath}/api/article/uploadimg/",
				type : "POST",
				cache: false,
				contentType: false,
				processData: false,
				data : data1,
				success:function(data){
					
					alert(1);
				}
			});
		}
		function requestArticle(){
			
			
			$.ajax({
				type : "GET",
				url : "${pageContext.request.contextPath}/api/article/"+id,
				contentType: "application/json",
		        dataType: 'json',
		      
		        success: function(data){
		        	//alert(data.RESPONSE_DATA.title);
		        	$("#title").val(data.RESPONSE_DATA.title);
		        	$("#description").val(data.RESPONSE_DATA.description);
		        	$("#contents").val(data.RESPONSE_DATA.contents);
		        	$("#category").val(data.RESPONSE_DATA.category.id);
		        	oldimage=data.RESPONSE_DATA.image;
		        	$("#disimage").html("<img src='${pageContext.request.contextPath}/images/"+data.RESPONSE_DATA.image+"' />");
		        },
		        error: function(data){
	            	//alert("Unsuccess" + data);
	            	console.log("ERROR..." + data);
	            }
		        
			});
		}
		function updateArticle(id){
			
			var filename ;
			alert(imagech);
			if(imagech==0){
				filename=oldimage;
			}else{
				alert(imagech);
				filename=$("#image").val().split('\\').pop();
			}
			alert(filename);
			
			json={
					id : id,
					title : $("#title").val(),
	            	description : $("#description").val(),
	            	image : filename,
	            	contents : $("#contents").val(),
	            	user : { 
	            		uid : 1
	            	},
	            	category : {
	            		id : $("#category").val()
	            	}      	
			}; 
			
			
			$.ajax({
				type: "PUT",
				contentType : "application/json",
	            url: "${pageContext.request.contextPath}/api/article/", 
	            data : JSON.stringify(json),
	            success: function(data){ 
	            	
	            	uploadAImage();
	            	
	            	location.href=""+data.REDIRECT;
	            },
	            error: function(data){
	            	alert("Unsuccess" + data);
	            	console.log("ERROR..." + data);
	            }
			});
			
		}
		
		
	</script>
</body>
</html>
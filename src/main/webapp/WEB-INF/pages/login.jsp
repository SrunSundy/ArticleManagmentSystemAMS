<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrape/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/fontawesome/css/font-awesome.min.css">

<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/bootstrape/js/bootstrap.min.js"></script>
 
<style>
div.header{

	height:150px;
}
.fontawesome-icon{
	margin-top:10px;
	font-size: 18px;
	color: #43A047;
}
h3.welcome-text{
	font-weight: bold;
	font-style: italic;
	border-bottom: 3px solid #43A047;
	padding-bottom: 10px;
	color: #43A047;
}
input#btnlogin{
	color: white;
	background: #43A047;
	height: 40px;
	transition: all 0.2s linear; 
}
input#btnlogin:hover{
	opacity: 0.8;
}
</style>
</head>
<body>

		<div class="header"></div>
		<div class="content">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<fieldset>
					
					<h3 class="welcome-text">Welcome To Article Management</h3>
				
					<div class="col-sm-12 form-group" style="margin-top:15px;">
						<label class="col-sm-1 fontawesome-icon" ><i class="fa fa-user"></i></label>
						<div class="col-sm-11">
							<input type="text" name="email" id="email" class="form-control" placeholder="User's email"/>
						</div>
					</div>
					
					<div class="col-sm-12 form-group" style="">
						<label class="col-sm-1 fontawesome-icon" ><i class="fa fa-key"></i></label>
						<div class="col-sm-11">
							<input type="password" name="password" id="password" class="form-control" placeholder="User's password"/>
						</div>
					</div>
					
					<div class="col-sm-12 form-group" style="">
						<div class="col-sm-6"></div>
						<div class="col-sm-6">
							<input type="button" onclick="actionLogin()" name="btnlogin" id="btnlogin" class="form-control" value="Login"/>
						</div>
					</div>
					
				</fieldset>
			</div>
			<div class="col-sm-3"></div>
		</div>
		<script>
			function actionLogin(){
				var json={
					uemail : $("#email").val(),
					upassword : $("#password").val()
						
				};
				$.ajax({
					type : "POST",
					contentType : "Application/json",
					url : "${pageContext.request.contextPath}/api/login/",
					data :  JSON.stringify(json),
					success : function(data){
						if(data.REDIRECT==null){
							alert("Login failed!");
						}else{
							location.href="${pageContext.request.contextPath}/"+data.REDIRECT;
						}
					}
				});
			}
		</script>
	</body>
</html>
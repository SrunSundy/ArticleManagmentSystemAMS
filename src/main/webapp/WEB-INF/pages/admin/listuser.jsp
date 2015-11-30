<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@include file="include/header.jsp"%>

<style>
table tr.tbheader {
	color: white;
	background: #757575;
	font-family: "Times New Roman", Georgia, Serif;
}

span.searchresult {
	color: #757575;
	font-style: italic;
	font-family: "Times New Roman", Georgia, Serif;
}

.user-profile {
	border-radius: 50%;
	width: 30px;
}

.ustatus {
	cursor: pointer;
	margin-left: 10px
}

.btnadd {
	border-radius: 0;
	margin-bottom: 20px;
}

.frmpanel {
	margin-bottom: 10px;
}

.frmadd {
	color: #fff;
	background-color: #5cb85c;
	border-color: #4cae4c;
}
</style>
<title>List User</title>
</head>
<body>
	<%@include file="include/topmenu.jsp"%>



	<div id="wrapper" style="margin-top: 54px;">
		<%@include file="include/leftbar.jsp"%>
		<div style="height: 20px;" class="col-sm-12"></div>

		<div id="content" class="col-sm-12">
			<!-- Add Form for Add User Information -->
			<!-- Trigger the modal with a button -->
			<button type="button" class="btn btn-success btnadd"
				data-toggle="modal" data-target="#myadd">
				<i class='fa fa-plus'></i> Add User
			</button>
			<fieldset>
				<legend>
					<span style="font-weight: bold; font-size: 20px;">User</span><span
						style="font-size: 14px;"> List information</span>
				</legend>
				<div class="col-sm-12">
					<div class="col-sm-9 ">
						<div class="row">
							<div class="row">
								<select id="rowset"
									style="height: 32px; border: 1px solid #E0E0E0; border-radius: 5px;">
									<option value="10">10</option>
									<option value="20">20</option>
								</select> <span class="searchresult " style="">Result : <span
									id="rowshow"></span><span id="recordresult"></span></span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="row">
							<div class="col-sm-3">

								<input type="search" onkeyup="listUser(1); getUserRow();"
									id="searcharticle" class="form-control" placeholder="Searching"
									style="margin: 0 0 0 15px; height: 32px; border: 1px solid #E0E0E0; border-radius: 5px;" />

							</div>
						</div>
					</div>
				</div>


				<!-- Modal Add -->
				<div id="myadd" class="modal fade" role="dialog"
					data-keyboard="false" data-backdrop="static">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" onclick="frmclose()">&times;</button>
								<h4 class="modal-title">User Information</h4>
							</div>
							<div class="modal-body">
								<form id="frmuser">
									<div class="row frmpanel">
										<div class="col-md-6 col-sm-12">
										    <input type="hidden" id="id"/>
											<input type="text" class="form-control"
												placeholder="UserName" id="username" required="required">
										</div>
										<div class="col-md-6 col-sm-12">
											<input type="password" class="form-control"
												placeholder="Password" id="password" required="required">
										</div>
									</div>
									<div class="row frmpanel">
										<div class="col-md-6 col-sm-12">
											<input type="email" class="form-control" placeholder="Email"
												id="email" required="required">
										</div>
										<div class="col-md-6 col-sm-12">
											<select class="form-control" id="gender">
												<option value="1">Male</option>
												<option value="2">Female</option>
											</select>
										</div>
									</div>
									<div class="row frmpanel">
										<div class="col-md-6 col-sm-12">
											<select class="form-control" id="type">
												<option value="1">Admin</option>
												<option value="2">User</option>
											</select>
										</div>
										<div class="col-md-6 col-sm-12">
											<select class="form-control" id="status">
												<option value="1">Enable</option>
												<option value="0">Disable</option>
											</select>
										</div>
									</div>
									<div class="row frmpanel">
										<div class="col-md-12 col-sm-12">
											<div class="fileinput fileinput-new"
												data-provides="fileinput" style="width: 100%;">
												<div class="fileinput-preview thumbnail"
													data-trigger="fileinput" id='disimage'
													style="width: 100%; height: 200px;"></div>
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
									</div>
									<div class="row frmpanel">
										<div class="col-md-12 col-sm-12">
											<input type="submit" id="btnadd" class="form-control frmadd"
												value="Add">
										</div>
									</div>
								</form>
								<h3 style="color: red; text-align: center" id="msg"></h3>
							</div>
						</div>

					</div>
				</div>
				<div id="listuserresult"></div>
				<div id="content"></div>
				<div id="demo4_top" class="demo4_top"></div>
			</fieldset>

		</div>


	</div>
	<%@include file="include/footer.jsp"%>
	<script>
		var dbrow = 0;
		var numofpage = 0;
		var rowshow = 10;
		var imagech = 0;
		$("#image").change(function() {
			imagech = 1;
		});
		listUser(1);
		getUserRow();
		//clear form control
		function clear() {
			$("#username").val("");
			$("#password").val("");
			$("#email").val("");

			//use to clear image from jasny boostrap
			$(".fileinput").fileinput("clear");

		}

		//upload image
		function uploadAImage() {
			var data1;
			data1 = new FormData($(this)[0]);
			data1.append('file', $('#image')[0].files[0]);
			$
					.ajax({
						url : "${pageContext.request.contextPath}/api/article/uploadimg/",
						type : "POST",
						cache : false,
						contentType : false,
						processData : false,
						data : data1,
					});
		}
		//insert user information
		$("#frmuser").submit(function(e) {
			e.preventDefault();
			//add action
			if ($("#btnadd").val() == "Add") {
				var filename = $("#image").val().split('\\').pop();
				json = {
					uname : $("#username").val(),
					upassword : $("#password").val(),
					uemail : $("#email").val(),
					ugender : $("#gender").val(),
					utype : $("#type").val(),
					ustatus : $("#status").val(),
					uimage : filename
				};
				// alert(JSON.stringify(json));
				$.ajax({
					method : "POST",
					contentType : "application/json",
					url : "${pageContext.request.contextPath}/api/user/",
					data : JSON.stringify(json),
					success : function(data) {
						uploadAImage();
						clear();
						$("#myadd").modal('hide');
						listUser(1);
						getUserRow();

					},
					error : function(data) {
						clear();
						$("#msg").html("ADD USER FAILD PLEACE TRY AGINA !");
					}
				})
			// edit action 
			} else {
				if (imagech == 0) {
					filename = oldimage;
				} else {
					filename = $("#image").val().split('\\').pop();
				}
				json = {
					uid :$("#id").val(),
					uname : $("#username").val(),
					upassword : $("#password").val(),
					uemail : $("#email").val(),
					ugender : $("#gender").val(),
					utype : $("#type").val(),
					ustatus : $("#status").val(),
					uimage : filename
				};
			 	$.ajax({
						method : "PUT",
						contentType : "application/json",
						url : "${pageContext.request.contextPath}/api/user/",
						data : JSON.stringify(json),
						success : function(data) {			
							if (imagech == 0) {
								clear();
								$("#myadd").modal('hide');
								listUser(1);
								getUserRow(); 
							} else {
								uploadAImage();
								clear();
								$("#myadd").modal('hide');
								listUser(1);
								getUserRow(); 
							}
							imagech=0;
						},
						error : function(data) {
							clear();
							$("#msg").html("ADD USER FAILD PLEACE TRY AGINA !");
						}
					})   
			}
		});
		function getUserRow() {
			var key = $("#searcharticle").val();
			if (key == "" || key == null) {
				key = "*";
			}
			$.ajax({
				method : "GET",
				url : "${pageContext.request.contextPath}/api/user/getrow/"
						+ key,
				success : function(data) {
					dbrow = data.RESPONSE_DATA;
					var npage;
					var nps = dbrow / 10;

					if (!(dbrow % rowshow == 0)) {
						npage = Math.floor(nps);
						npage += 1;
					} else {
						npage = nps;
					}
					numofpage = npage;

					$("#rowshow").html(dbrow + " records");
					loadPagination();
				}
			});
		}
		function loadPagination() {

			$('.demo4_top').bootpag({
				total : numofpage,
				maxVisible : 5,
				leaps : true,
				firstLastUse : true,
				first : '&#8592;',
				last : '&#8594;',
				wrapClass : 'pagination',
				activeClass : 'active',
				disabledClass : 'disabled',
				nextClass : 'next',
				prevClass : 'prev',
				lastClass : 'last',
				firstClass : 'first'
			}).on("page", function(event, num) {
				listUser(num);
			});
		}
		//status user
		function statususer(id) {
			$.ajax({
				url : "${pageContext.request.contextPath}/api/user/toggle/"
						+ id,
				type : 'PATCH',
				success : function(data) {
					listUser(1);
					getUserRow();
				}
			});
		}
		//list user show as table
		function listUserTb(data) {
			if (data.RESPONSE_DATA != null) {
				jsonUser = data.RESPONSE_DATA;
				if (jsonUser.length != 0) {
					var tb = "<table class='table'>";
					tb += "<tr class='tbheader'>";
					tb += "<th>ID</th>";
					tb += "<th>Name</th>";
					tb += "<th>Email</th>";
					tb += "<th>Gender</th>";
					tb += "<th>Type</th>";
					tb += "<th>Status</th>";
					tb += "<th>Image</th>";
					tb += "<th>Action</th>";
					tb += "</tr>";
					$
							.each(
									jsonUser,
									function(i, b) {
										tb += "<tr>";
										tb += "<td>" + b.uid + "</td>";
										tb += "<td>" + b.uname + "</td>";
										tb += "<td>" + b.uemail + "</td>";
										tb += "<td>";
										if (b.ugender == 1) {
											tb += "male";
										} else {
											tb += "female";
										}
										tb += "</td>";
										tb += "<td>";
										if (b.utype == 1) {
											tb += "admin";
										} else {
											tb += "user";
										}
										tb += "</td>";
										tb += "<td>";
										if (b.ustatus == 0) {
											tb += "<i class='glyphicon glyphicon-remove ustatus' onclick='statususer("
													+ b.uid + ")'></i>";
										} else {
											tb += "<i class='glyphicon glyphicon-ok ustatus' onclick='statususer("
													+ b.uid + ")'></i>";
										}
										tb += "</td>";
										tb += "<td><img class='user-profile' src='${pageContext.request.contextPath}/images/"+ b.uimage +"'/></td>";
										tb += "<td><button type='button' class='btn btn-success'​ onclick='edituser("
												+ b.uid
												+ ")'><i class='glyphicon glyphicon-edit'></i></button></td>";
										tb += "</tr>";
									});
					tb += "</table>";
					return tb;
				}
			}

		}
		function listNFtb() {
			var tb = "<table class='table tbstyle'>";
			tb += "<tr class='tbheader '>";
			tb += "<th>ID</th>";
			tb += "<th>Name</th>";
			tb += "<th>Password</th>";
			tb += "<th>Email</th>";
			tb += "<th>Gender</th>";
			tb += "<th>Type</th>";
			tb += "<th>Status</th>";
			tb += "<th>Image</th>";
			tb += "<th >Action</th></tr>";
			tb += "<tr><td colspan='8'><span class='dnfound' >DATA NOT FOUND</span></td></tr>";
			return tb;
		}
		//list user
		function listUser(mypage) {
			var key = $("#searcharticle").val();
			if (key == "" || key == null) {
				key = "*";
			}
			var page = mypage;
			$.ajax({
				method : "GET",
				url : "${pageContext.request.contextPath}/api/user/" + page
						+ "/" + key,
				success : function(data) {
					if (data.RESPONSE_DATA.length == 0) {
						$("#demo4_top").html("");
						$("#listuserresult").html(listNFtb());
						return;
					}
					$("#listuserresult").html(listUserTb(data));
				}
			});
		}

		//edit user
		function edituser(id) {
			$
					.ajax({
						method : "GET",
						url : "${pageContext.request.contextPath}/api/user/"
								+ id,
						success : function(data) {
							jsonUser = data.RESPONSE_DATA;
							$("#id").val(jsonUser.uid);
							$("#username").val(jsonUser.uname);
							$("#password").val(jsonUser.upassword);
							$("#email").val(jsonUser.uemail);
							$("#gender").val(jsonUser.ugender);
							$("#type").val(jsonUser.utype);
							$("#status").val(jsonUser.ustatus);
							oldimage = jsonUser.uimage;
							$("#disimage").html("<img src='${pageContext.request.contextPath}/images/"+jsonUser.uimage+"' />");
							$("#password").prop('readonly', 'readonly');
							$("#btnadd").prop('value', 'Edit');
							$("#myadd").modal('show');

						}
					});
		}
		function frmclose() {
			clear();
			$("#password").removeAttr("readonly");
			$("#btnadd").prop('value', 'Add');
			$("#myadd").modal('hide');
		}
	</script>
</body>
</html>
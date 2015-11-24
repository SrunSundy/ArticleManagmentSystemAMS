<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	width: 5%;
}

.ustatus {
	cursor: pointer;
	margin-left: 10px
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
				<!-- Add Form for Add User Information -->
				<!-- Trigger the modal with a button -->
				<button type="button" class="btn btn-info btn-sm"
					data-toggle="modal" data-target="#myModal">Add User</button>

				<!-- Modal -->
				<div id="myModal" class="modal fade" role="dialog"
					data-keyboard="false" data-backdrop="static">
					<div class="modal-dialog">

						<!-- Modal content-->
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">Modal Header</h4>
							</div>
							<div class="modal-body">
								<form>
									<table style="width: 100%">
										<tr>
											<td><span>UserName<br /> <input type="text"
													name="username" id="username" required style="width: 90%" /></span></td>
											<td><span>Password<br /> <input type="password"
													name="password" id="password" required style="width: 90%" /></span></td>
											<td><span>Email<br /> <input type="email"
													name="email" id="email" required style="width: 90%" /></span></td>
											<td><span>Birthdate<br /> <input type="date"
													name="birthdate" id="birthdate" required style="width: 90%" /></span></td>
										</tr>
										<tr>
											<td>Image:<br /> <img id="image"
												style="display: none; width: 20%; margin-bottom: 10px; margin-top: 10px;" />
												<input type="hidden" name="image" id="image" /> <input
												type="file" name="file" style="width: 90%" id="file" />
											</td>
										</tr>
										<tr>
											<td><input type="submit" value="Add" id="btn"
												class="addbtn" /></td>
										</tr>
									</table>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
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
		var rowshow = 0;
		listUser(1);
		getUserRow();

		function getUserRow() {
			$.ajax({
				method : "POST",
				url : "${pageContext.request.contextPath}/user/usercount",
				data : {
					acontent : $("#searcharticle").val()
				},
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
		//enable status
		function enablestatus(id) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/user/enableuserstatus",
						type : 'POST',
						data : {
							id : id
						},
						success : function(data) {
							listUser(1);
							getUserRow();
						}
					});
		}
		//disable status
		function disablestatus(id) {
			$
					.ajax({
						url : "${pageContext.request.contextPath}/user/disableuserstatus",
						type : 'POST',
						data : {
							id : id
						},
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
					tb += "<th>Password</th>";
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
										tb += "<td>" + b.upassword + "</td>";
										tb += "<td>" + b.uemail + "</td>";
										tb += "<td>" + b.ugender + "</td>";
										tb += "<td>" + b.utype + "</td>";
										tb += "<td>";
										if (b.ustatus == 0) {
											tb += "<i class='glyphicon glyphicon-remove ustatus' onclick='enablestatus("
													+ b.uid + ")'></i>";
										} else {
											tb += "<i class='glyphicon glyphicon-ok ustatus' onclick='disablestatus("
													+ b.uid + ")'></i>";
										}
										tb += "</td>";
										tb += "<td><img class='user-profile' src='${pageContext.request.contextPath}/upload/"+ b.uimage +"'/></td>";
										tb += "<td><span class='glyphicon glyphicon-edit ustatus'  onclick='disablestatus("
												+ b.uid + ")'></span></td>";
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
			$.ajax({
				url : "${pageContext.request.contextPath}/user/getalluser",
				type : 'POST',
				data : {
					page : mypage,
					key : $("#searcharticle").val()
				},
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
	</script>
</body>
</html>
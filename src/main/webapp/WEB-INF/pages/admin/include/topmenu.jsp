

<nav class="navbar jar navbar-inverse navbar-fixed-top ">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-responsive-collapse">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" style="margin-top: -5px;"><img style="width:25px;height:25px;"
				src="${pageContext.request.contextPath}/images/logo.png" /></a> <a class="navbar-brand text-menu"
				style="color: white" href="#"><b>AMS</b> Management</a>
			<!--head fix -->
			 <a href="#menu-toggle" class="navbar-brand box-menu" style="margin-left:10px;"
				id="menu-toggle"> <i class="fa fa-align-justify menu-icon"></i>
			</a>
		</div>
		<div class="navbar-collapse collapse navbar-responsive-collapse">

			<ul class="nav navbar-nav navbar-right">

				<li class="dropdown">
				<li id="resizer-icon"><a href="#"  class="navbar-brand box-menu"
				 style="margin-right: 10px;"
				onclick="toggleFullScreen()">
				<i class="fa fa-arrows-v" style="color: white;margin-left: 5px;"></i></a></li>
				<li class="dropdown-toggle whiteText" data-toggle="dropdown">Hi,
					<c:out value="${userObj.uname }"></c:out>&nbsp;&nbsp;<img src="${pageContext.request.contextPath}/images/${userObj.uimage } " id="userimage"
					class="img-circle myprofile" />
				</li>
				<ul class="dropdown-menu" role="menu">
	<!-- 				<li><a href="setting.jsp"><i class="fa fa-cog"></i>Setting</a></li> -->
					<li class="divider"></li>
					<li><a href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out"></i>Log
							out</a></li>
				</ul>
				</li>

			</ul>
		</div>
	</div>
</nav>
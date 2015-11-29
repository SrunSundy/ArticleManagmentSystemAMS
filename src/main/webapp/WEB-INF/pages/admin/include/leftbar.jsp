<div id="sidebar-wrapper">
	<ul class="sidebar-nav">
		<c:if test="${userObj == null }">
			<c:redirect url="/login"></c:redirect>
		</c:if>
		<c:choose>
			<c:when test="${userObj.utype==1 }">
			<li class="navleft"><a
				href="${pageContext.request.contextPath}/admin/viewlistarticle/"
				class="mynav-left"><i class="fa fa-globe"></i>Article Management</a></li>

			<li class="navleft"><a
				href="${pageContext.request.contextPath}/admin/listuser"
				class="mynav-left"><i class="fa fa-sitemap"></i>User Management</a></li>
			<li class="navleft"><a
				href="${pageContext.request.contextPath}/admin/category"
				class="mynav-left"><i class="fa fa-home"></i>Category Management</a></li>
			</c:when>
			<c:otherwise>
				<li class="navleft"><a
					href="${pageContext.request.contextPath}/admin/viewlistarticle/"
					class="mynav-left"><i class="fa fa-globe"></i>Article
						Management</a></li>

			</c:otherwise>
		</c:choose>


	</ul>

</div>
<script>
	$("#menu-toggle").click(function(e) {
		e.preventDefault();
		$("#wrapper").toggleClass("toggled");
	});
</script>
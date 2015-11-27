<div id="sidebar-wrapper">
         <ul class="sidebar-nav">
        
            <li class="navleft"><a href="${pageContext.request.contextPath}/admin/viewlistarticle/" class="mynav-left" ><i class="fa fa-globe"></i>Article Management</a></li>
            <li class="navleft"><a href="addcourse.jsp" class="mynav-left" ><i class="fa fa-sitemap"></i>User Management</a></li>
                <li class="navleft"><a href="dashboard.jsp" class="mynav-left"><i class="fa fa-home"></i>Category Management</a></li>
           
         </ul>
         
        </div> 
  <script>
  $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
  });
  </script>
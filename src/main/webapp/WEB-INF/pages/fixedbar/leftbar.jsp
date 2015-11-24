<div id="sidebar-wrapper">
         <ul class="sidebar-nav">
            <li class="navleft"><a href="dashboard.jsp" class="mynav-left"><i class="fa fa-home"></i>Dashboard</a></li>
            <li class="navleft"><a href="addgeneration.jsp" class="mynav-left" ><i class="fa fa-globe"></i>Generation</a></li>
            <li class="navleft"><a href="addcourse.jsp" class="mynav-left" ><i class="fa fa-sitemap"></i>Courses</a></li>
           
         </ul>
         
        </div> 
  <script>
  $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
  });
  </script>
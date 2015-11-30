<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@include file="include/header.jsp" %>

<title>Insert title here</title>

<style>
	table tr.tbheader{
		color: white;
		background: #757575;
		font-family: "Times New Roman", Georgia, Serif;
	}
	span.searchresult{
		color: #757575;
		font-style: italic;
		font-family: "Times New Roman", Georgia, Serif;
	}
	table.tbstyle tr:nth-child(odd){
	background:#EEEEEE;
}
table.tbstyle tr:nth-child(even){
	background:#FAFAFA;
}
table.tbstyle tr:first-child{
	background:#9E9E9E;
	height: 50px;
	color: white;
}
table.tbstyle tr.styleh{
	transition: all 0.2s linear;
}
table.tbstyle tr.styleh:hover{
	background:white;
}
span.dnfound{
	font-size: 20px;
	font-weight: bold;
	font-family: "Times New Roman", Georgia, Serif;
}
#btnadd{
	border-radius: 0;
	margin-bottom: 20px;
}
</style>
</head>
<body>
      	
	<%@include file="include/topmenu.jsp"%>

<div id="wrapper" style="margin-top: 54px;">
<%@include file="include/leftbar.jsp"%>
		<div style="height:20px;"  class="col-sm-12"></div>
		
		<div id="content" class="col-sm-12">
		<button class="btn btn-success" onclick="redirectLink()" id="btnadd"> <i class='fa fa-plus' ></i> Add Article</button>
			<fieldset>
				<legend><span style="font-weight:bold;font-size:20px;">ARTICLE</span><span style="font-size:14px;"> Listing</span></legend>
				
				<div class="col-sm-12">
					
					<div class="col-sm-9 ">
						<div class="row">
						<div class="row">
							<select id="rowset" style="height:32px;border:1px solid #E0E0E0;border-radius:5px;">
								<option value="10">10</option>
								<option value="20">20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>

							<span class="searchresult "  style="">Result : <span id="rowshow"></span><span id="recordresult"></span></span>

						</div>
						</div>
					</div>
					<div class="row">
					<div class="row">
					<div class="col-sm-3" >
						
						<input type="search" onkeyup="displayPage(1);getArticleRow();" id="searcharticle" class="form-control" placeholder="Searching Title" style="margin:0 0 0 15px;height:32px;border:1px solid #E0E0E0;border-radius:5px;"/>
						
					</div>
					</div>
					</div>
				</div>
				<div id="listarticleresult">
					
				</div>
				<div id="content"></div>
    	<div id="demo4_top" class="demo4_top"></div>
			</fieldset>
			
		</div>
		
	
</div>
<%@include file="include/footer.jsp" %>
 <script>
		//insertArticle();
		//deleteArticle();
		//updateArticle();
		function redirectLink(){
			location.href="${pageContext.request.contextPath}/admin/article";
		}
		var dbrow=0;
		var numofpage=0;
		var rowshow=0;
		displayPage(1);
		getArticleRow();
		function getArticleRow(){
			var title=$("#searcharticle").val();
			
			$.ajax({
				method : "GET",
				url : "${pageContext.request.contextPath}/api/article/getrow/"+title,
				
				success : function(data){
					 dbrow=data.RESPONSE_DATA;	
					
					var npage;
					
					var nps=dbrow/10;
					
					if(!(dbrow % rowshow==0)){
						npage = Math.floor(nps);
						npage+=1;		
					}else{	
						npage=nps;
					}
					numofpage=npage; 
					
				    $("#rowshow").html(dbrow+" records"); 
					loadPagination();
				}
			});
		}
		
		function loadPagination(){
			
			$('.demo4_top').bootpag({
		        total: numofpage,
		        
		        maxVisible: 5,
		        leaps: true,
		        firstLastUse: true,
		        first: '&#8592;',
		        last: '&#8594;',
		        wrapClass: 'pagination',
		        activeClass: 'active',
		        disabledClass: 'disabled',
		        nextClass: 'next',
		        prevClass: 'prev',
		        lastClass: 'last',
		        firstClass: 'first'
		    }).on("page", function(event, num){
		    	
		   		 displayPage(num);
		    }); 
		}
		function displayPage(mypage){
			var key=$("#searcharticle").val();
			if(key=="" || key==null){
				key="*";
			}
			var page=mypage;
			$.ajax({
				method : "GET",
				url : "${pageContext.request.contextPath}/api/article/"+page+"/"+key,
				data : {
					/* acontent : $("#searcharticle").val(),
					page : mypage */
					
				},
				success : function(data){
					if(data.RESPONSE_DATA.length==0){
						$("#demo4_top").html("");
						$("#listarticleresult").html(listNFtb());
						return;
					}
					$("#listarticleresult").html(listTb(data.RESPONSE_DATA)); 
				}
			});
		} 
		function updateArticle(id){
			$.ajax({
				type: "PUT",
	            url: "${pageContext.request.contextPath}/api/article/",
	            data :{
	            	articleid : id
	            },
	            success: function(data){ 
	            	alert(data.MESSAGE);
	            },
	            error: function(data){
	            	alert("Unsuccess" + data);
	            	console.log("ERROR..." + data);
	            }
			});
		}
		function deleteArticle(id){
			var con= confirm("Are you sure you want to delete?");
			if(con==0){
				return;
			}
			$.ajax({
				type: "DELETE",
	            url: "${pageContext.request.contextPath}/api/article/"+id,
	           
	            success: function(data){ 
	            	alert(data.MESSAGE);
	            	getArticleRow();
	            	displayPage(1);
	            	
	            },
	            error: function(data){
	            	alert("Unsuccess" + data);
	            	console.log("ERROR..." + data);
	            }
			});
		}
		/* function listArticle(){
			$.ajax({
				type: "GET",
	            url: "listarticle",
	            data :{
	            	articleid : 1
	            },
	            success: function(data){ 
	            	alert(data.RESPONSE_DATA);
	            	
	            },
	            error: function(data){
	            	alert("Unsuccess" + data);
	            	console.log("ERROR..." + data);
	            }
			});
		} */
		function listNFtb(){
			var tb="<table class='table tbstyle'>";
			tb+="<tr class='tbheader '>";
			tb+="<th>ID</th>";
			tb+="<th>Image</th>";
			tb+="<th>Title</th>";
			tb+="<th>PostedDate</th>";
			tb+="<th>Category</th>";
			tb+="<th>Writer</th>";
			tb+="<th>Status</th>";
			tb+="<th >Action</th></tr>";
			
			tb+="<tr><td colspan='8'><span class='dnfound' >DATA NOT FOUND</span></td></tr>";
			return tb;
		}
		function isEmpty(str) {
		    return (!str || 0 === str.length);
		}
		function listTb(data){
			
			var tb="<table class='table tbstyle'>";
			tb+="<tr class='tbheader '>";
			tb+="<th>ID</th>";
			tb+="<th>Image</th>";
			tb+="<th>Title</th>";
			tb+="<th>PostedDate</th>";
			tb+="<th>Category</th>";
			tb+="<th>Writer</th>";
			tb+="<th>Status</th>";
			tb+="<th >Action</th></tr>";
			for(var i=0;i<data.length;i++){
				tb+="<tr class='styleh' >";
				tb+="<td>"+data[i].id+"</td>";
				
					tb+="<td><img src='${pageContext.request.contextPath}/images/"+data[i].image+"' style='width:40px;height:40px;border-radius:100%;'/></td>";
				
				
				tb+="<td>"+data[i].title+"</td>";
				tb+="<td>"+data[i].postdate+"</td>";
				tb+="<td>"+data[i].category.id+"</td>";
				tb+="<td>"+data[i].user.uid+"</td>";
				if(data[i].status==0){
					tb+="<td><input onchange='updateStatus("+data[i].id+",1)' type='checkbox' /></td>";
				}else{
					tb+="<td><input onchange='updateStatus("+data[i].id+",0)' type='checkbox' checked/></td>";
				}
				
				tb+="<td align='center'><form method='POST' action='${pageContext.request.contextPath}/admin/article'>";
				tb+="<input type='hidden' value='"+data[i].id+"' name='id' /><button type='submit' class='btn btn-success' ><span class='glyphicon glyphicon-pencil'></span></button>";
				tb+="<button type='button' class='btn btn-danger' onclick='deleteArticle("+data[i].id+")'><span class='glyphicon glyphicon-trash'></span></button> </form></td>";   
				tb+="</tr>";
				
			}
			tb+="</table>";
			return tb;
			
		
		}
		function updateStatus(id){
			$.ajax({
				type: "PATCH",
	            url: "${pageContext.request.contextPath}/api/article/toggle/"+id, 
	            success: function(data){ 
	            	
	            	alert("Status has been changed");
	            },
	            error: function(data){
	            	alert("Unsuccess" + data);
	            	console.log("ERROR..." + data);
	            }
			});
		}
	/* 	function listArticles(){
			$.ajax({
				type: "GET",
	            url: "listarticles", 
	            success: function(data){ 
	            	
	            	$("#listarticleresult").html(listTb(data.RESPONSE_DATA));
	            },
	            error: function(data){
	            	alert("Unsuccess" + data.MESSAGE);
	            	console.log("ERROR..." + data);
	            }
			});
		} */
		
	</script>
</body>
</html>
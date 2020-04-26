<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style type="text/css">
.nav-ul li{	
	list-style : url("<%=path %>/images/arrow-right.png");
	font-size:1.2em;
	font-family:'黑体';
	margin-top:3px;	
	margin-bottom:4px;
}
.nav-ul li span a { 	
	border-style:none;
	text-decoration: none; 
	color: #996633; 	
}
.nav-ul li:hover{ 
	color:#336699;
	background:#d0d0d0;
	font-size:130%;
}	
</style>
     <%if(session==null){
    	 response.sendRedirect("/index.jsp");
     }
     	%>
<div class="easyui-accordion" id="navbar" data-options="fit:true" style="width:190px">
	<div title="功能导航" style="padding:5px;">
		<ul class="nav-ul">
			<li><span><a href="<%=path %>/funcNavi.jsp">总体流程</a> </span></li>			
		</ul>
	</div>
	<div title="族谱制作" style="padding:5px;">
		<ul class="nav-ul">
		        <li><span><a href="<%=path %>/creatNewPedigree.jsp">新建族谱</a></span></li>
		        <li><span><a href="<%=path %>/MangeGenealogy.jsp">族谱管理</a></span></li>
	<!-- 	    <li><span><a href="<%=path %>/user/teamman.jsp">团队管理</a></span></li>  -->
	<!--        <li><span><a href="<%=path %>/designthetask.jsp">录入任务分配</a></span></li>  -->
	            <li><span><a href="<%=path %>/docEditor.jsp">文档录入</a> </span></li>   
				<li><span><a href="<%=path %>/input/individual/individualInput.jsp">世系数据录入</a> </span></li>
	<!--    	<li><span><a href="<%=path %>/detailSearch.jsp">搜索修改</a></span></li>  -->
		</ul>
	</div>
	<!--  <div title="族谱发布" style="padding:5px;">
		<ul class="nav-ul">
			<li><span><a href="<%=path %>/checkManger.jsp">校对修改</a> </span></li>
		</ul>
	</div>  -->
	<!--  <div title="数据管理" style="padding:5px;">
		<ul class="nav-ul">
		<li><span><a href="<%=path %>/DTManager.jsp">文档模板管理</a> </span></li>
			<li><span><a href="<%=path %>/dataman/photoman_input.jsp">照片管理</a> </span></li>
					<li><span><a href="<%=path %>/dataman/hideman_input.jsp">隐藏管理</a> </span></li>
					<li><span><a href="<%=path %>/genwordManager.jsp">排辈字管理</a></span></li>
		</ul>
	</div>  -->
	<div title="系统管理" style="padding:5px;">
		<ul class="nav-ul">
		            <li><span><a href="<%=path %>/user/changeinfo.jsp">用户信息修改</a></span></li>
<%-- 					<li><span><a href="<%=path %>/user/pwd.jsp">修改密码</a></span></li> --%>
					<li><span><a href="<%=path %>/index.jsp">退出</a></span></li>
		</ul>
	</div>
</div>
       
       
       
       
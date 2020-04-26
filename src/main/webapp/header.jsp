<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
.bp-top{width:100%;height:50px;
background:#246699; 
font-family:'宋体';color:#ffffff; }
.bp-top .top-left{float:left;height:50px;line-height:50px;font-family:'宋体 ' ;font-weight:bold;
font-size:2em;padding-left:18px;}

.bp-top .top-right{float:right;height:50px;}
.bp-top .top-right ul{float:left;overflow:hidden;list-style:none;font-size:1.1em;}
.bp-top .top-right ul li{float:left;}
.bp-top .top-right ul li a{color:#eeeeee;}
.bp-top .top-right ul li a:hover{text-decoration:underline;color:#660066;}
.bp-top .top-right .welcome li{margin-right:20px;height:25px;line-height:25px;}
</style>
<div class="bp-top">
<%if(session==null)
	response.sendRedirect("/index.jsp");
%>
<div class="top-left" id="pedititle">
	谱志寻根数字化系统</div>
<div class="top-right">
	<ul class="welcome">
		<%--<li><jsp:include page="./changeThemes.jsp"></jsp:include></li>
		--%>
<%-- 		<li>用户角色：<%=session.getAttribute("userrole")%></li>		 --%>
		<li><img src='<%=path %>/images/man.png' />用户名：<a href='<%=path %>/user/changeinfo.jsp'><%=session.getAttribute("usercode")%></a></li>
		<li><a href="<%=path %>/index.jsp">退出系统</a></li>		
	</ul>
</div>
</div>
<script>
<%
%>
	$("#pedititle").html("族谱寻根数字化系统");
<%%>
</script>
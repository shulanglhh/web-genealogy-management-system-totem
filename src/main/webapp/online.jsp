<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="pragma" content="no-cache" />
    <title>功能导航</title>
    
  <jsp:include page="inc.jsp"></jsp:include>
  
  </head>
   <body class="easyui-layout" data-options="fit:true" style="width:1200px;height:800px;" >
    <div data-options="region:'north'" style="height:50px;overflow:hidden;">
		<div align=right>
		<span>
			<jsp:include page="./header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'功能导航'"
		style="width:200px">
		
		<jsp:include page="./newnav.jsp"></jsp:include>
		
	</div>
	<div data-options="region:'center',overflow:'hidden',iconCls:'icon-ok'"></div>
  </body>
</html>

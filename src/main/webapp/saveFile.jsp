<%@ page language="java" import="java.util.*, com.zhuozhengsoft.pageoffice.*, java.awt.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

FileSaver fs=new FileSaver(request,response);
//fs.saveToFile(request.getSession().getServletContext().getRealPath("SavaReturnValue/doc")+"/"+fs.getFileName());

/* fs.getFileName will return file name with single quotation marks */
String fileName = request.getParameter("filename");
String str=this.getClass().getClassLoader().getResource("/").toURI().getPath()+ "/../../document/"+fileName;
fs.saveToFile(str);
fs.setCustomSaveResult("ok");
fs.close();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  </body>
</html>

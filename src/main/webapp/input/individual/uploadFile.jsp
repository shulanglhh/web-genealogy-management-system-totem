<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>File Upload</title>
</head>
<body>

   <form action="<%=path %>/fUploadAction!uploadFile.action" method="post" enctype="multipart/form-data">
      <label for="myFile">Upload your file</label>
      <input type="file" name="myFile" />
      <input type="submit" value="Upload"/>
   </form>
</body>
</html>

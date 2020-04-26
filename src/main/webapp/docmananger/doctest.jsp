<%@ page language="java"
	import="java.util.*,com.zhuozhengsoft.pageoffice.*;"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
//设置服务器页面
poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
//添加自定义按钮
poCtrl.addCustomToolButton("保存","Save",1);
poCtrl.addCustomToolButton("插入图片", "insertimg()", 5);
poCtrl.addCustomToolButton("插入文档", "insertdoc()", 3);
//设置保存页面
poCtrl.setSaveFilePage("SaveFile.jsp?id=1");
//打开Word文档
poCtrl.webOpen("doc/test.doc",OpenModeType.docNormalEdit,"张佚名");
poCtrl.setTagId("PageOfficeCtrl1");//此行必需
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>最简单的打开保存Word文件</title>
<script type="text/javascript" src="../jslib/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
</head>
<body>
    <script type="text/javascript">
        function Save() {
            document.getElementById("PageOfficeCtrl1").WebSave();
        }
        function insertimg(){
        	document.getElementById("PageOfficeCtrl1").InsertInlineWebImage("doc/1.jpg");
        }
        function insertdoc(){
        	document.getElementById("PageOfficeCtrl1").InsertDocumentFromURL("doc/2.docx"); 
        }
    </script>
    <form id="form1" >
    <div style=" width:auto; height:700px;">
        <po:PageOfficeCtrl id="PageOfficeCtrl1">
        </po:PageOfficeCtrl>
    </div>
    </form>
</body>
</html>
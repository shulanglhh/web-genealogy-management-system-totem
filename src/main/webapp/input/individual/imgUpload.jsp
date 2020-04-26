<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>jQuery File Upload Example</title>
<script type="text/javascript" src="<%=path %>/jslib/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=path %>/jslib/jquery.fileupload/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=path %>/jslib/jquery.fileupload/jquery.iframe-transport.js"></script>
<script type="text/javascript" src="<%=path %>/jslib/jquery.fileupload/jquery.fileupload.js"></script>
</head>
<body>
<form method="POST" action="<%=path %>/fUploadAction!uploadFile.action" enctype="multipart/form-data" >
<input id="fileupload" type="file" name="myfile" multiple/>
<input type="hidden" name="treeid" value="183"/>
<input type="submit" value="Upload" name="upload" id="upload" />
</form>
  
<div id="progress">
    <div class="bar"  style="width: 0%;height: 18px;  background: green;"></div>
</div>

<script><%--
$(function () {
    $('#fileupload').fileupload({
        dataType: 'json',
        type:'POST',
        url:'${pageContext.request.contextPath}/fUploadAction!uploadFile.action',
        //maxNumberOfFiles : 1,
        add: function (e, data) {
            data.context = $('<button/>').text('Upload')
                .appendTo(document.body)
                .click(function () {
                    data.context = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                });
        },
        done: function (e, data) {
            data.context.text('Upload finished.');
        },
        fail:function(e, data){
        	alert("failed!!!");
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        }
    });
});
--%>
$('#fileupload').fileupload();
</script>
</body> 
</html>
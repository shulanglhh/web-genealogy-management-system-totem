<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>修改密码</title>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	   $('#navbar').accordion('select', '系统管理');});
</script>
  </head>
 
   <body class="easyui-layout" data-options="fit:true">
     <div data-options="region:'north'" style="height:50px;overflow:hidden;">
		<div align=right>
		<span>
			<jsp:include page="../header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'菜单',split:true"
		style="width:200px">
		<jsp:include page="../newnav.jsp"></jsp:include>

	</div>
    <div data-options="region:'center'" style="padding:5px;background:#eee;">
      <div id='dlg' style="width:500px">
    	<form method="post" id="infolist">
			<table>
				<tr><td style='font-size:12px'>旧密码</td><td><input type="password" id="oldpwd" name="oldpwd" /></td></tr>
				<tr><td style='font-size:12px'>新密码</td><td><input type="password" id="pwd1" name="pwd1" /></td></tr>
				<tr><td style='font-size:12px'>再输一次</td><td><input type="password" id="pwd2" name="pwd2" /></td></tr>
			</table>  
    	</form>
    	</div>
    	</div>
 <script  type="text/javascript">
  $(function() {
	var userid="<%=session.getAttribute("userid")%>";
       document.getElementById("oldpwd").focus();
       
       $("#dlg").dialog({
    	   title: '密码修改',
    	   closed: false,
    	   modal: false,
    	   buttons: [{
					text:'修改',
	  				iconCls:'icon-help',
	  				handler:function(){
	  				if($('#oldpwd').val()==''){
	   			     alert('请输入旧密码');
	   			     return false;
	   			     }
	   		        if($('#pwd1').val()==''){
	   			     alert('请输入新密码');
	   			     return false;
	   			     }
	   		        if($('#pwd2').val()==''){
	   		    	alert('请再次输入新密码');
	   			    return false;
	   			    }
	   		     if($('#pwd1').val()!=$('#pwd2').val())
	   		    {
	   			alert('两次密码必须一样');
	   			return false;
	   		    }
	  				$.post('${pageContext.request.contextPath}/userAction!alterpwd.action',
	  						{'pwd1':$("#pwd1").val(),'oldpwd':$('#oldpwd').val()},
	  				function(data){
	  					 var obj = eval('(' + data + ')');
	  	   			   if(obj.success){
	  	               alert("修改成功");
	  	               $('#infolist')[0].reset();
	  	   			   }
	  	   			   else
	  	   				alert("旧密码错误");
	  				});
	   		     
	  			}},{
	  				text:'重置',
	  				iconCls:'icon-edit',
	  				handler:function(){
	  					$('#infolist')[0].reset();
	  				}
	  				}]
    	   });
       
});
	</script>
  </body>
</html>

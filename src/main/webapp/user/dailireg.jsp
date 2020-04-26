<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>代理商注册</title>
<jsp:include page="../inc.jsp"></jsp:include>
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
	</div>
<div data-options="region:'center',iconCls:'icon-ok'">
		      <div id="dlg" class="easyui-dialog" title="代理商注册" data-options="closed:false,closable:false,modal:true, buttons:[{
  					text:'注册',
  				iconCls:'icon-help',
  				handler:function(){
  				$('#newuser').submit();
  				}
  			},{
  				text:'重置',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#newuser')[0].reset();
  				}
  				}]">
          <form method="post" id='newuser'>
			<table>
				<tr><th width='70px' style='font-size:12px'>用户名</th><td><input type="text" id="username" name="username" class="easyui-validatebox" data-options="required:true" /></td></tr>
				<tr><th width='70px' style='font-size:12px'>真实姓名</th><td><input type="text" id="realname" name="realname" class="easyui-validatebox" data-options="required:true" /></td></tr>
				<tr><td colspan="2" style='font-size:12px,color:#333'><input type="hidden" name="role" value="代理商" /> <a href="../index.jsp" style='font-size:12px'>返回登录页面</a></td></tr>
			</table>    	
    	</form>
       </div>
</div>
       <script>
       $(document).ready(function(){
       $("#newuser").form( {
      		url:'${pageContext.request.contextPath}/userAction!insertdaili.action',
      		onSubmit: function(){
      		if($("#realname").val()=="")
      			return false;
      		else if($("#username").val()=="")
      			return false;
      		},
      		 success: function(data){
      			var rObj = eval('(' + data + ')');
      			if(rObj.success==false)
      				alert("用户名不唯一！");
                else {
                alert("注册成功，请等待管理员审核");
                }
      		}
      		});
       });
       </script>
  </body>
</html>

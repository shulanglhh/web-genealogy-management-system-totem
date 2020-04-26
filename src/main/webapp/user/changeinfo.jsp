<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

	<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>修改个人信息</title>
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
		<jsp:include page="../newnav.jsp"></jsp:include>
	</div>
    <div data-options="region:'center'" style="background:#eee;">
      <div class="easyui-dialog" title="个人信息修改" style="width:230px" data-options="closed:false,buttons:[{
  					text:'提交',
  				iconCls:'icon-help',
  				handler:function(){
  				$('#infolist').submit();
  				}
  			},{
  				text:'重置',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#infolist')[0].reset();
  				}
  				}]">
    	<form method="post" id='infolist'>
			<table>
				<tr><td style='font-size:12px'>性别</td><td><select id="sex" name="sex"><option value="男">男</option><option value="女">女</option></select></td></tr>
				<tr><td style='font-size:12px'>手机号</td><td><input type="text" id="phone" name="phone" /></td></tr>
				<tr><td style='font-size:12px'>QQ</td><td><input type="text" id="qq" name="qq" /></td></tr>
				<tr><td style='font-size:12px'>家庭地址</td><td><input type="text" id="addr" name="addr" /></td></tr>
				<tr><td style='font-size:12px'>邮箱</td><td><input type="text" id="email" name="email" class="easyui-validatebox" data-options="required:true,validType:'email'" /></td></tr>
                <tr><td style='font-size:12px'>密码</td><td><input type="text" id="password" name="password" class="easyui-validatebox" data-options="required:true" /></td></tr>
			</table>    	
    	</form>
    	</div>
    	</div>
   <script type="text/javascript">
   var userid="<%=session.getAttribute("userid")%>";
   $(function() {
	   $('#navbar').accordion('select', '系统管理');
   	$.ajax({  
       async :false,  
       cache:false,  
       type: 'post', 
       data:"userid="+userid,
        url:'${pageContext.request.contextPath}/userAction!showmyinfo.action',//请求的action路径  
       error: function () {//请求失败处理函数  
           alert('获取当前用户信息失败');  
       },  
     success:function(j){ //请求成功后处理函数。  
    	var rObj = eval('(' + j + ')');
       	if (rObj.success) {
       		
       		$("#phone").val(rObj.obj.tel);
       		$("#qq").val(rObj.obj.qq);
       		$("#addr").val(rObj.obj.address);
       		$("#email").val(rObj.obj.email);
        	$("#password").val(rObj.obj.password);
       		if(rObj.obj.sex==null||rObj.obj.sex.trim()=="男"){
       			$("#sex").children().eq(1).removeAttr("selected");
       			$("#sex").children().eq(0).attr("selected",true);
       		}
       		else{
       			$("#sex").children().eq(0).removeAttr("selected");
       			$("#sex").children().eq(1).attr("selected",true);
       		}
		}
       	else{alert(rObj.msg);}
       }  
   });
   	
   	$("#infolist").form( {
   		url:'${pageContext.request.contextPath}/userAction!altermyinfo.action',
   		onSubmit: function(){
   		if($("#password").val()=="")
   			return false;
   		},
   		 success: function(data){
               alert("修改成功");
   		}
   		});
   	
   	
   	
   });
   
   </script>
  </body>
</html>

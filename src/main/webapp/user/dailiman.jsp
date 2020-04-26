<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>谱志管理员管理</title>
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	   $('#navbar').accordion('select', '系统管理');});
</script>
  </head>
  <body class="easyui-layout" data-options="fit:true" style="font-size:12px">
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
    <div data-options="region:'center',title:'代理商管理'" style="padding:5px;background:#eee;">
    	<table id="cc" class="easyui-datagrid" data-options="url:'<%=path %>/userAction!showdaili.action',method:'post',border:false,singleSelect:true,toolbar:toolbar,pagination:true">
                <thead>
                    <tr>
                        <th data-options="field:'username'" width="60">用户名</th>
                        <th data-options="field:'realname'" width="100">真实姓名</th>
                        <th data-options="field:'checked',formatter:tool" width="60">是否审核</th>
                        <th data-options="field:'creatorealname'" width="100">创建者</th>
                        <th data-options="field:'sex'" width="30">性别</th>
                        <th data-options="field:'tel'" width="80">手机号</th>
                        <th data-options="field:'qq'" width="100">QQ</th>
                        <th data-options="field:'address'" width="80">家庭地址</th>
                        <th data-options="field:'email'" width="120">邮箱</th>
                    </tr>
                </thead>
            </table>
       <div id="dlg" class="easyui-dialog" title="添加代理商" data-options="closed:true,buttons:[{
  					text:'提交',
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
  				}]" style="width:300px;height:300px;padding:10px">
         
          <form method="post" id='newuser'>
			<table>
				<tr><td style='font-size:12px'>用户名</td><td><input type="text" id="username" name="username" class="easyui-validatebox" data-options="required:true" /></td></tr>
				<tr><td style='font-size:12px'>真实姓名</td><td><input type="text" id="realname" name="realname" class="easyui-validatebox" data-options="required:true" /><input type="hidden" name="role" value="代理商" /></td></tr>
				<tr><td style='font-size:12px'>性别</td><td><select id="sex" name="sex"><option value="男">男</option><option value="女">女</option></select></td></tr>
				<tr><td style='font-size:12px'>手机号</td><td><input type="text" id="phone" name="phone" /></td></tr>
			    <tr><td style='font-size:12px'>QQ</td><td><input type="text" id="qq" name="qq" /></td></tr>
			    <tr><td style='font-size:12px'>家庭住址</td><td><input type="text" id="address" name="address" /></td></tr>
			    <tr><td style='font-size:12px'>邮箱</td><td><input type="text" id="email" name="email" /></td></tr>
			</table>    	
    	</form>
    	</div>
    	
    	<div id="dlg2" class="easyui-dialog" title="修改用户" data-options="closed:true,buttons:[{
  					text:'提交',
  				iconCls:'icon-help',
  				handler:function(){
  				$('#alteruser').submit();
  				}
  			},{
  				text:'重置',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#alteruser')[0].reset();
  				}
  				}]" style="width:300px;height:300px;padding:10px">
          <form method="post" id='alteruser'>
			<table>
				<tr><td style='font-size:12px'>真实姓名</td><td><input type="text" id="realname2" name="realname" class="easyui-validatebox" data-options="required:true" />
				<input type="hidden" name="uid" id="uid" />
				<input type="hidden" name="role" value="代理商" />
				</td></tr>
				<tr><td style='font-size:12px'>性别</td><td><select id="sex2" name="sex"><option value="男">男</option><option value="女">女</option></select></td></tr>
				<tr><td style='font-size:12px'>手机号</td><td><input type="text" id="phone2" name="phone" /></td></tr>
			    <tr><td style='font-size:12px'>QQ</td><td><input type="text" id="qq2" name="qq" /></td></tr>
			    <tr><td style='font-size:12px'>家庭住址</td><td><input type="text" id="address2" name="address" /></td></tr>
			    <tr><td style='font-size:12px'>邮箱</td><td><input type="text" id="email2" name="email" /></td></tr>
			</table>    	
    	</form>
    	</div>
    	
       </div>
    <script type="text/javascript">
    function tool(value,row,index){
        if (value){
        	return '是';
        } else {
    	   return '否';
        }
      }
    
        var toolbar = [{
            text:'添加代理商',
            iconCls:'icon-add',
            handler:function(){
            	$("#dlg").dialog('open');
            	$('#newuser')[0].reset();
            }
        },{
        	text:'修改代理商',
            iconCls:'icon-edit',
            handler:function(){
            	var obj=$("#cc").datagrid("getSelected");
            	if(obj==null)
            	{
            		alert("必须选中一行记录");
            		return;
            	}else if(obj.preset)
            	{alert("不得修改预置用户");
           	     return;
             	}
            	$('#alteruser')[0].reset();
            	$("#dlg2").dialog('open');
            	$("#username2").val(obj.username);
            	$("#realname2").val(obj.realname);
            	$("#uid").val(obj.uid);
            	$("#sex2").val(obj.sex);
            	$("#phone2").val(obj.tel);
            	$("#qq2").val(obj.qq);
            	$("#address2").val(obj.address);
            	$("#email2").val(obj.email);
            	if(obj.sex==null||obj.sex.trim()=="男"){
           			$("#sex2").children().eq(1).removeAttr("selected");
           			$("#sex2").children().eq(0).attr("selected",true);
           		}
           		else{
           			$("#sex").children().eq(0).removeAttr("selected");
           			$("#sex").children().eq(1).attr("selected",true);
           		}
            }
        },{
        	text:'审核代理商',
            iconCls:'icon-search',
            handler:function(){
            	var obj=$("#cc").datagrid("getSelected");
            	if(obj==null)
            	alert("请先选中一名代理商");
            	else if(obj.checked)
            	{
            	 alert("该代理商已审核");
            	 return;
            	}
            	$.post("${pageContext.request.contextPath}/userAction!checkdaili.action",'uid='+obj.uid,function(data){
            		var j = eval('(' + data + ')');
            		if(j.msg=='ok')
            		{
            		 alert("审核成功");
            		 location.reload();
            		}
            	});
            }
        },{
            text:'删除代理商',
            iconCls:'icon-remove',
            handler:function(){
            	if(!confirm("删除代理商之后需要选择新的代理商去管理原代理商管辖内的谱志管理员，您确认要删除该代理商吗？"))
            	return;
            	var obj=$("#cc").datagrid("getSelected");
            	if(obj==null)
            	{alert("必须选中一行记录");return;}
            	else 
            	if(obj.preset)
            	{alert("不得删除预置用户");
            	 return;
            	}
            	$.ajax({
    				type:'POST',
    				url: '${pageContext.request.contextPath}/userAction!getotherdaili.action',
    				async:false,
    				dataType:'json',//必须
    				data:'uid='+obj.uid,
    				error:function(r){
    				},
    				success:function(r){
    					if(r!=null&&r.length>0){
    						$('#choosenewdialog').dialog('open');
    	                	$('#chooseadaili').combobox('loadData', r);
    	                	
    					}
    					else{
    						alert("当前只剩一个代理商，无法删除，您必须新建一个代理商去管理待删除代理商下的族谱管理员！");
    	            		return;
    					}
    						}
            	});
            }
        }];
        
        $(function() {
        	$("#chooseadaili").combobox({
        		//required: true,
    			//url : '${pageContext.request.contextPath}/userAction!showthegname.action',
    			valueField : 'username',
    			textField : 'username',
    			missingMessage:'请先选择新的代理商'
        	});
        	$("#choosenewdaili").form({
        		url:"${pageContext.request.contextPath}/userAction!updateusercreator.action",
        		onSubmit: function(){
        			var obj=$("#cc").datagrid("getSelected");
        			var newuidzwj = $('#chooseadaili').combobox('getText');
        			if(obj==undefined||newuidzwj==''){
        				return false;
        			}
        			$("#oldnamezwj").val(obj.username);
        			$("#newnamezwj").val(newuidzwj);
               		},
               		 success: function(data){
               			//$("#dlg").dialog('close');
               			var rObj = eval('(' + data + ')');
               			if(rObj.success==false)
               			{alert("删除代理商失败，请重试！");
           				}
                         else {
                        	 $("#choosenewdialog").dialog("close");
                        	 $("#cc").datagrid("reload");
                         $.messager.show({
  							title:'提示',
  							msg:'删除代理商成功！'
  						});
                         }
               		}
        	})
        	$("#newuser").form( {
           		url:'${pageContext.request.contextPath}/userAction!insertuser.action',
           		onSubmit: function(){
           		if($("#realname").val()=="")
           			return false;
           		else if($("#username").val()=="")
           			return false;
           		},
           		 success: function(data){
           			//$("#dlg").dialog('close');
           			var rObj = eval('(' + data + ')');
           			if(rObj.success==false)
           			{alert("该用户名已存在，请重设");
       				$("#username").focus();
       				}
                     else {
                     alert("添加成功");
                     location.reload();
                     }
           		}
           		});
        	
        	$("#alteruser").form( {
           		url:'${pageContext.request.contextPath}/userAction!updateuser.action',
           		onSubmit: function(){
               		if($("#realname2").val()=="")
               			return false;
               		else if($("#username2").val()=="")
               			return false;
               		},
           		 success: function(data){
           			$("#dlg2").dialog('close');
           			var rObj = eval('(' + data + ')');
           			if(rObj.success==true){
                     alert("修改成功");
                     location.reload();
           		 }
           		}
           		});
        	
        });
    </script>
      	<div id="choosenewdialog" class="easyui-dialog" title="选择新的代理商去管理原代理商名下的谱志管理员" data-options="closed:true,buttons:[{
  					text:'提交',
  				iconCls:'icon-help',
  				handler:function(){
  				$('#choosenewdaili').submit();
  				}
  			},{
  				text:'重置',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#choosenewdaili')[0].reset();
  				}
  				}]" style="width:300px;height:120px;padding:10px">
          <form method="post" id='choosenewdaili'>
			<label for="chooseadaili">选择新的代理商：</label>
			<select id="chooseadaili" name="chooseadaili" style="width:150px;"></select>
			<input id="oldnamezwj" name="oldnamezwj" type="hidden">
			<input id="newnamezwj" name="newnamezwj" type="hidden">
    	</form>
    	</div>
  </body>
</html>

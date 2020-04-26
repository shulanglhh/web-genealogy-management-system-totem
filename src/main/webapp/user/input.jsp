<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>录入员管理</title>
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
    <div data-options="region:'center',title:'录入员管理'" style="padding:5px;background:#eee;">
    	<table id="cc" class="easyui-datagrid" data-options=" url:'<%=path %>/userAction!showinput.action',method:'post',border:false,singleSelect:true,pagination:true,toolbar:toolbar">
                <thead>
                    <tr>
                        <th data-options="field:'username'" width="60">用户名</th>
                        <th data-options="field:'realname'" width="100">真实姓名</th>
                        <th data-options="field:'creatorealname'" width="100">创建者</th>
                        <th data-options="field:'sex'" width="30">性别</th>
                        <th data-options="field:'tel'" width="80">手机号</th>
                        <th data-options="field:'qq'" width="100">QQ</th>
                        <th data-options="field:'address'" width="80">家庭地址</th>
                        <th data-options="field:'email'" width="120">邮箱</th>
                    </tr>
                </thead>
            </table>
       <div id="dlg" class="easyui-dialog" title="添加录入员" data-options="closed:true,buttons:[{
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
				<tr><td style='font-size:12px'>真实姓名</td><td><input type="text" id="realname" name="realname" class="easyui-validatebox" data-options="required:true" />
				 <input type="hidden" name="role" value="谱志录入员" />
				</td></tr>
				<tr><td style='font-size:12px'>性别</td><td><select id="sex" name="sex"><option value="男">男</option><option value="女">女</option></select></td></tr>
				<tr><td style='font-size:12px'>手机号</td><td><input type="text" id="phone" name="phone" /></td></tr>
			    <tr><td style='font-size:12px'>QQ</td><td><input type="text" id="qq" name="qq" /></td></tr>
			    <tr><td style='font-size:12px'>家庭住址</td><td><input type="text" id="address" name="address" /></td></tr>
			    <tr><td style='font-size:12px'>邮箱</td><td><input type="text" id="email" name="email" /></td></tr>
			</table>    	
    	</form>
    	</div>
    	
    	<div id="dlg2" class="easyui-dialog" title="修改谱志录入员" data-options="closed:true,buttons:[{
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
				<input type="hidden" name="role" value="谱志录入员" />
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
    var usernamezwj=0;
    var tids=0;
    var editIndex=undefined;
    function tool(value,row,index){
        if (value){
        	return '是';
        } else {
    	   return '否';
        }
      }
        var toolbar = [{
            text:'添加谱志录入员',
            iconCls:'icon-add',
            handler:function(){
            	$("#dlg").dialog('open');
            	$('#newuser')[0].reset();
            }
        },{
        	text:'修改谱志录入员',
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
            text:'删除谱志录入员',
            iconCls:'icon-remove',
            handler:function(){
            	if(!confirm("删除录入员之后需要选择新的录入员去完成原录入员的人物，您确认要删除该录入员吗？"))
            	return;
            	var obj=$("#cc").datagrid("getSelected");
            	if(obj==null)
            	{alert("必须选中一行记录");return;}
            	else 
            	if(obj.preset)
            	{alert("不得删除预置用户");
            	 return;
            	}
            	usernamezwj=obj.username;
            	$.ajax({
    				type:'POST',
    				url: '${pageContext.request.contextPath}/userAction!showthedatagridpg.action?',
    				async:false,
    				dataType:'json',//必须
    				data:'username='+usernamezwj,
    				error:function(r){
    				},
    				success:function(r){
    					if(r.total!=0){
    						$("#choosenewluru_datagrid").datagrid("loadData",r.rows);
    						$("#choosenewdialog").dialog("open");
    						editIndex=undefined;
    					}
    					else{
    						$.ajax({
    		    				type:'POST',
    		    				url: '${pageContext.request.contextPath}/userAction!deltheinput.action',
    		    				async:false,
    		    				dataType:'json',//必须
    		    				data:'uid='+obj.uid,
    		    				error:function(r){
    		    				},
    		    				success:function(r){
    		    					if(r.success){
    		    						$.messager.show({
    		      							title:'提示',
    		      							msg:'删除录入员成功！'
    		      						});
    		    						$("#cc").datagrid("reload");
    		    					}
    		    					else{
    		    						alert("删除录入员失败，请重试！");
    		    					}
    		    						}
    		            	});
    					}
    						}
            	});
            	
            	//$("#choosenewluru_datagrid").datagrid("reload",{username:usernamezwj});
            	//var datagridzwj=$("#choosenewluru_datagrid").datagrid('getData');
            	//if(datagridzwj.rows.length>0){
            		//$("#choosenewdialog").dialog("open");
            	//}
            }
        }];
        
        $(function() {
        	$('#choosenewluru_datagrid').datagrid({
    			//fit : true,
    			url:'${pageContext.request.contextPath}/userAction!showthedatagridpg.action?',
    			fitColumns : true,
    			border : false,
    			pagination : true,
    			idField : 'id',
    			loadMsg : '载入中......',
    			pageSize : 10,
    			pageList : [ 10, 20, 30, 40, 50 ],
    			rownumbers : true,
    			singleSelect : true,
    			toolbar : '#tb',
    			onClickRow: onClickRow,
    			checkOnSelect : false,
    			selectOnCheck : false,
    			columns : [ [{
    				field : 'gname',
    				title : '族谱名称',
    				width : 150
    			},{
    				field : 'teamname',
    				title : '团队名称',
    				width : 150
    			},{
    				field : 'username',
    				title : '用户名',
    				width : 150,
    				 formatter:function(value,row){
    					 return row.username;
    					 },
    			 editor:{
    				 type:'combobox',
    				 options:{
    				 valueField:'text',
    				 textField:'text',
    				 required:true,
    				 missingMessage : "请选择用户"
    				 }
    			 }
    			},{
    				field : 'teamid',
    				title : '组id',
    				width : 150,
    				hidden:true
    			},{
    				field : 'gid',
    				title : '族谱id',
    				width : 150,
    				hidden:true
    			}
    			] ]
    		});
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
                    	 $("#dlg").dialog('close');
                    	 $.messager.show({
   							title:'提示',
   							msg:'增加新的录入员成功！'
   						});
                     $("#cc").datagrid("reload");
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
           			 $.messager.show({
							title:'提示',
							msg:'修改录入员信息成功！'
						});
                  $("#cc").datagrid("reload");
                     }
           		}
           		});
        	
        });
     	function onClickRow(index) {
    		if (editIndex != index) {
    			if (endEditing()) {
    				var gid=$('#choosenewluru_datagrid').datagrid('getSelected').gid;
        			var username=$("#cc").datagrid("getSelected").username;
    				$('#choosenewluru_datagrid').datagrid('selectRow', index)
    						.datagrid('beginEdit', index);
    				var ed = $('#choosenewluru_datagrid').datagrid('getEditor', {
        				index : index,
        				field : 'username'
        			});
    				$.ajax({
        				type:'POST',
        				url: '${pageContext.request.contextPath}/userAction!showtheotherluru.action',
        				async:false,
        				dataType:'json',//必须
        				data:'gid='+gid+'&username='+username,
        				error:function(r){
        				},
        				success:function(r){
        					if(r!=null&&r.length>0){
        						$(ed.target).combobox('loadData',r);
        					}
        					else{
        						alert("当前该团队没有其他的录入员，建议您先去新建一个录入员！");
        						$("#choosenewdialog").dialog("close");
        					}
        						}
                	});
    				editIndex = index;
    			} else {
    				$('#choosenewluru_datagrid').datagrid('selectRow', editIndex);
    			}
    		}
    	}
    	function endEditing() {
    		if (editIndex == undefined) {
    			return true;
    		}
    		if ($('#choosenewluru_datagrid').datagrid('validateRow', editIndex)) {
    			var ed = $('#choosenewluru_datagrid').datagrid('getEditor', {
    				index : editIndex,
    				field : 'username'
    			});
    			var username = $(ed.target).combobox('getText');
    			$('#choosenewluru_datagrid').datagrid('getRows')[editIndex]['username'] = username;
    			$('#choosenewluru_datagrid').datagrid('endEdit', editIndex);
    			editIndex = undefined;
    			return true;
    		} else {
    			return false;
    		}
    	}
    	function updatetheinput(){
    		var obj=$("#cc").datagrid("getSelected");
    		var total=$('#choosenewluru_datagrid').datagrid('getData').total;
    		var rows=$('#choosenewluru_datagrid').datagrid('getData').rows
    		for(var i=0;i<total;i++){
    			var ed = $('#choosenewluru_datagrid').datagrid('getEditor', {
    				index : editIndex,
    				field : 'username'
    			});
    			var usernametmp = $(ed.target).combobox('getText');
    			rows[i].username=usernametmp;
    			if(!$('#choosenewluru_datagrid').datagrid('validateRow', i)){
    				alert("还有未指定新的录入员的族谱！");
    				return;
    			}
    		}
    		var rowjsons = JSON.stringify(rows);
    		$.ajax({
				type:'POST',
				url: '${pageContext.request.contextPath}/userAction!updatetheinput.action',
				async:false,
				dataType:'json',//必须
				data:'rows='+rowjsons+'&uid='+obj.uid,
				error:function(r){
				},
				success:function(r){
					if(r.success){
						$("#choosenewdialog").dialog("close");
						$.messager.show({
							title:'提示',
  							msg:'删除录入员成功！'
						});
						$("#cc").datagrid("reload");
					}
					else{
						alert("删除录入员失败，请重试！");
					}
						}
        	});
    	}
    </script>
     <div id="choosenewdialog" class="easyui-dialog" title="选择新的录入员去接受原录入员的任务" data-options="closed:true,buttons:[{
  					text:'确定',
  				iconCls:'icon-help',
  				handler:function(){
  				updatetheinput();
  				}
  			},{
  				text:'取消',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#choosenewdialog').dialog('close');
  				}
  				}]" style="width:400px;height:300px;padding:10px">
          <table id="choosenewluru_datagrid"></table>
    	</div>
  </body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%String path = request.getContextPath();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>团队管理</title>
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
    <div data-options="region:'center',title:'团队管理'" style="padding:5px;background:#eee;">
    	<table id="cc" class="easyui-datagrid" data-options="method:'post',border:false,singleSelect:true,pagination:true,toolbar:toolbar">
                <thead>
                    <tr>
                        <th data-options="field:'teamname'" width="250">团队名</th>
                        <th data-options="field:'creatorrealname'" width="160">创建者</th>
                        <th data-options="field:'orgnizepedigree',fit:true">负责修缮的族谱</th>
                    </tr>
                </thead>
            </table>
           
             <div id="dlg2" class="easyui-dialog" title="编辑团队" data-options="closed:true" style="width:500px;height:300px;padding:10px">
				  <table id='editmem'>
				  </table>
    	  </div>
            
       <div id="dlg" class="easyui-dialog" title="建立新团队" data-options="closed:true" style="width:500px;height:300px;padding:10px">
          <form method="post" id='newteam'>
					<table id='insertmem'>
				    </table>
    	</form>
    	</div>
    </div>

<div id="tb" style="height:auto">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
</div>

<div id="tb2" style="height:auto">
<b>团队名</b><input type="text" id="teamname" name="teamname" class="easyui-validatebox" data-options="required:true" />
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept2()">保存</a>
</div>

 <script type="text/javascript">
    var editIndex = undefined;
    function endEditing(){   //判断编辑状态是否结束
    	if (editIndex == undefined){
    		return true;
    		}
    	if ($('#editmem').datagrid('validateRow', editIndex)){
    	$('#editmem').datagrid('endEdit', editIndex);
    	editIndex = undefined;
    	return true;
    	} else {
    	return false;
    	}
    }
    function onClick(index){
    	if (editIndex != index){
    	if (endEditing()){
    	$('#editmem').datagrid('selectRow', index).datagrid('beginEdit', index);
    	editIndex = index;
    	} else {
    	$('#editmem').datagrid('selectRow', editIndex);
    	}
    	}
    }
    
    function accept(){
    	if (endEditing()){
    	var rows = $('#editmem').datagrid('getChanges');
        	for(var i=0;i<rows.length;i++){
        		$.post('${pageContext.request.contextPath}/userAction!alterteamember.action',{"teamid":rows[i]["teamid"],"selected":rows[i]["selected"],"teamname":rows[i]["teamname"],"mname":rows[i]["mname"]});
        	}
        	 $('#editmem').datagrid('acceptChanges');
        	 $("#dlg2").dialog('close');
    	}
    	}
    
    </script>

<script type="text/javascript">
    function endEditing2(){   //判断编辑状态是否结束
    	if (editIndex == undefined){
    		return true;
    		}
    	if ($('#insertmem').datagrid('validateRow', editIndex)){
    	$('#insertmem').datagrid('endEdit', editIndex);
    	editIndex = undefined;
    	return true;
    	} else {
    	return false;
    	}
    }
    function onClick2(index){
    	if (editIndex != index){
    	if (endEditing2()){
    	$('#insertmem').datagrid('selectRow', index).datagrid('beginEdit', index);
    	editIndex = index;
    	} else {
    	$('#insertmem').datagrid('selectRow', editIndex);
    	}
    	}
    }
    
    function accept2(){
    	if (endEditing2()){
    		if($("#teamname").val()==""){
    			alert("团队名称不能为空");
    			return;
    		}
    		$.post('${pageContext.request.contextPath}/userAction!insertteam.action',{"teamname":$("#teamname").val()},function(data){
    			var j = eval('(' + data + ')');
    			if(j.msg=='团队名非法'){
    				alert("团队名重复了");
    				return;
    			}
    			var teamid=j.msg;
    			var rows = $('#insertmem').datagrid('getChanges');
            	for(var i=0;i<rows.length;i++){
            		$.post('${pageContext.request.contextPath}/userAction!insertteamember.action',{"teamid":teamid,"username":rows[i]["username"],"selected":rows[i]["selected"],"realname":rows[i]["realname"],"rolename":rows[i]["rolename"]});
            	}
            	 $('#insertmem').datagrid('acceptChanges');   
            	 $("#dlg").dialog('close');
            	 $.post('${pageContext.request.contextPath}/userAction!showteam.action',function(j){
            		 var rObj = eval('(' + j + ')');
     	        	if (rObj.success) {
     	        		$("#cc").datagrid('loadData', rObj.obj);
     					}
     	        	else{alert(rObj.msg);}
            	 });
    		});
    	
    	}
    	}
    
    </script>

    <script type="text/javascript">
    var usercode="<%=session.getAttribute("usercode")%>";
    function pagerFilter(data) {
    	if (typeof data.length == 'number' && typeof data.splice == 'function') { // is array
    		data = {
    			total : data.length,
    			rows : data
    		}
    	}
    	var dg = $(this);
    	var opts = dg.datagrid('options');
    	var pager = dg.datagrid('getPager');
    	pager.pagination({
    		onSelectPage : function(pageNum, pageSize) {
    			opts.pageNumber = pageNum;
    			opts.pageSize = pageSize;
    			pager.pagination('refresh', {
    				pageNumber : pageNum,
    				pageSize : pageSize
    			});
    			dg.datagrid('loadData', data);
    		}
    	});
    	if (!data.originalRows) {
    		data.originalRows = (data.rows);
    	}
    	var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
    	var end = start + parseInt(opts.pageSize);
    	data.rows = (data.originalRows.slice(start, end));
    	return data;
    };
        var toolbar = [{
            text:'添加新团队',
            iconCls:'icon-add',
            handler:function(){
            	$("#dlg").dialog('open');
            	$("#teamname").val("");
            	$("#insertmem").datagrid({
           		 method:'post',
           		 url:'${pageContext.request.contextPath}/userAction!accessUser.action',
           		 singleSelect:true,
    	       		 toolbar:'#tb2',
    	       		 onClickRow:onClick2,
    	       		 columns:[[
    	       		        { field: 'selected', title: '是否加入团队',editor:{type:'checkbox',options:{on:'是',off:'否'}} },
     	          	        { field: 'username', title: '成员用户名' },
     	          	        { field: 'realname', title: '真实姓名' },
     	          	        { field: 'rolename', title: '角色' }
     	          	        ]],
     	          	 title:'可选团队成员列表'
           	});
            }
        },{
        	text:'编辑团队',
        	iconCls:"icon-edit",
        	handler:function(){
        		var obj=$("#cc").datagrid("getSelected");
            	if(obj==null)
            	{
            		alert("必须选中一行记录");
            		return;
            	}else 
            	$("#dlg2").dialog('open');
            	$("#editmem").datagrid({
            		 method:'post',
            		 url:'${pageContext.request.contextPath}/userAction!showMem.action',
            		 singleSelect:true,
     	       		 toolbar:'#tb',
     	       		 onClickRow:onClick,
     	       		 columns:[[
     	       		        { field: 'selected', title: '是否在团队',editor:{type:'checkbox',options:{on:'是',off:'否'}} },
     	       		        { field: 'teamname', title: '团队名称' },
      	          	        { field: 'mname', title: '成员用户名' },
      	          	        { field: 'realname', title: '真实姓名' },
      	          	        ]],
      	          	 queryParams:{tid:obj.tid},
      	          	 title:'可选团队成员列表'
            	});
            	
            	
            	
            }
        },{
            text:'删除团队',
            iconCls:'icon-remove',
            handler:function(){
            	if(!confirm("删除团队之后需要选择新的团队去管理原团队编纂的族谱，您确认要删除该团队吗？"))
            	return;
            	var obj=$("#cc").datagrid("getSelected");
            	if(obj==null)
            	alert("必须选中一行记录");
            	else if(obj.preset)
            	{
            		alert("不得删除预置用户");
            	    return;
            	}
            	$.ajax({
    				type:'POST',
    				url: '${pageContext.request.contextPath}/userAction!getotherteam.action',
    				async:false,
    				dataType:'json',//必须
    				data:'tid='+obj.tid,
    				error:function(r){
    				},
    				success:function(r){
    					if(r!=null&&r.length>0){
    						$('#choosenewdialog').dialog('open');
    						var selectobj=$("#chooseapzgly");
    						selectobj.html("");
    						for(var i=0;i<r.length;i++){
    							selectobj.append("<option value='"+r[i].tid+"'>"+r[i].teamname+"</option>");
    						}
    					}
    					else{
    						alert("该谱志管理员旗下只剩一个团队，无法进行删除！");
    	            		return;
    					}
    						}
            	});
            }
        }];
        
        $(function() {
        	$.ajax({  
	        async :false,  
	        cache:false,  
	        type: 'post', 
             url:'${pageContext.request.contextPath}/userAction!showteam.action',//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('获取团队列表失败');  
	        },  
        success:function(j){ //请求成功后处理函数。  
        	var rObj = eval('(' + j + ')');
	        	if (rObj.success) {
	        		$('#cc').datagrid({
						loadFilter : pagerFilter
					}).datagrid('loadData', rObj.obj);
					}
	        	else{alert(rObj.msg);}
	        }  
	    });
        	$("#choosenewpzgly").form({
        		url:"${pageContext.request.contextPath}/userAction!updateteambysuper.action",
        		onSubmit: function(){
        			var obj=$("#cc").datagrid("getSelected");
        			var newuidzwj = $('#chooseapzgly').val();
        			if(obj==undefined||newuidzwj==''){
        				alert("请选择一个新的团队！");
        				return false;
        			}
        			$("#olduserid").val(obj.tid);
        			$("#newuserid").val(newuidzwj);
               		},
               		 success: function(data){
               			//$("#dlg").dialog('close');
               			var rObj = eval('(' + data + ')');
               			if(rObj.success==false)
               			{alert("删除团队失败，请重试！");
           				}
                         else {
                        	 $("#choosenewdialog").dialog("close");
                        	 $.ajax({  
                     	        async :false,  
                     	        cache:false,  
                     	        type: 'post', 
                                  url:'${pageContext.request.contextPath}/userAction!showteam.action',//请求的action路径  
                     	        error: function () {//请求失败处理函数  
                     	        },  
                             success:function(j){ //请求成功后处理函数。  
                             	var rObj = eval('(' + j + ')');
                     	        	if (rObj.success) {
                     	        		$("#cc").datagrid('loadData', rObj.obj);
                     					}
                     	        	else{alert(rObj.msg);}
                     	        }  
                     	    });
                         $.messager.show({
  							title:'提示',
  							msg:'删除团队成功！'
  						});
                         }
               		}
        	});	
        });
    </script>
    <div id="choosenewdialog" class="easyui-dialog" title="选择新的团队去管理原代理商名下的谱志管理员" data-options="closed:true,buttons:[{
  					text:'提交',
  				iconCls:'icon-help',
  				handler:function(){
  				$('#choosenewpzgly').submit();
  				}
  			},{
  				text:'重置',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#choosenewpzgly')[0].reset();
  				}
  				}]" style="width:300px;height:120px;padding:10px">
          <form method="post" id='choosenewpzgly'>
			<label for="chooseapzgly">选择新的团队：</label>
			<select id="chooseapzgly" name="chooseapzgly" style="width:130px;"></select>
			<input id="olduserid" name="olduserid" type="hidden">
			<input id="newuserid" name="newuserid" type="hidden">
    	</form>
    	</div>
  </body>
</html>

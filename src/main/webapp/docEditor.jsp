<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>文档录入</title>
<style type="text/css">
.datagrid-group-title {
    font-size:12px;
    font-weight:bold;
    margin:0;
    margin-bottom:15px;
}
</style>

<jsp:include page="inc.jsp"></jsp:include>

  <script type="text/javascript" src="<%=path %>/jslib/docOperation.js"></script>
  <script type="text/javascript" src="<%=path %>/jslib/datagrid-groupview.js"></script>
  <script type="text/javascript" src="<%=path %>/jslib/jquery-easyui-1.3.2/datagrid-detailview.js"></script>
  
  <script type="text/javascript">

  		
  		$(function(){
  			$('#navbar').accordion('select', '族谱制作');
  		});
	    
  		function onDblClickRowUD(rowIndex, rowData) {
  			var selectedRow = $("#usersdoc_datagrid").datagrid('getRows');
  			current_doc_title = selectedRow[rowIndex].docname;
		    $(this).datagrid('selectRecord', current_doc_title);  //通过获取到的id的值做参数选中一行
		    OpenDoc();
  		}
  		
  		function onRowContextMenuUD(e, rowIndex, rowData){
		    e.preventDefault();
		    var selected=$("#usersdoc_datagrid").datagrid('getRows'); //获取所有行集合对象
		     current_doc_title = selected[rowIndex].dtname;
		     current_did = selected[rowIndex].did;
		     delete_doc_descri = selected[rowIndex].dtname;
		     $(this).datagrid('selectRecord', current_did);  //通过获取到的id的值做参数选中一行
		    $('#ud_menu').menu('show', {
		        left:e.pageX,
		        top:e.pageY
		    });       
		}
  		
	    function createNewDoc() {
	    	if(document.getElementById('id_descri').value == ''){
	    		alert("请填写文件描述。");
	    	} else {
	    		$.ajax({
					async : false,
					cache : false,
					type : 'post',
					dataType:'text',
					data : 'docname='+document.getElementById('id_descri').value+'&docpedi='+$('#combo_pedi').combobox('getValue'),
					url : '${pageContext.request.contextPath}/docAction!docnameCheck.action',//请求的action路径  
					error : function() {//请求失败处理函数  
					},
					success : function(result) { //请求成功后处理函数。  
						if(result == 'notexist') {
	    					//为了保证文件名的唯一性，使用当前的时间（毫秒数）作为文件名，从而也避免用户自己命名
	    					var myDate = new Date();
	    					var fileCurrentTime = myDate.getTime(); 
							$.ajax({
					       		type:"POST",
					       		url:"docAction!createNewDoc.action",
					       		dataType:'text',
					       		data:{doc_descri:document.getElementById('id_descri').value, doc_filetime:fileCurrentTime, doc_pedi:$('#combo_pedi').combobox('getValue'), doc_contenttype:document.getElementById('contenttype_doc').value},
					       		success:function(result) {
					       					if(result != null){
							    	    		$('#dlg').dialog('close');
							    	    		
					       					} else {
					       						alert("无法创建文档记录，可能是数据库连接问题，请检查。");
					       					}
					       		},
					       		error:function(){
					       			alert("无法成功发送请求，请检查网络连接是否有效。");
					       		}
					       	});	
	    				} else if(result == 'exist') {
	    					alert("当前谱志中该描述的文档已经存在，无法新建！");
	    				}
					}
				});
	    	}
	    }
	    
	    //删除服务器端文档
	    function deleteDoc() {
	    	$.ajax({
				async : false,
				cache : false,
				type : 'post',
				dataType:'text',
				data : 'delete_did='+current_did,
				url : '${pageContext.request.contextPath}/docAction!deleteDoc.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					//alert('删除文件失败，请检查网络');
				},
				success : function() { //请求成功后处理函数。  
						alert(delete_doc_descri + '已经删除。');
					}
			});
	    }
	    
	    function OpenDoc(){
	    	$.ajax({
				async : false,
				cache : false,
				type : 'post',
				dataType:'text',
				data : 'descri='+current_doc_title,
				url : '${pageContext.request.contextPath}/docAction!findDoccont.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					//alert('删除文件失败，请检查网络');
				},
				success : function(result) { //请求成功后处理函数。
					$("#title_form").show();
					$("#title").val(current_doc_title);
					$("#doc_cont").val(result);
					}
			});
	    }
	    
	    function saveDoc(){
	    	var doc_content=document.getElementById('doccont').value;
	    	var title=document.getElementById('title').value;
	    	$.ajax({
				async : false,
				cache : false,
				type : 'post',
				dataType:'text',
				data : 'doc_cont='+doc_content+'doc_title='+title,
				url : '${pageContext.request.contextPath}/docAction!saveDoc.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					//alert('删除文件失败，请检查网络');
				},
				success : function() { //请求成功后处理函数。  
				    alert("保存成功！");
				    $("#title_form").hide();
					}
			});
	    }
	    
	    //重命名文档
	    function renameDoc() {
	    	var new_descri = document.getElementById('id_newdescri').value;
	    	if(new_descri == "") {
	    		alert("请填写新的文档描述。");
	    	} else {
	    		$.ajax({
					async : false,
					cache : false,
					type : 'post',
					dataType:'text',
					data : 'rename_newdescri='+new_descri+'&did='+current_did,
					url : '${pageContext.request.contextPath}/docAction!modifyDocDescri.action',//请求的action路径  
					error : function() {//请求失败处理函数  
						alert('重命名失败，请检查网络');
					},
					success : function(result) { //请求成功后处理函数。  
						if(result=="renamesuccessfully") {
    						alert("重命名成功。");
    						var selectedrow=$('#usersdoc_datagrid').datagrid('getSelected');
    						var index=$('#usersdoc_datagrid').datagrid('getRowIndex',selectedrow);
    						$('#usersdoc_datagrid').datagrid('updateRow',{
    							index: index,
    							row:{dcname:selectedrow.dtname,docmodifydate:selectedrow.docmodifydate,gid:selectedrow.gid}
    						});
    						//reloadTable();
    						$('#dlg2').dialog('close');
    					}
					}
				});
	    	}
	    }
	         
  </script>
  

</head>
  <body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north'" style="height:50px;overflow:hidden;">
		<div align=right>
		<span>
			<jsp:include page="./header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'功能导航',split:true"
		style="width:200px">
		<jsp:include page="newnav.jsp"></jsp:include>

	</div>
	<div data-options="region:'center'" id="centerLayout">
	<div class="easyui-layout" data-options="fit:true">
	<div id="doc_editor" data-options="region:'center',split:false" title="文档编辑工作区">
	<div class="title" id="title_form"> 
		<form name="doc_form">
		文档标题：<input id="title" name="title" type="text" readonly="readonly"></input>
		<p></p>
		文档内容：<textarea id="doccont" name="doc_cont" style="width:600px;height:80%;"></textarea>
		<p></p>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveDoc()">保存</a>
        </form>
    </div>
    </div>
    <div data-options="region:'east'" title="文档列表" style="width:300px;">
    	<div class="easyui-tabs">
    	<div title="我的文档" fit="true">
    	<div style="margin-top:5px">
    	<label for="combo_pedizwj">选择族谱：&nbsp;&nbsp;</label> 
    	<input id="combo_pedizwj" class="easyui-combobox" name="doc_pedizwj" data-options="
					url:'docAction!getPediList.action',
					valueField:'gid',
					textField:'gname',
					editable:false,
					onSelect:function(rec){
					finddocsbygid(rec.gid);
					}">
    	</div>
    	<div style="margin-top:5px;margin-bottom:5px">
		<label for="search-doc">输入文件名:</label> 
		<input id="search-doc" class="easyui-searchbox" 
		data-options="prompt:'输入文件名搜索',width:'30px',searcher:searchdoc"></input>	
		</div>
          <table id="usersdoc_datagrid" class="easyui-datagrid" style="height:700px"
              data-options="
              		singleSelect:true,
              		pagination:true,
              		pageList:[10,20,30],
              		collapsible:true,
              		method:'POST',
              		onDblClickRow:onDblClickRowUD,
              		onRowContextMenu:onRowContextMenuUD,
              		pagePosition:'top',
              		groupFormatter:function(value,rows){
              			return value + ' - ' 
              		}">
              <thead>
                  <tr>
                      <th data-options="field:'dtname',width:100">文件描述</th>
                      <th data-options="field:'docmodifydate',width:95">修改时间</th>
                      <th data-options="field:'contenttype',width:70,align:'right'">类型</th>
                  </tr>
              </thead>
          </table>
          
          <div id="ud_menu" class="easyui-menu" style="width:120px;">
		      <div onClick="OpenDoc();">打开</div>
		      <div onClick="$('#dlg2').dialog('open');$('#dlg2').panel('move',{top:150,left:$(document.body).width()-280})">重命名</div>
		      <div onClick="deleteDoc()">删除</div>
		  </div>
  
        </div>
 
        
      </div>
	    <div style="margin:10px 0;"></div>
	    <div style="margin-left:auto;margin-right:auto;padding:5px;background:#fafafa;width:276px;border:1px solid #ccc">
		  <a href="#" class="easyui-linkbutton" onClick="$('#dlg').dialog('open');$('#dlg').panel('move',{top:150,left:$(document.body).width()-280});initCombobox()">新建</a>
		</div>
      </div>
    </div>
 </div>
    	<div id="dlg" class="easyui-dialog" title="新建文档" style="width:280px;height:400px;padding:10px;"
			data-options="iconCls:'icon-add',
			closed:true,
			resizable:false,
			modal:true">
			<div style="padding:10px 60px 20px 30px">
				<form id="newdoc_form">
					文件描述:
					<p></p>
					<input id="id_descri" class="easyui-validatebox textbox" type="text" name="doc_descri" data-options="
					required:true,
					missingMessage:'此项必填。'">
					<p></p>
					所属谱志 :
					<p></p>
					<input id="combo_pedi" class="easyui-combobox" name="doc_pedi" data-options="
					url:'docAction!getPediList.action',
					valueField:'gid',
					textField:'gname',				
					editable:false">
					<p></p>
					文档内容类型 :
					<p></p>
					<input id="contenttype_doc" class="easyui-validatebox textbox" type="text" name="doc_cont" data-options="
					required:true,
					missingMessage:'此项必填。' ">
					<p></p>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="createNewDoc()">确定</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')">取消</a>
				</form>
	        </div>
        </div>
        
		
		<div id="dlg2" class="easyui-dialog" title="重命名文档" style="width:260px;height:200px;padding:10px;"
			data-options="iconCls:'icon-add',
			closed:true,
			resizable:false,
			modal:true">
		
			<div style="padding:10px 60px 20px 30px">
				<form id="newdoc_form">
					新的文件描述:
					<p></p>
					<input id="id_newdescri" class="easyui-validatebox textbox" type="text" name="doc_newdescri" data-options="
					required:true,
					missingMessage:'此项必填。'">
					<p></p>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="renameDoc()">确定</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg2').dialog('close')">取消</a>
				</form>
	        </div>
		</div>
		
	<script type="text/javascript">
		function searchdoc(value){
			var combo_pedizwj=$("#combo_pedizwj").combobox('getValue');
			if(combo_pedizwj!=null){
				$.ajax({
					async : false,
					cache : false,
					type : 'post',
					data : 'docname='+value+'&gid='+combo_pedizwj,
					url : '<%=path%>/docAction!displayUsersDocbyname.action',//请求的action路径  
					error : function() {//请求失败处理函数  
						alert('选择规则出错，请检查网络！');
					},
					success : function(j) { //请求成功后处理函数。  
						var rObj = eval('(' + j + ')');
						if (rObj!=null) {
							if(rObj!="session"){
							$.messager.show({
								title : '提示',
								msg : '搜索成功！'		
							});
							$('#usersdoc_datagrid').datagrid('loadData', rObj);
							}
							else{
								 $.messager.confirm('提示', '您的登陆信息已经失效，是否重新登录？', function (data) {  
								        if (data) { 
								        	//$('#index-login-dialog').dialog('open');
								        	window.location.href="<%=path %>/index.jsp"; 
								        }  
								        else {  
								        	
								        }  
								    });  
							}
						} else {
								$.messager.show({
									title : '提示',
									msg : '没有搜索到结果，请重新输入文件名！'		
								});
						}
					}
				});
			}
			else{
				$.ajax({
					async : false,
					cache : false,
					type : 'post',
					data : 'docname='+value,
					url : '<%=path%>/docAction!displayUsersDocbyname.action',//请求的action路径  
					error : function() {//请求失败处理函数  
						alert('选择规则出错，请检查网络！');
					},
					success : function(j) { //请求成功后处理函数。  
						var rObj = eval('(' + j + ')');
						if (rObj!=null) {
							if(rObj!="session"){
							$.messager.show({
								title : '提示',
								msg : '搜索成功！'		
							});
							$('#usersdoc_datagrid').datagrid('loadData', rObj);
							}
							else{
								 $.messager.confirm('提示', '您的登陆信息已经失效，是否重新登录？', function (data) {  
								        if (data) { 
								        	//$('#index-login-dialog').dialog('open');
								        	window.location.href="<%=path %>/index.jsp"; 
								        }  
								        else {  
								        	
								        }  
								    });  
							}
						} else {
								$.messager.show({
									title : '提示',
									msg : '没有搜索到结果，请重新输入文件名！'		
								});
						}
					}
				});
			}
		}
		
		function finddocsbygid(gid){
			$.ajax({
				async : false,
				cache : false,
				type : 'post',
				data : 'gid='+gid,
				url : '<%=path%>/docAction!finddocsbygid.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					alert('选择规则出错，请检查网络！');
				},
				success : function(j) { //请求成功后处理函数。  
					var rObj = eval('(' + j + ')');
					if (rObj!=null) {
						if(rObj!="session"){
						$('#usersdoc_datagrid').datagrid('loadData', rObj);
						}
						else{
							 $.messager.confirm('提示', '您的登陆信息已经失效，是否重新登录？', function (data) {  
							        if (data) { 
							        	window.location.href="<%=path %>/index.jsp"; 
							        }  
							        else {  
							        	
							        }  
							    });  
						}
					} else {
						
					}
				}
			});
		}
		
	</script>
		<div id="index-login-dialog" class="easyui-dialog"
		data-options="title:'登陆',closed:true,modal:true, buttons:[{
  				text:'取消',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#index_loginForm')[0].reset();
  				}
  			},{
  				text:'登陆',
  				iconCls:'icon-help',
  				handler:function(){
  				
  				$('#index_loginForm').submit();
  				}
  				}]">
		<form id="index_loginForm" method="post">
			<table>
				<tr>
					<th>登录名</th>
					<td><input name="username" class="easyui-validatebox"
						data-options="required:true,missingMessage:'登陆名称必填'" /></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input type="password" name="password"
						class="easyui-validatebox"
						data-options="required:true,missingMessage:'密码必填'" /></td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>

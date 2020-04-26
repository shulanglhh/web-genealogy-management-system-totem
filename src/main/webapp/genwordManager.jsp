<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <jsp:include page="inc.jsp"></jsp:include>
  <script type="text/javascript">
  $(function(){
	  $('#navbar').accordion('select', '数据管理');
  });
  		function displayGenwordResult() {
			$('#dg_genword').datagrid('loadData',{total:0,rows:[]});
  			$('#dg_genword').datagrid({
  				pagination : false,
  				method:'POST',
				idField : 'gen',
				loadMsg : '人物载入中......',
  				url : '${pageContext.request.contextPath}/genwordAction!getGenwordDisplayResult.action?gid=' + $('#combo_pedilist').combobox('getValue')
  			});
  		}
  		
  		function clearForm(){
  			$('input').val('');
  		}
  		
  		function doReplace(){
  			if($('#combo_pedilist').combobox('getValue') == '' || document.getElementById('input_startgen').value.trim() == '') {
  				alert('请选择需要修改排辈字的谱志和起始世代。');
  			} else {
  				if( document.getElementById('input_ggenword').value.trim() == '' && document.getElementById('input_genword').value.trim() == '') {
					alert('请至少填写一种排辈字进行替换。');  				
  				} else {
  					if(document.getElementById('input_ggenword').value.trim() != ''){
  						$.post('${pageContext.request.contextPath}/genwordAction!modifyGgenword.action',{gid:$('#combo_pedilist').combobox('getValue'), startgen:document.getElementById('input_startgen').value.trim(), ggenword:document.getElementById('input_ggenword').value.trim()},
  						function(result){
  							if(result == 'failed') {
  								alert('修改失败。');
  							} else {
  								displayGenwordResult();
  							}
  						});
  					} 
  				
  					if(document.getElementById('input_genword').value.trim() != ''){
  						$.post('${pageContext.request.contextPath}/genwordAction!modifyGenword.action',{gid:$('#combo_pedilist').combobox('getValue'), startgen:document.getElementById('input_startgen').value.trim(), genword:document.getElementById('input_genword').value.trim()},
  						function(result){
  							if(result == 'failed') {
  								alert('修改失败。');
  							} else {
  								displayGenwordResult();
  							}
  						});
  					}
  				}
  			}
  		}
  		function deletetheoldcom(){
  			var gid=$('#combo_pedilist').combobox('getValue');
  			if(gid==undefined){
  				$.messager.alert('警告', '请您先选择一个族谱','warning');
  				return;
  			}
  			$.ajax({
  				async : false,
  				cache : false,
  				type : 'post',
  				//dataType:'json',//必须
  				data : 'gid=' +gid+'&type=0',
  				url : '${pageContext.request.contextPath}/genwordAction!deletthegenword.action',//请求的action路径  
  				error : function() {//请求失败处理函数  
  					alert('删除该全国统一排辈字失败，请重试！');
  				},
  				success : function(j) { //请求成功后处理函数。  		
  					var rObj = jQuery.parseJSON(j);
  					if (rObj.success) {
  						//$('#mangeg_datagrid').datagrid('reload');
  						$.messager.show({
  			                title:'提示',
  			                msg:'删除该全国统一排辈字成功！'
  			            });
  						displayGenwordResult();
  					} 
  					else {										
  						$.messager.show({
  			                title:'提示',
  			              msg:'删除该全国统一排辈字失败！'
  			            });
  					}
  				}
  			});
  		}
  		function deletetheoldsp(){
  			var gid=$('#combo_pedilist').combobox('getValue');
  			if(gid==undefined){
  				$.messager.alert('警告', '请您先选择一个族谱','warning');
  				return;
  			}
  			$.ajax({
  				async : false,
  				cache : false,
  				type : 'post',
  				//dataType:'json',//必须
  				data : 'gid='+gid+'&type=1',
  				url : '${pageContext.request.contextPath}/genwordAction!deletthegenword.action',//请求的action路径  
  				error : function() {//请求失败处理函数  
  					alert('删除该本支老字派失败，请重试！');
  				},
  				success : function(j) { //请求成功后处理函数。  		
  					var rObj = jQuery.parseJSON(j);
  					if (rObj.success) {
  						//$('#mangeg_datagrid').datagrid('reload');
  						$.messager.show({
  			                title:'提示',
  			                msg:'删除该本支老字派成功！'
  			            });
  						displayGenwordResult();
  					} 
  					else {										
  						$.messager.show({
  			                title:'提示',
  			              msg:'删除该本支老字派失败！'
  			            });
  					}
  				}
  			});
  		}
  </script>

  <head>
    <base href="<%=basePath%>">
    
    <title>排辈字管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

  </head>
  
  <body class="easyui-layout" data-options="fit:true"">
	<div data-options="region:'north'" style="height:50px;overflow:hidden;">
		<div align=right>
		<span>
			<jsp:include page="./header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'菜单',split:true"
		style="width:200px">
		<jsp:include page="newnav.jsp"></jsp:include>
	</div>
	<div data-options="region:'center'" id="centerLayout" >
		<div id="p" class="easyui-panel" title="检索" style="height:300px;padding:10px;">
			<form id="ff" method="post">
	            <table cellpadding="5" style="padding:10px;font-size:12px">
	            	<tr>
	                    <td>选择谱志：</td>
	                    <td><input id="combo_pedilist" class="easyui-combobox" name="combo_pedi" data-options="url:'genwordAction!getPedigreeList.action',
							valueField:'pid',
							textField:'text',				
							editable:false,
							onSelect:function(param){
								document.getElementById('input_startgen').value = '';
								document.getElementById('input_ggenword').value = '';
								document.getElementById('input_genword').value = '';
								displayGenwordResult();	  
							}"></input></td>
	                </tr>
	                <tr>
	                    <td>起始世代：</td>
	                    <td><input id="input_startgen" class="easyui-validatebox" type="text" name="name" data-options="required:true"></input></td>
	                </tr>
	                <tr>
	                    <td>全国统一排辈字：</td>
	                    <td><input id="input_ggenword" class="easyui-validatebox" type="text" name="subject" data-options=""></input></td>
	                </tr>
	                <tr>
	                    <td>本支老字派：</td>
	                    <td><input id="input_genword" name="message" data-options=""></input></td>
	                </tr>
	            </table>
	        </form>
	        <div style="text-align:left;padding:10px">
			   <a href="javascript:void(0)" class="easyui-linkbutton" onclick="doReplace()">替换</a>
			   <a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">重置</a>
			   <a href="javascript:void(0)" class="easyui-linkbutton" onclick="deletetheoldcom()">删除该全国统一排辈字</a>
			   <a href="javascript:void(0)" class="easyui-linkbutton" onclick="deletetheoldsp()">删除该本支老字派</a>
			</div>
    	</div>

    	<div style="height:500px">
    	<table id="dg_genword" class="easyui-datagrid" title="排辈字信息"
            data-options="singleSelect:true,collapsible:true,method:'get'" fit="true">
	        <thead>
	            <tr>
	                <th data-options="field:'gen',width:80">世代数</th>
	                <th data-options="field:'ggenword',width:100">全国统一字派</th>
	                <th data-options="field:'genword',width:80,align:'right'">本支老字派</th>
	            </tr>
	        </thead>
    	</table>
    	</div>
	</div>
  </body>
</html>

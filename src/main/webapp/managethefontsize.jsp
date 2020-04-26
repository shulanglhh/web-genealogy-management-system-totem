<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>字体大小设置管理</title>
<jsp:include page="inc.jsp"></jsp:include>
</head>
<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north'" style="height:50px;overflow:hidden;">
		<div align=right>
			<span> <jsp:include page="header.jsp"></jsp:include> </span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'菜单',split:true"
		style="width:200px">
		<jsp:include page="newnav.jsp"></jsp:include>

	</div>
	<div data-options="region:'center',title:'字体大小设置管理'"
		style="padding:5px;background:#eee;">
		<table id="cc" class="easyui-datagrid"
			data-options=" url:'<%=path%>/userAction!showthefontrule.action',method:'post',border:false,singleSelect:true,toolbar:'#tb',pagination:true">
			<thead>
				<tr>
					<th data-options="field:'rulename'" width="200">规则名称</th>
					<th data-options="field:'gname'" width="300">所属族谱</th>
					<th data-options="field:'fontruleid',hidden:true">记录ID</th>
					<th data-options="field:'gid',hidden:true">族谱ID</th>
				</tr>
			</thead>
		</table>
		<div id="tb" style="padding:5px;height:auto">
		<div style="margin-bottom:5px" id="contrbar">
			<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
				onclick=appendrule()>新建</a> <a class="easyui-linkbutton"
				iconCls="icon-remove" plain="true" onclick=removerule()>删除</a>
			<a class="easyui-linkbutton" iconCls="icon-save" plain="true"
				onclick=editrule()>编辑</a> 
		</div>
		</div>
		<div id="dlg_style" class="easyui-dialog" title="样式设置"
			style="width:280px;height:400px;padding:10px;"
			data-options="closed:true,
			resizable:false,
			modal:true">
			<div style="padding:10px 10px 10px 10px">
				<form id="style_form" method="post">
				<input id="fontruleid" name="fontruleid" type="hidden" />	
					<table cellpadding="5">
						<tr>
					<td>规则名称:</td>
					<td><input id="rulename" name="rulename" class="easyui-validatebox" required="true" style="width:100px;"></input></td>
						</tr>
						<tr>
						<td>所属族谱:</td>
						<td>
						<select id="selectpedigree" name="selectpedigree" style="width:100px">
						</td>
						</tr>
						<tr>
							<td>标题一:</td>
							<td><select id='slct_type_title1' name='slct_type_title1' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title1' name='slct_size_title1' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题二:</td>
							<td><select id='slct_type_title2' name='slct_type_title2' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title2' name='slct_size_title2' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题三:</td>
							<td><select id='slct_type_title3' name='slct_type_title3' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title3' name='slct_size_title3' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题四:</td>
							<td><select id='slct_type_title4' name='slct_type_title4' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title4' name='slct_size_title4' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题五:</td>
							<td><select id='slct_type_title5' name='slct_type_title5' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title5' name='slct_size_title5' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>正文:</td>
							<td><select id='slct_type_content' name='slct_type_content' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_content' name='slct_size_content' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
					</table>
				</form>
				<div style="text-align:center;padding:5px">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="savethefontsize()">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$('#dlg_style').dialog('close')">取消</a>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var username="<%=session.getAttribute("usercode")%>";
	var submittype=1;
	$('#selectpedigree').combobox({
		valueField : 'pid',
		textField : 'text'
	});
	$('#style_form').form({
		url : '<%=path%>/userAction!savethefontrule.action',//保存
		onSubmit : function() {
			if(submittype==1){
				$('#fontruleid').val("-1");
				return true;
			}
			else{
				var row=$('#cc').datagrid('getSelected');
				if(row!=null){
					$('#fontruleid').val(row.fontruleid);
					return true;
				}
				else{
					 $.messager.alert('警告','请选择一个字体设置规则进行编辑！','warning');
					 return false;
				}
			}
			},
		success : function(r) {
			var rObj = jQuery.parseJSON(r);
			if (rObj.success) {//插入成功
				$.messager.show({
					title : '提示',
					msg : '字体设置保存成功'
				//提示是否成功的信息
				});
				$('#dlg_style').dialog('close');
				$('#cc').datagrid('reload');
			}
			else{
				$.messager.show({
					title : '提示',
					msg : '字体设置保存失败，请重试！'
				//提示是否成功的信息
				});
			}
		}
	});
	$(function() {
		$('#navbar').accordion('select', '族谱发布');
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'username=' + username,
			url : '${pageContext.request.contextPath}/userAction!showthegname.action',
			error : function() {//请求失败处理函数  
				alert('获取族谱列表失败，请检查网络');
			},
			success : function(j) {
				var rObj = jQuery.parseJSON(j);
				if (rObj.success) {
					$('#selectpedigree').combobox('loadData', rObj.obj);
				}
			}
});	
	});
	function appendrule(){
		$('#rulename').val("");
		$('#selectpedigree').combobox('clear');
		submittype=1;
		$('#dlg_style').dialog('open');
	}
	function removerule(){//need edit
		var row=$('#cc').datagrid('getSelected');
		var index=$('#cc').datagrid('getRowIndex',row);
		var ruleid;
		if(row!=null){
			ruleid=row.fontruleid;
		}
		else{
			 $.messager.alert('警告','请选择要删除的字体设置规则！','warning');
			 return;
		}
		$.messager.confirm('提示', '您确定要删除该设置规则吗?', function(r){
            if (r){
        		$.ajax({
        			async : false,
        			cache : false,
        			type : 'post',
        			data : 'fontruleid=' + ruleid,
        			url : '${pageContext.request.contextPath}/userAction!deltethefontsize.action',
        			error : function() {//请求失败处理函数  
        				$.messager.alert('警告','字体设置规则删除失败，请重试！','warning');
        			},
        			success : function(j) {
        				var rObj = jQuery.parseJSON(j);
        				if (rObj.success) {
        					$.messager.show({
        						title : '提示',
        						msg : '字体设置删除成功！'
        					//提示是否成功的信息
        					});
        					$('#cc').datagrid('deleteRow',index);
        				}
        				else{
        					$.messager.alert('警告','字体设置规则删除失败，请重试！','warning');
        				}
        			}
        });	
            }
        });
	}
	function editrule(){
		submittype=2;
		var row=$('#cc').datagrid('getSelected');
		var fontsizeid=row.fontruleid;
		if(row!=null){
			$('#rulename').val(row.rulename);
			$('#selectpedigree').combobox('select', row.gid);
			$.ajax({
				async : false,
				cache : false,
				type : 'post',
				data : 'fontruleid=' + fontsizeid,
				url : '${pageContext.request.contextPath}/userAction!showthefontdetail.action',
				error : function() {//请求失败处理函数  
					$.messager.alert('警告','获取字体设置详细信息失败，请重试！','warning');
				},
				success : function(j) {
					var rObj = jQuery.parseJSON(j);
					if (rObj.success) {
						$('#slct_type_title1').combobox('select', rObj.obj.slct_type_title1);
						$('#slct_type_title2').combobox('select', rObj.obj.slct_type_title2);
						$('#slct_type_title3').combobox('select', rObj.obj.slct_type_title3);
						$('#slct_type_title4').combobox('select', rObj.obj.slct_type_title4);
						$('#slct_type_title5').combobox('select', rObj.obj.slct_type_title5);
						$('#slct_type_content').combobox('select', rObj.obj.slct_type_content);
						$('#slct_size_title1').combobox('select', rObj.obj.slct_size_title1);
						$('#slct_size_title2').combobox('select', rObj.obj.slct_size_title2);
						$('#slct_size_title3').combobox('select', rObj.obj.slct_size_title3);
						$('#slct_size_title4').combobox('select', rObj.obj.slct_size_title4);
						$('#slct_size_title5').combobox('select', rObj.obj.slct_size_title5);
						$('#slct_size_content').combobox('select', rObj.obj.slct_size_content);
					}
					else{
						$.messager.alert('警告','获取字体设置详细信息失败，请重试！','warning');
					}
				}
	});
			$('#dlg_style').dialog('open');
		}
		else{
			 $.messager.alert('警告','请选择一个字体设置规则进行编辑！','warning');
		}
	}
	function savethefontsize(){
		$("#style_form").submit();	
	}
	</script>
</body>
</html>

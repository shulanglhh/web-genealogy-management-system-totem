<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>族谱管理</title>

<jsp:include page="inc.jsp"></jsp:include>
<script type="text/javascript" src="jslib/json2.js"></script>

<script type="text/javascript">
	 var editIndex = undefined;
	$(function() {
		$('#navbar').accordion('select', '数据管理');
		var username="<%=session.getAttribute("username")%>";
		var userid="<%=session.getAttribute("userid")%>";
<%-- 		var userrole="<%=session.getAttribute("userrole")%>"; --%>
// 		if(userrole!="谱志管理员"){
// 			$('#contrbar').find('a:first-child').remove();
// 			$('#contrbar').find('a:last-child').remove();
// 		}
		$('#mangeg_datagrid').datagrid({
			url : '${pageContext.request.contextPath}/genealogyAction!showthepedigree.action',
			fit : true,
			fitColumns : true,
			border : false,
			pagination : true,
			idField : 'gid',
			loadMsg : '载入中......',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50 ],
			rownumbers : true,
			singleSelect : true,
			toolbar : '#tb',
			onClickRow: onClickRow,
			checkOnSelect : false,
			selectOnCheck : false,
			sortName : 'gid',
			frozenColumns : [ [ {
				field : 'gname',
				title : '族谱名称',
				width : 200,
				editor:'text',
				 required:true
			},{
				field : 'gid',
				title : '族谱ID',
				width : 150,
				hidden:true
			} ] ],
			columns : [ [ {
				field : 'familyname',
				title : '姓氏',
				width : 50,
				editor:'text'
			},{
				field : 'tangname',
				title : '堂号',
				width : 150,
				editor:'text'
			},{
				field : 'locationplace',
				title : '族谱所属省份',
				width : 150,
				editor:{
			    	type:'combobox', 
					options:{
						valueFiled:'value',textField:'text', 
						data:[{value:'江苏省', text:'江苏省'},
						      {value:'北京', text:'北京'},
						    	  {value:'天津', text:'天津'},
						    		  {value:'上海', text:'上海'},
						    			  {value:'重庆', text:'重庆'},
						    				  {value:'广东省', text:'广东省'},
						    					  {value:'浙江省', text:'浙江省'},
						    						  {value:'福建省', text:'福建省'},
						    							  {value:'湖南省', text:'湖南省'},
						    								  {value:'湖北省', text:'湖北省'},
						    									  {value:'山东省', text:'山东省'},
						    										  {value:'辽宁省', text:'辽宁省'},
						    										  {value:'吉林省', text:'吉林省'},
						    											  {value:'云南省', text:'云南省'},
						    												  {value:'四川省', text:'四川省'},
						    												  {value:'安徽省', text:'安徽省'},
						    												  {value:'江西省', text:'江西省'},
						    												  {value:'黑龙江省', text:'黑龙江省'},
						    												  {value:'河北省', text:'河北省'},
						    												  {value:'陕西省', text:'陕西省'},
						    												  {value:'海南省', text:'海南省'},
						    												  {value:'河南省', text:'河南省'},
						    												  {value:'山西省', text:'山西省'},
						    												  {value:'四川省', text:'四川省'},
						    												  {value:'内蒙古', text:'内蒙古'},
						    												  {value:'广西', text:'广西'},
						    												  {value:'贵州省', text:'贵州省'},
						    												  {value:'宁夏', text:'宁夏'},
						    												  {value:'青海省', text:'青海省'},
						    												  {value:'新疆', text:'新疆'},
						    												  {value:'西藏', text:'西藏'},
						    												  {value:'甘肃省', text:'甘肃省'},
						    												  {value:'台湾省', text:'台湾省'},
						    												  {value:'香港', text:'香港'},
						    												  {value:'澳门', text:'澳门'},
						    												  {value:'国外', text:'国外'}]					
					}
				}
			},
			//{
			//	field : 'mainresponsible',
			//	title : '主责任人',
			//	width : 150,
			//	editor:'text'
			// },
			//{
			//	field : 'otherresponsible',
			//	title : '其他责任人',
			//	width : 150,
			//	editor:'text'
			//  },
// 			{
// 				field : 'contact',
// 				title : '联系方式',
// 				width : 150,
// 				editor:'text'
// 			},{
// 				field : 'contactperson',
// 				title : '联系人',
// 				width : 150,
// 				editor:'text'
// 			},{
// 				field : 'source',
// 				title : '族谱来源',
// 				width : 150,
// 				editor:'text'
//  			},//{
// 				field : 'doublegenprefix',
// 				title : '双世系前缀信息',
// 				width : 200,
// 				editor:'text'
// 			},{
// 				field : 'doublegen',
// 				title : '双世系起始世代',
// 				width : 200,
// 				editor:'numberbox'
// 			},
			{
				field : 'description',
				title : '谱志描述',
				width : 150,
				editor:'text'
			},//{
// 				field : 'teamid',
// 				title : '负责团队号',
// 				width : 150,
// 				hidden:true
// 			},//{
			//	field : 'creator',
			//	title : '创建者账号',
			//	width : 150
			//},{
			//field : 'teamname',
			//title : '团队名称',
			//width : 150
		//},
// 		{
// 				field : 'status',
// 				title : '谱志状态',
// 				width : 150
// 			},{
// 				field : 'archivedsc',
// 				title : '归档注释说明',
// 				width : 150
// 			}
			] ]
		});	
	});
	function removethegenealogy() {
		if (editIndex == undefined) {
			return;
			alert("请先选择要删除的族谱！")
		}
		$.messager.confirm('确认', '您是否要删除当前选中的族谱吗？', function(r) {
			if (r) {
		var rowdata = $('#mangeg_datagrid').datagrid('getSelected');
		var rowIndex = $('#mangeg_datagrid').datagrid('getRowIndex',
				rowdata);
		var oid = rowdata.oid;
		$('#mangeg_datagrid').datagrid('cancelEdit', editIndex)
				.datagrid('deleteRow', editIndex);
		editIndex = undefined;
		accept();
			}
	});
	}

	function endEditing() {
		if (editIndex == undefined) {
			return true;
		}
		if ($('#mangeg_datagrid').datagrid('validateRow', editIndex)) {
			$('#mangeg_datagrid').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	function onClickRow(index) {
		if (editIndex != index) {
			if (endEditing()) {
				$('#mangeg_datagrid').datagrid('selectRow', index)
						.datagrid('beginEdit', index);
				editIndex = index;
			} else {
				$('#mangeg_datagrid').datagrid('selectRow', editIndex);
			}
		}
	}
	function append() {
		if (endEditing()) {
			accept();
			location.href='<%=path%>'+'/creatNewPedigree.jsp';
		}
	}
	function accept() {
		if (endEditing()) {
			var rowtmp = $('#mangeg_datagrid').datagrid('getChanges');
			var rows=JSON.stringify(rowtmp);
			if(rows!="[]"){
			var deleted = $('#mangeg_datagrid').datagrid('getChanges',
					'deleted');
			var updated = $('#mangeg_datagrid').datagrid('getChanges',
					'updated');
			var deleteds;
			var updateds;
			if (updated.length) {
				updateds = JSON.stringify(updated);
			}
			if (deleted.length) {
				deleteds = JSON.stringify(deleted);
				$.messager.confirm('确认', '这将会删除与该族谱所有相关的信息，你是否坚持操作？', function(r) {
					if (r) {
						$.ajax({
							async : false,
							cache : false,
							type : 'post',
							data : 'deleteds='+ deleteds + '&updateds=' + updateds,
							url : '${pageContext.request.contextPath}/genealogyAction!savethegenealogy.action',//请求的action路径  
							error : function() {//请求失败处理函数  
								alert('保存失败，请检查网络');
							},
							success : function(j) { //请求成功后处理函数。  
								var rObj = eval('(' + j + ')');
								if (rObj.success) {
									$.messager.show({
										title : '提示',
										msg : rObj.msg
									});
									$('#mangeg_datagrid').datagrid(
											'acceptChanges');
									$('#mangeg_datagrid').datagrid(
											'loadData', rObj.obj);
								} else {
									$.messager.show({
										title : '提示',
										msg : rObj.msg
									});
								}
							}
						});
					}
					else{
						reject();
					}
			});
			}
			else{
				$.ajax({
					async : false,
					cache : false,
					type : 'post',
					data : 'deleteds='+ deleteds + '&updateds=' + updateds,
					url : '${pageContext.request.contextPath}/genealogyAction!savethegenealogy.action',//请求的action路径  
					error : function() {//请求失败处理函数  
						alert('任务分工保存失败，请检查网络');
					},
					success : function(j) { //请求成功后处理函数。  
						var rObj = eval('(' + j + ')');
						if (rObj.success) {
							$.messager.show({
								title : '提示',
								msg : rObj.msg
							});
							$('#mangeg_datagrid').datagrid(
									'acceptChanges');
							$('#mangeg_datagrid').datagrid(
									'loadData', rObj.obj);
						} else {
							$.messager.show({
								title : '提示',
								msg : rObj.msg
							});
						}
					}
				});
			}
		}
//			else{alert('没有改变的');}
		}

	}
	function reject() {
		$('#mangeg_datagrid').datagrid('rejectChanges');

		editIndex = undefined;
	}
	function designthetask(){
		location.href='<%=path%>'+'/designthetask.jsp';
	}
	function dothefinish(){
		$('#choosethestate').dialog('open');
	}
	function getPediName(){
		var gidrow=$('#mangeg_datagrid').datagrid('getSelected');
		url_ ="http://localhost:8000/get_pdf/?gid="+gidrow.gid+"&grpid=000";
		//alert(url_);
		//location.href=url_;
		$.ajax({
			url: url_,	
			type:'get',
			async:false,
            cache:false,         
			success: function () {
				alert("生成成功");
			}, error: function (a,b,c) {
				alert("生成成功");
			}
		});
		path = '<%=path%>'+"/Gen2PdfService/output/"+gidrow.gname+"/"+gidrow.gname+".pdf";
		pathq = "<%=path.substring(0,path.lastIndexOf("/"))%>/pedigree"+"/Gen2PdfService/output/"+gidrow.gname+"/"+gidrow.gname+".pdf";
		$.messager.confirm('确认', '生成成功，是否保存到本地？', function(r) {
			if (r) {
				
				window.open(pathq);
			}
		});
	}
	function recoverthedsc(){
		var choosethegid;
		var savedsc=$('#savedsc').val();
		var gidrow=$('#mangeg_datagrid').datagrid('getSelected');
		if(gidrow==null){
			$.messager.alert('提示','请先选中一个族谱','warning');
			$('#choosethestate').dialog('close');
			return false;
		}
		else{
			choosethegid=gidrow.gid;
		}
		if(savedsc==undefined){
			$.messager.alert('提示','为了防止发生意外，请填写归档说明！','warning');
			return false;
		}
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'choosethegid='+ choosethegid,
			url : '<%=path%>/userAction!recoverthestate.action',//请求的action路径   
			error : function() {//请求失败处理函数  
				$.messager.alert('提示','恢复失败，请重试！','warning');
			},
			success : function(j)  {
				var rObj = jQuery.parseJSON(j);
				if (rObj.success) {//插入成功
					$('#ff').form('clear');
					$('#choosethestate').dialog('close');
					$('#mangeg_datagrid').datagrid('reload');
					$.messager.show({
						title : '提示',
						msg : '恢复族谱成功！'
					//提示是否成功的信息
					});
				}
				else{
					$.messager.show({
						title : '提示',
						msg : '恢复族谱失败，请重试！'
					//提示是否成功的信息
					});
				}
			}
		});
	}
	function savethedsc(){
		var choosethegid;
		var savedsc=$('#savedsc').val();
		var gidrow=$('#mangeg_datagrid').datagrid('getSelected');
		if(gidrow==null){
			$.messager.alert('提示','请先选中一个族谱','warning');
			$('#choosethestate').dialog('close');
			return false;
		}
		else{
			choosethegid=gidrow.gid;
		}
		if(savedsc==undefined){
			$.messager.alert('提示','为了防止发生意外，请填写归档说明！','warning');
			return false;
		}
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'choosethegid='+ choosethegid + '&savedsc=' + savedsc,
			url : '<%=path%>/userAction!editthestate.action',//请求的action路径   
			error : function() {//请求失败处理函数  
				$.messager.alert('提示','归档失败，请重试！','warning');
			},
			success : function(j)  {
				var rObj = jQuery.parseJSON(j);
				if (rObj.success) {//插入成功
					$('#ff').form('clear');
					$('#choosethestate').dialog('close');
					$('#mangeg_datagrid').datagrid('reload');
					$.messager.show({
						title : '提示',
						msg : '归档族谱成功！'
					//提示是否成功的信息
					});
				}
				else{
					$.messager.show({
						title : '提示',
						msg : '归档族谱失败，请重试！'
					//提示是否成功的信息
					});
				}
			}
		});
	}
</script>
</head>

<body>
	<div class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north'" style="height:50px;overflow:hidden;" data-options="fit:true">
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
		<div data-options="region:'center',title:'族谱管理（在编辑状态才能删除）'" id="centerLayout">
			<div class="easyui-layout" id="layoutdialog" data-options="fit:true">
				<div data-options="region:'north',fit:true">
						<table id="mangeg_datagrid"></table>
						<div id="tb" style="padding:5px;height:auto">
							<div style="margin-bottom:5px" id="contrbar">
								<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
									onclick=append()>增加</a> <a class="easyui-linkbutton"
									iconCls="icon-remove" plain="true" onclick=removethegenealogy()>删除</a>
								<a class="easyui-linkbutton" iconCls="icon-save" plain="true"
									onclick=accept()>保存</a> <a class="easyui-linkbutton"
									iconCls="icon-undo" plain="true" onclick=reject()>撤销</a>
<!-- 									<a class="easyui-linkbutton" -->
<!-- 									iconCls="icon-edit" plain="true" onclick=dothefinish()>归档</a> -->
<!-- 									<a class="easyui-linkbutton" -->
<!-- 									iconCls="icon-add" plain="true" onclick=recoverthedsc()>下载族谱</a> -->
									<a class="easyui-linkbutton"
									iconCls="icon-add" plain="true" onclick=getPediName()>生成族谱</a> 
<!-- 								<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" -->
<!-- 									onclick=designthetask()>录入任务分配</a> -->
							</div>
						</div>


				</div>
				<div data-options="region:'center'"></div>
			</div>
		</div>
	</div>
	
		<div id="choosethestate" class="easyui-dialog" title="族谱归档" style="width:260px;height:130px;padding:10px;"
			data-options="closed:true,
			resizable:false,
			modal:true">
			<form id="ff" method="post">
			<input id="choosethegid" name="choosethegid" type="hidden" />	
			<label style="width:100px">归档注释说明:</label>
			<input id="savedsc" name="savedsc" class="easyui-validatebox" required="true" style="width:130px"></input>
			<div style="text-align:center;padding:10px">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="savethedsc()">归档</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$('#ff').form('clear');$('#choosethestate').dialog('close')">取消</a>
			</div>
			</form>
			</div>
</body>
</html>


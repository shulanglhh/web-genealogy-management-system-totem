<%@ page language="java" contentType="text/html; charset=UTF-8" import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*,java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*;"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="pragma" content="no-cache" />
<title>谱志编排</title>

<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript"
	src="<%=path%>/jslib/jquery-easyui-1.3.2/datagrid-detailview.js"></script>
<script type="text/javascript"
	src="<%=path%>/jslib/treejs/jquery.ztree.all-3.5.min.js"></script>

<link rel="stylesheet" href="<%=path%>/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script>
var username="<%=session.getAttribute("usercode")%>";
var getVolumeAction = '<%=path%>/pediVolumeAction!getVolumeList.action';
var getDocAction = '<%=path%>/pediVolumeAction!getDocList.action';
var getGroupAction = '<%=path%>/pediVolumeAction!getGroupList.action';
var toolbar = [{
	iconCls: 'icon-remove',
	text: '删除',
	handler: removeVolentries
},{
	iconCls: 'icon-add',
	text: '增加章节',
	handler: openaddcontentdialog
}];

$(function() {
	
	$('.easyui-accordion').accordion('select', '谱志发布');
	
	/**初始始化“选择族谱”的combobox*/
	$('#selectpedigree').combobox({
		valueField : 'pid',
		textField : 'text',
		onSelect : loadVolumeInfo
	});
	$('#selectrule').combobox({
		valueField : 'pid',
		textField : 'text',
		onSelect : reloadthedoc
	});
	/**初始化“分卷列表”的datagrid*/
	$('#volumelist_datagrid').datagrid({
		view: detailview,
		singleSelect:true,
		nowrap:false,
		border:false,
		//fit:true,
		//fitColumns:true,
		detailFormatter:function(index,row){
			return '<div style="padding:5px"><table class="ddv"></table></div>';
		},
		onSelect : function(index, row){
			rowIndex = index;//为编辑卷名而设置的变量
			//$(this).datagrid('expandRow', index);
		},		
		//onDblClickCell: onDblClickCell,
		//autoRowHeight:true,
		toolbar : '#voltoolbar',
		onExpandRow: function(index,row){
			$(this).datagrid('selectRow', index);
			var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
			ddv.datagrid({
				url:'<%=path%>/pediVolumeAction!getVolEntries.action?volId='+row.volid,
				fitColumns:true,				
				singleSelect:true,
				rownumbers:true,
				toolbar : toolbar,
				loadMsg:'载入文档、行传、吊线信息',
				height:'auto',
				columns:[[
					{field:'objname',title:'名称',width:150},					
					{field:'type',title:'类型',width:60,align:'right'},
					{field:'rank',title:'序号',width:35,align:'right'}
				]],
				onResize:function(){
					$('#volumelist_datagrid').datagrid('fixDetailRowHeight',index);
				},
				onLoadSuccess:function(){
					setTimeout(function(){
						$('#volumelist_datagrid').datagrid('fixDetailRowHeight',index);
					},0);
				}
			});
			$('#volumelist_datagrid').datagrid('fixDetailRowHeight',index);
		},
		onCollapseRow: function(index, row){
			$('#volumelist_datagrid').datagrid('fixDetailRowHeight',index);
		}
	});
	
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
	$.ajax({
		async : false,
		cache : false,
		type : 'post',
//		data : 'username=' + username,
		url : '${pageContext.request.contextPath}/genealogyAction!selectrule.action',
		error : function() {//请求失败处理函数  
			alert('获取族谱列表失败，请检查网络');
		},
		success : function(j) {
			var rObj = jQuery.parseJSON(j);
			if (rObj.success) {
				$('#selectrule').combobox('loadData', rObj.obj);
			}
		}
});	
});

/**用于前台的分页*/
function pagerFilter(data){
	if (typeof data.length == 'number' && typeof data.splice == 'function'){    // 判断数据是否是数组
	    data = {
	        total: data.length,
	        rows: data
	    }
	}
	var dg = $(this);
	var opts = dg.datagrid('options');
	var pager = dg.datagrid('getPager');
	pager.pagination({
	    onSelectPage:function(pageNum, pageSize){
	        opts.pageNumber = pageNum;
	        opts.pageSize = pageSize;
	        pager.pagination('refresh',{
	            pageNumber:pageNum,
	            pageSize:pageSize
	        });
	        dg.datagrid('loadData',data);
	    }
	});
	if (!data.originalRows){
	    data.originalRows = (data.rows);
	}
	var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
	var end = start + parseInt(opts.pageSize);
	data.rows = (data.originalRows.slice(start, end));
	return data;
}   

/**加载族谱的所有分卷，在选择一个族谱时触发*/
function loadVolumeInfo(record){	
	//重新加载分卷信息
	$('#volumelist_datagrid').datagrid('load',{
		pediId: record.pid
	});
	//重新加载文档信息
	$('#usersdoc_datagrid').datagrid({loadFilter:pagerFilter}).datagrid('load',{
		pediId: record.pid
	});
	//重新加载分组信息
	$('#grouplist_datagrid').datagrid({loadFilter:pagerFilter}).datagrid('load',{
		pediId: record.pid
	});
}

/**给一个分卷增加文档*/
function addDocsToVolume(){
	//选择的文档，数组类型
	var volDG = $('#volumelist_datagrid');	
	var volrow = volDG.datagrid('getSelected');
	var volindex = volDG.datagrid('getRowIndex', volrow);
	var volentry = volDG.datagrid('getRowDetail', volindex).find('table.ddv');
	
	var rowdata = $('#usersdoc_datagrid').datagrid('getSelections');

	if(rowdata.length > 0 && volindex >= 0){		
		var index = volentry.datagrid('getData').total;
		for(var i = 0; i < rowdata.length; i++, index++){
			var volentryrow = {
					objid : rowdata[i].docid,
					objname : rowdata[i].docname,
					type : 'doc',
					rank : index+1
				};
			volentry.datagrid('insertRow',{
				index : index,
				row : volentryrow
			});
		}
		$('#usersdoc_datagrid').datagrid('uncheckAll');
		volDG.datagrid('fixDetailRowHeight',volindex);
	}else{alert("请选中目标");}
}

/**给一个分卷增加吊线行传*/
function addGroupsToVolume(){
	//选择的文档，数组类型
	var volDG = $('#volumelist_datagrid');	
	var volrow = volDG.datagrid('getSelected');
	var volindex = volDG.datagrid('getRowIndex', volrow);
	var volentry = volDG.datagrid('getRowDetail', volindex).find('table.ddv');
	
	var rowdata = $('#grouplist_datagrid').datagrid('getSelections');

	if(rowdata.length > 0 && volindex >= 0){		
		var index = volentry.datagrid('getData').total;
		for(var i = 0; i < rowdata.length; i++, index++){
			var volentryrow = {
					objid : rowdata[i].grpid,
					objname : rowdata[i].grpname,
					type : rowdata[i].type,
					rank : index+1
				};
			volentry.datagrid('insertRow',{
				index : index,
				row : volentryrow
			});
		}
		$('#grouplist_datagrid').datagrid('uncheckAll');
		volDG.datagrid('fixDetailRowHeight',volindex);
	}else{alert("请选中目标");}
}

/**增加一个分卷*/
function addVolume(){
	var volDG = $('#volumelist_datagrid');	
	var total = volDG.datagrid('getData').total;
	var volrow = volDG.datagrid('getSelected');
	var volindex = volDG.datagrid('getRowIndex', volrow);
	
	//volDG.datagrid('fixDetailRowHeight', volindex);
	//volDG.datagrid('fixRowHeight', volindex);//设置行高，以免乱入
	for(var i=0;i<total;i++){
		volDG.datagrid('collapseRow', i);
		volDG.datagrid('refreshRow', i);
	}
	volDG.datagrid('appendRow', {
			volname : '新加卷',//,
			rank : total+1		
	});
	//volDG.datagrid('fixRowHeight', volindex);

	//alert(total);
	//volDG.datagrid('refreshRow', volindex);
	//volDG.datagrid('collapseRow', volindex);
	
	//volDG.datagrid('fixDetailRowHeight', volindex);
	
	//volDG.datagrid('fixRowHeight', total);//设置行高，以免乱入
	volDG.datagrid('expandRow', total);//选中新增行
	editVolname();//弹出卷名编辑框
}

/**删除一个分卷*/
function deleteVolume(){
	var volDG = $('#volumelist_datagrid');
	var delRow = volDG.datagrid('getSelected');
	if(delRow != null){
		var pediId = delRow.gid;//$('#selectpedigree').combobox('getValue');
		var volid = delRow.volid;
		if(volid == undefined){
			volDG.datagrid('deleteRow', volDG.datagrid('getRowIndex', delRow));
			return;
		}
		$.ajax({			
			type : 'post',
			data : 'volid=' + volid + '&pediId=' + pediId + '&volName=' + delRow.volname,
			url : '${pageContext.request.contextPath}/pediVolumeAction!deleteVolume.action',//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('删除分卷失败，请检查网络');
			},
			success : function(j) { //请求成功后处理函数。  
				var rObj = eval('(' + j + ')');
				if (rObj.success) {
					alert(rObj.msg);
					//volentry.datagrid('acceptChanges');
					volDG.datagrid('load',{
						pediId: pediId
					});
				} else {
					alert(rObj.msg);
				}
			}
		});
	}
}

/**保存选中分卷*/
function saveVolume(){
	var volDG = $('#volumelist_datagrid');	
	var volrow = volDG.datagrid('getSelected');
	var volindex = volDG.datagrid('getRowIndex', volrow);
	var volentry = volDG.datagrid('getRowDetail', volindex).find('table.ddv');
	
	var volid = volrow.volid;
	var volname = volrow.volname;
	var pediId = $('#selectpedigree').combobox('getValue');//volrow.pid;//族谱id
	
	var allrows = volentry.datagrid('getRows');
	var deleted = volentry.datagrid('getChanges', 'deleted');
	var rows = JSON.stringify(allrows);
	var delrows = JSON.stringify(deleted);//要删除的行们	
	if(rows!="[]"||delrows!="[]"){		
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'rows=' + rows + '&delrows=' + delrows + '&volid='
					+ volid + '&volname=' + volname + '&pediId=' + pediId,
			url : '${pageContext.request.contextPath}/pediVolumeAction!saveVolume.action',//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('保存分卷失败，请检查网络');
			},
			success : function(j) { //请求成功后处理函数。  
				var rObj = eval('(' + j + ')');
				if (rObj.success) {
					//alert(rObj.msg);
					$.messager.show({
						title : '提示',
						msg : rObj.msg		
					});
					//volentry.datagrid('acceptChanges');
					volentry.datagrid('load',{
						volId: volid
					});
					volDG.datagrid('fixDetailRowHeight',volindex);
				} else {
					alert(rObj.msg);
				}
			}
		});
	}
}
/**弹出框，编辑分卷名*/
function editVolname(){
	var volDG = $('#volumelist_datagrid');	
	var row = volDG.datagrid('getSelected');
	if(row != null){
		$('#volname').val(row.volname);
		$('#editvolume-dialog').dialog('open');
	}
}

/**编辑完成确定，更新分卷datagrid对应的行*/
function confirmVolname(){
	//var ed = $('#volumelist_datagrid').datagrid('getEditor', {index:rowIndex,field:'volname'});
	//$(ed.target).datagrid('setValue', $('#volname').val()+'www');
	var volDG = $('#volumelist_datagrid');
	var row = volDG.datagrid('getSelected');
	var index = volDG.datagrid('getRowIndex', row);
	volDG.datagrid('collapseRow', index);
	volDG.datagrid('updateRow', {
		index : index,
		row : {
			volname : $('#volname').val()						
		}
	});
	volDG.datagrid('expandRow', index);
	volDG.datagrid('fixDetailRowHeight',volDG.datagrid('getData').total);
	//volDG.datagrid('expandRow', index);
	closeEditVolDialog();
}
/***/
function closeEditVolDialog(){
	$('#editvolume-dialog').dialog('close');
	$('#volname').val('');
}
/**删除卷中的项们*/
function removeVolentries(){
	var volDG = $('#volumelist_datagrid');	
	var volrow = volDG.datagrid('getSelected');
	var volindex = volDG.datagrid('getRowIndex', volrow);
	var volentry = volDG.datagrid('getRowDetail', volindex).find('table.ddv');
	var selections = volentry.datagrid('getSelections');//所选择的一些项
	
	if(selections.length > 0){
		var i = selections.length;
		//删除选中的行们
		for(; i > 0; i--){
			var index = volentry.datagrid('getRowIndex', selections[i-1]);
			volentry.datagrid('deleteRow', index);//删除该行
		}
		var voltotal = volentry.datagrid('getData').total;
		//更新后边行的rank
		for(var j = 0; j < voltotal; j++){
			volentry.datagrid('unselectAll');//取消所有所选
			volentry.datagrid('selectRow', j);//再选中
			var updateRow = volentry.datagrid('getSelected');
			updateRow.rank = j + 1;//设置该行的rank
			volentry.datagrid('updateRow', {index:j,row:updateRow});
		}
		volentry.datagrid('unselectAll');//取消所有所选
	}
	volDG.datagrid('fixDetailRowHeight',volindex);
}
function openaddcontentdialog(){
	$('#addcontent-dialog').dialog('open');
}
function closeaddcontentdialog(){
	$('#contentname').val("");
	$('#contenttype').val("");
	$('#addcontent-dialog').dialog('close');
}
//增加章节
function confirmcontent(){
	var volDG = $('#volumelist_datagrid');	
	var volrow = volDG.datagrid('getSelected');
	var volindex = volDG.datagrid('getRowIndex', volrow);
	var volentry = volDG.datagrid('getRowDetail', volindex).find('table.ddv');
	var contentname=$('#contentname').val();
	var contenttype=$('#contenttype').val();
	var type;
	if(contenttype=='0'){
		type='contentdoc';
	}
	else{type='contenttitle';}
	if(volindex >= 0){		
		var index = volentry.datagrid('getData').total;
			var volentryrow = {
					objid : -1,
					objname : contentname,
					type : type,
					rank : index+1
				};
			volentry.datagrid('insertRow',{
				index : index,
				row : volentryrow
			});
		volDG.datagrid('fixDetailRowHeight',volindex);
	}else{alert("请选中增加章节的分卷");}
	closeaddcontentdialog();
}
/**上移分卷项的实现*/
function moveUpVolentries() {

}
/**下移分卷项*/
function moveDownVolentries() {

}
/**选择规则重新载入文档*/
function reloadthedoc(record){
	
	var gid=$('#selectpedigree').combobox('getValue');
	if(gid!=""){
		var opts = $('#usersdoc_datagrid').datagrid("options");
		opts.url="";
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'ruleid='+record.pid+'&gid='+gid,
			url : '<%=path%>/genealogyAction!reloadthedoc.action',//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('选择规则出错，请检查网络！');
			},
			success : function(j) { //请求成功后处理函数。  
				var rObj = eval('(' + j + ')');
				if (rObj.success) {
					$.messager.show({
						title : '提示',
						msg : rObj.msg		
					});
					$('#usersdoc_datagrid').datagrid({
						loadFilter : pagerFilter
					}).datagrid('loadData', rObj.obj);
					$('#usersdoc_datagrid').datagrid('onCheckAll');
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

</script>
</head>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north'" style="height:50px;overflow:hidden;" data-options="fit:true">
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
	<div data-options="region:'center'" id="centerLayout">
		<div id="arrange-vol-dlg" style="width: 970px;height:600px;"
			class="easyui-dialog"
			data-options="title:'谱志编排',iconCls:'icon-save',closable:false,modal:false">
			<div class="easyui-layout" data-options="fit:true">
				<%--左边为分卷列表--%>
				<div data-options="region:'west'" style="width:350px">
					<div class="easyui-panel" title="谱志分卷"
						data-options="fit:true,split:false,border:false">
						<div class="easyui-layout" data-options="fit:true">
							<div data-options="region:'north',border:false"
								style="height:40px">
								<div style="margin-top:10px">								
								<label for="selectpedigree">选择族谱：</label> <select
									id="selectpedigree" name="selectpedigree" style="width:100px"></select>
								</div>
							</div>
							<%--显示分卷的部分--%>
							<div data-options="region:'center'" style="height:500px">
								<%--分卷列表--%>								
						         <table id="volumelist_datagrid" style="width:340px;height:480px"
							            url="<%=path%>/pediVolumeAction!getPediVolumes.action" 							            
							            >
							        <thead>
							            <tr>
							                <th data-options = "field:'volname',fit:true,editor:{
							                	type:'text',
							                	options:{
							                		valueField:'volname',
                                					textField:'volname'
							                	}
							                }" width="250">卷名</th>
							                <th data-options = "field:'rank',fit:true" width="50">序号</th>							                
							            </tr>
							        </thead>
							    </table> 
							</div>
							<div id="voltoolbar" style="padding:5px;height:auto">
								<div style="margin-bottom:5px">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										id="addVolume" onclick="addVolume()">新建卷</a>
									<a class="easyui-linkbutton" iconCls="icon-remove" plain="true"
										id="delVolume" onclick="deleteVolume()">删除</a>
									<a class="easyui-linkbutton" iconCls="icon-save" plain="true"
										id="saveVolume" onclick="saveVolume()">保存</a>
									<a class="easyui-linkbutton" iconCls="icon-edit" plain="true"
										onclick="editVolname()">编辑卷名</a>
								</div>					
							</div>						
							<%--<div data-options="region:'south'" style="height:30px">
								<a href="javascript:void(0)" class="easyui-linkbutton"
									id="addNewVolume" onclick="addNewVolume()">新建分卷</a>
								<a href="javascript:void(0)" class="easyui-linkbutton"
									id="editVolume" onclick="editVolume()">编辑分卷</a>
								<a href="javascript:void(0)" class="easyui-linkbutton"
									id="saveVolume" onclick="saveVolume()">保存选中分卷</a>
								<a href="javascript:void(0)" class="easyui-linkbutton"
									id="saveVolumes" onclick="saveAllVolumes()">保存所有分卷</a>	
							</div>
							--%><div id="editvolume-dialog" class="easyui-dialog"
									data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#vol-dlg-buttons'" title="新增章节"
									style="width:400px;height:200px;padding:10px">
									<label for="volname">卷名：</label><input id="volname" class="easyui-validatebox"></input> 
									<div id="vol-dlg-buttons">
										<a href="javascript:void(0)" class="easyui-linkbutton" id="confirmVolname" onclick="confirmVolname()">确定</a>
										<a href="javascript:void(0)" class="easyui-linkbutton"
											onclick="closeEditVolDialog()">取消</a>
									</div>		
							</div>
							<div id="addcontent-dialog" class="easyui-dialog"
									data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#addcontent-dlg-buttons'" title="输入分卷名"
									style="width:400px;height:200px;padding:10px">
									<div  style="margin-top:10px">
									<label for="contentname">章节名称：</label><input id="contentname" class="easyui-validatebox" style="width:156px"></input> 
									</div>
									<div  style="margin-top:20px">
									<label for="contenttype">章节类型：</label><select id="contenttype" name="contenttype">
									<option value ="0">在卷中独立扉页来显示</option>
									<option value ="1">在卷中作为标题来显示</option>
									</select>
									</div>
									<div id="addcontent-dlg-buttons">
										<a href="javascript:void(0)" class="easyui-linkbutton" id="confirmcontent" onclick="confirmcontent()">确定</a>
										<a href="javascript:void(0)" class="easyui-linkbutton"
											onclick="closeaddcontentdialog()">取消</a>
									</div>		
							</div>
						</div>
					</div>
				</div>
				<%--中间为文档列表--%>
				<div data-options="region:'center'" style="width:300px">
					<div class="easyui-panel" title="文档列表"
						data-options="fit:true,split:false,border:false">
						<div class="easyui-layout" data-options="fit:true">
							<div data-options="region:'north',border:false"
								style="height:40px">
								<div style="margin-top:10px">								
								<label for="selectrule">文档排序规则：</label> <select
									id="selectrule" name="selectrule" style="width:100px"></select>
								</div>
								</div>
							<div data-options="region:'center'" style="height:540px">
								<%--文档列表--%>
								<table id="usersdoc_datagrid" class="easyui-datagrid" style="width:300px;height:500px"
						             data-options="singleSelect:false,selectOnCheck:true,checkOnSelect:true,fit:true,
						              pagination:true,pageSize:10, collapsible:true,toolbar:'#doctoolbar',
						             url:'<%=path%>/pediVolumeAction!getPediDocs.action',method:'POST'">
						             <thead>
						                 <tr>
						                 	 <th data-options="field:'selectdoc',checkbox:true"></th>
						                     <th data-options="field:'docname',width:180">文件名</th>
						                     <th data-options="field:'docmodifydate',width:80">修改时间</th>
						                     <!-- <th data-options="field:'doccreator',width:50,align:'right'">编辑者</th> -->
						                 </tr>
						             </thead>
						         </table>
							</div>
							<%--对文档列表操作的按钮 --%>
							<div id="doctoolbar" style="padding:5px;height:auto">
								<div style="margin-bottom:5px">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										onclick="addDocsToVolume()">添加到分卷</a>
								</div>					
							</div>
						</div>
					</div>
				</div>
				<%--右边为分组列表：即行传和吊线列表--%>
				<div data-options="region:'east'" style="width:300px">
					<div class="easyui-panel" title="吊线和行传列表"
						data-options="fit:true,split:false,border:false">
						<div class="easyui-layout" data-options="fit:true">
							<div data-options="region:'north',border:false"
								style="height:40px" align="center"></div>
							<div data-options="region:'center'" style="height:540px">
								<table id="grouplist_datagrid" class="easyui-datagrid" style="width:300px;height:500px"
						             data-options="singleSelect:false, pagination:true,pageSize:15, collapsible:true,fit:true,
						             toolbar:'#grptoolbar',
						             url:'<%=path%>/pediVolumeAction!getPediGroups.action',method:'POST'">
						             <thead>
						                 <tr>
						                 	<th data-options="field:'selectgrp',checkbox:true"></th> 
						                    <th data-options="field:'grpname',width:160">分组名</th>
						                     <th data-options="field:'typename',width:70">类型</th>
						                   <%--  <th data-options="field:'doccreator',width:50,align:'right'">编辑者</th>
						                 --%></tr>
						             </thead>
						         </table>
							</div>
							<%--对行传吊线列表操作的按钮 --%>
							<div id="grptoolbar" style="padding:5px;height:auto">
								<div style="margin-bottom:5px">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										onclick="addGroupsToVolume()">添加到分卷</a>										
								</div>					
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
var treeid=10000;
var setting = {
					view : {
						selectedMulti : false //禁止多点选中  	
					},
					data : {
						simpleData : {
							enable : true,
							idKey : "id",
							pIdKey : "parentId",
							rootPId : ""
						}
					},
					edit : {
						enable : true,
						editNameSelectAll : true,
						removeTitle : "删除",
						renameTitle: "编辑",
						showRemoveBtn : true,
						showRenameBtn : true,
					},
					callback : {
						//onClick : clickNode,	
						//beforeRemove: removeNode,
						//onRightClick : rightClick,
						//beforeDrop : dragNode
					}
				};
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
	$('#selectbystyle').combobox({
		valueField : 'pid',
		textField : 'text',
		onSelect : reloadthedocbystyle
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
			var volname=row.volname;
			return "<div style='padding:5px'><ul id='tree"+row.rank+"' class='ztree'></ul></div>";
		},
		onSelect : function(index, row){
			rowIndex = index;//为编辑卷名而设置的变量
			//$(this).datagrid('expandRow', index);
		},		
		//onDblClickCell: onDblClickCell,
		//autoRowHeight:true,
		toolbar : '#voltoolbar',
		onExpandRow: function(index,row){
		//var volDG = $('#volumelist_datagrid');	
		//volDG.datagrid('selectRow',index);
		var treenode;
				if(row.volid!=undefined){
			$.ajax({
				async : false,
				cache : false,
				type : 'post',
				dataType:"json",
				data : 'volId=' + row.volid,
				url : '${pageContext.request.contextPath}/pediVolumeAction!getVolEntriestree.action',
				error : function() {//请求失败处理函数  
					alert('获取分卷结构失败，请检查网络');
				},
				success : function(j) {
					//var rObj = jQuery.parseJSON(j);
					treenode=j;
				}
	});	
	}
			$(this).datagrid('selectRow', index);
			var ddv = $(this).datagrid('getRowDetail',index).find('ul.ztree');
			if(treenode!=undefined&&treenode!=null){
				zTree = $.fn.zTree.init(ddv, setting,treenode);
				zTree.expandAll(true);
				var nodes = zTree.getNodes();
				zTree.selectNode(nodes[0]);
			}
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
			alert('获取文档规则失败，请检查网络');
		},
		success : function(j) {
			var rObj = jQuery.parseJSON(j);
			if (rObj.success) {
				$('#selectrule').combobox('loadData', rObj.obj);
			}
		}
});	
$.ajax({
		async : false,
		cache : false,
		type : 'post',
//		data : 'username=' + username,
		url : '${pageContext.request.contextPath}/genealogyAction!selectdocbystyle.action',
		error : function() {//请求失败处理函数  
			alert('获取文档类型失败，请检查网络');
		},
		success : function(j) {
			var rObj = jQuery.parseJSON(j);
			if (rObj.success) {
				$('#selectbystyle').combobox('loadData', rObj.obj);
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
	var volDG = $('#volumelist_datagrid');	
	var volrow = volDG.datagrid('getSelected');
	var rowdata = $('#usersdoc_datagrid').datagrid('getSelections');
	var volindex = volDG.datagrid('getRowIndex', volrow);
	if(rowdata!=null&&rowdata.length>0){
		if(volrow!=null&&volrow!=undefined){
				var treename="tree"+volrow.rank;
				var treeObj = $.fn.zTree.getZTreeObj(treename);
				if(treeObj!=undefined){
					var allnodes=treeObj.getNodes();
					var total=allnodes.length;
					var treenode=treeObj.getSelectedNodes();
					var arraylist=new Array();
					for(var i = 0; i < rowdata.length; i++, total++){
					if(volrow.volid!=undefined){
					var volentryrow = {
								volid:volrow.volid,
								objid : rowdata[i].docid,
								objname : rowdata[i].docname,
								name:rowdata[i].docname,
								type : 'doc',
								rank : total+1
							};
						arraylist.push(volentryrow);
					}
					else{
					var volentryrow = {
								objid : rowdata[i].docid,
								objname : rowdata[i].docname,
								name:rowdata[i].docname,
								type : 'doc',
								rank : total+1
							};
						arraylist.push(volentryrow);
					}
					}
					if(treenode!=null&&treenode!=undefined&&treenode.length>0){
					if(treenode.type!="doc"&&treenode.type!="biography"&&treenode.type!="relation"){
					var addnode=treeObj.addNodes(treenode[0], arraylist);
					}
					else{
					var addnode=treeObj.addNodes(null, arraylist);
					}
					}
					else{
					if(treeObj==null){
							console.log($(treename));
						var tmp = $.fn.zTree.init($("#"+treename), setting,arraylist);
						}
						else{
							var addnode=treeObj.addNodes(null, arraylist);
							//var addnode=treeObj.addNodes(null, newNode);
						}
					}
				}
				else{
					volDG.datagrid('collapseRow',volindex);
					treeObj = $.fn.zTree.getZTreeObj(treename);
						var arraylist=new Array();
						var total=0;
						if(treeObj!=null){
						var treenode=treeObj.getSelectedNodes();
						var allnodes=treeObj.getNodes();
						total=allnodes.length;
						}
						for(var i = 0; i < rowdata.length; i++, total++){
						if(volrow.volid!=undefined){
							var volentryrow = {
									volid:volrow.volid,
									objid : rowdata[i].docid,
									objname : rowdata[i].docname,
									name:rowdata[i].docname,
									type : 'doc',
									rank : total+1
								};
							arraylist.push(volentryrow);
							}
							else{
							var volentryrow = {
									objid : rowdata[i].docid,
									objname : rowdata[i].docname,
									name:rowdata[i].docname,
									type : 'doc',
									rank : total+1
								};
							arraylist.push(volentryrow);
							}
						}
						if(treenode!=null&&treenode!=undefined){
							if(treenode.type!="doc"&&treenode.type!="biography"&&treenode.type!="relation"){
					var addnode=treeObj.addNodes(treenode[0], arraylist);
					}
					else{
					var addnode=treeObj.addNodes(null, arraylist);
					}
						}
						else{
							if(treeObj==null){
							//console.log($(treename));
						var tmp = $.fn.zTree.init($("#"+treename), setting,arraylist);
						}
						else{
							var addnode=treeObj.addNodes(null, arraylist);
							//var addnode=treeObj.addNodes(null, newNode);
						}
						}
				}
				$('#usersdoc_datagrid').datagrid('uncheckAll');
				volDG.datagrid('fixDetailRowHeight',volindex);
				volDG.datagrid('expandRow', volindex);//选中新增行
		}
		else{
			alert("请选择一个分卷！");
		}
	}
	else{
		alert("请选择要加入分卷的文档！");
	}
}

/**给一个分卷增加吊线行传*/
function addGroupsToVolume(){
	var volDG = $('#volumelist_datagrid');//分卷列表
	var volrow = volDG.datagrid('getSelected');
	var rowdata = $('#grouplist_datagrid').datagrid('getSelections');//吊线或者行传列表
	var volindex = volDG.datagrid('getRowIndex', volrow);
	if(rowdata!=null&&rowdata.length>0){
		if(volrow!=null&&volrow!=undefined){
				var treename="tree"+volrow.rank;
				var treeObj = $.fn.zTree.getZTreeObj(treename);
				if(treeObj!=undefined){
					var allnodes=treeObj.getNodes();
					var total=allnodes.length;
					var type;
					var treenode=treeObj.getSelectedNodes();
					var arraylist=new Array();
					for(var i = 0; i < rowdata.length; i++, total++){
						if(rowdata[i].type=="biography"){
							type="行传";
						}
						else{
							type="吊线";
						}
						if(volrow.volid!=undefined){
						var volentryrow = {
								volid:volrow.volid,
								objid : rowdata[i].grpid,
								objname : rowdata[i].grpname,
								type : rowdata[i].type,
								name:rowdata[i].grpname+type,
								rank : total+1
							};
						arraylist.push(volentryrow);
						}
						else{
						var volentryrow = {
								objid : rowdata[i].grpid,
								objname : rowdata[i].grpname,
								type : rowdata[i].type,
								name:rowdata[i].grpname+type,
								rank : total+1
							};
						arraylist.push(volentryrow);
						}
					}
					if(treenode!=null&&treenode!=undefined&&treenode.length>0){
						if(treenode.type!="doc"&&treenode.type!="biography"&&treenode.type!="relation"){
					var addnode=treeObj.addNodes(treenode[0], arraylist);
					}
					else{
					var addnode=treeObj.addNodes(null, arraylist);
					}
					}
					else{
						alert("请选择一个章节！");
					}
				}
				else{
					volDG.datagrid('collapseRow',volindex);
					treeObj = $.fn.zTree.getZTreeObj(treename);
						var arraylist=new Array();
						var total=0;
						if(treeObj!=undefined){
						var treenode=treeObj.getSelectedNodes();
						var allnodes=treeObj.getNodes();
						total=allnodes.length;
						}
						for(var i = 0; i < rowdata.length; i++, total++){
							if(rowdata[i].type=="biography"){
								type="行传";
							}
							else{
								type="吊线";
							}
							if(volrow.volid!=undefined){
							var volentryrow = {
									volid:volrow.volid,
									objid : rowdata[i].grpid,
									objname : rowdata[i].grpname,
									type : rowdata[i].type,
									name:rowdata[i].grpname+type,
									rank : total+1
								};
							arraylist.push(volentryrow);
							}
							else{
							var volentryrow = {
									objid : rowdata[i].grpid,
									objname : rowdata[i].grpname,
									type : rowdata[i].type,
									name:rowdata[i].grpname+type,
									rank : total+1
								};
							arraylist.push(volentryrow);
							}
						}
						if(treenode!=null&&treenode!=undefined){
							if(treenode.type!="doc"&&treenode.type!="biography"&&treenode.type!="relation"){
					var addnode=treeObj.addNodes(treenode[0], arraylist);
					}
					else{
					var addnode=treeObj.addNodes(null, arraylist);
					}
						}
						else{
						if(treeObj==null){
							var tmp = $.fn.zTree.init($("#"+treename), setting,arraylist);
						}
						else{
							var addnode=treeObj.addNodes(null, arraylist);
							//var addnode=treeObj.addNodes(null, newNode);
						}
						}
				}
				$('#usersdoc_datagrid').datagrid('uncheckAll');
				volDG.datagrid('fixDetailRowHeight',volindex);
				volDG.datagrid('expandRow', volindex);//选中新增行
		}
		else{
			alert("请选择一个分卷！");
		}
	}
	else{
		alert("请选择要加入分卷的吊线或者行传！");
	}
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
			var treename="tree"+delRow.rank;
			$.fn.zTree.destroy(treename);
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
					var treename="tree"+delRow.rank;
					$.fn.zTree.destroy(treename);
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
	if(volrow!=null&&volrow!=undefined){
		var volindex = volDG.datagrid('getRowIndex', volrow);
		var treename="tree"+volrow.rank;
		var treeObj = $.fn.zTree.getZTreeObj(treename);
		if(treeObj!=undefined){
			var treenode=treeObj.transformToArray(treeObj.getNodes());
			for(var i=0;i<treenode.length;i++){
				if(treenode[i].getParentNode()!=null&&treenode[i].getParentNode()!=undefined){
					treenode[i].fatherrank=treenode[i].getParentNode().rank;
				}
			}
			var nodes= JSON.stringify(treenode); 
			var volid = volrow.volid;
			var volname = volrow.volname;
			var pediId = $('#selectpedigree').combobox('getValue');//volrow.pid;//族谱id
			if(treenode!=undefined&&treenode!=null&&treenode.length>0){		
				$.ajax({
					async : false,
					cache : false,
					type : 'post',
					data : 'nodes='+nodes+ '&volid='
					+ volid + '&volname=' + volname + '&pediId=' + pediId,
					url : '${pageContext.request.contextPath}/pediVolumeAction!saveVolumeTree.action',//请求的action路径  
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
		else{
			volDG.datagrid('collapseRow',volindex);
			treeObj = $.fn.zTree.getZTreeObj(treename);
			if(treeObj!=undefined){
				
			}
			else{
				alert("该分卷没有内容！");
			}
		}
	}else{
		alert("请选择一个分卷！");
	}
	
	
	
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
var volDG = $('#volumelist_datagrid');	
		var volrow = volDG.datagrid('getSelected');
		if(volrow!=null&&volrow!=undefined){
	$('#addcontent-dialog').dialog('open');}
	else{
	alert("请先选中一个分卷！");
	}
}
function closeaddcontentdialog(){
	$('#contentname').val("");
	$('#contenttype').val("");
	$('#addcontent-dialog').dialog('close');
}
function checkaddcontent(){
	var contentname=$('#contentname').val();
	var contenttype=$('#contenttype').val();
	var titletype=$('#titletype').val();
	var group1=$('input[name*="islone"]').filter(":checked");
	var islone=group1.attr("id");
	if(contentname==""){
		alert("请填写章节名字！");
		return false;
	}
	else{
		if(contenttype==""){
			alert("请选择章节类型！");
			return false;
		}
		else if(contenttype=="0"){
			if(titletype=="0"){
				alert("请为扉页章节选择扉页类型！");
				return false;
			}
			else{
				if(islone==""){
					alert("请选择章节是否为独立章节！");
					return false;
				}
				else{
					return true;
				}
			}
		}
		else{
			if(islone==""){
				alert("请选择章节是否为独立章节！");
				return false;
			}
			else{
				return true;
			}
		}
	}
}
/**
 * 用于章节树中增加章节
 */
function addcontent(){
	if(checkaddcontent()){
		var volDG = $('#volumelist_datagrid');	
		var volrow = volDG.datagrid('getSelected');
		var contentname=$('#contentname').val();
		var contenttype=$('#contenttype').val();
		var titletype=$('#titletype').val();
		var objid=-titletype;
		var group1=$('input[name*="islone"]').filter(":checked");
		var islone=group1.attr("id");
		var type;
		if(contenttype=='0'){
			type='contentd';
		}
		else{type='contentt';}
		if(volrow!=null&&volrow!=undefined){
			var volindex = volDG.datagrid('getRowIndex', volrow);
			var treename="tree"+volrow.rank;
			var treeObj = $.fn.zTree.getZTreeObj(treename);
			if(treeObj!=undefined){
				var allnodes=treeObj.getNodes();
				var total=allnodes.length;
				var treenode=treeObj.getSelectedNodes();
				var newNode={objid : objid,objname : contentname,type:type,name:contentname,rank:total+1};
				if(volrow.volid!=undefined){
				newNode.volid=volrow.volid;
				}
				//var newNode={};
				//newNode.name=contentname;
				//newNode.nodedetail=newNodedetail;
				if(treenode!=null&&treenode!=undefined&&treenode.length>0){
					if(islone=="islone1"){
						var addnode=treeObj.addNodes(null, newNode);
						treeObj.selectNode(addnode[0]);
					}else{
						//newNode.type=newNode.type+"s";
						var addnode=treeObj.addNodes(treenode[0], newNode);
						treeObj.selectNode(addnode[0]);
					}
				}
				else{
					var addnode=treeObj.addNodes(null, newNode);
					treeObj.selectNode(addnode[0]);
				}
				
			}
			else{
				volDG.datagrid('collapseRow',volindex);
				treeObj = $.fn.zTree.getZTreeObj(treename);
				if(treeObj!=undefined){
					var treenode=treeObj.getSelectedNodes();
					var newNode={objid : objid,objname : contentname,name:contentname,type:type,rank:total+1};
					if(volrow.volid!=undefined){
					newNode.volid=volrow.volid;
					}
					//var newNode={};
					//newNode.name=contentname;
					//newNode.nodedetail=newNodedetail;
					if(treenode!=null&&treenode!=undefined){
						if(islone=="islone1"){
							var addnode=treeObj.addNodes(null, newNode);
							treeObj.selectNode(addnode);
						}else{
							//newNode.type=newNode.type+"s";
							var addnode=treeObj.addNodes(treenode[0], newNode);
							treeObj.selectNode(addnode);
						}
					}
					else{
						var addnode=treeObj.addNodes(null, newNode);
						treeObj.selectNode(addnode);
					}
				}
				else{
				}
			}
		}
		else{
			alert("请选择一个分卷！");
		}
		closeaddcontentdialog();
	}
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
$('#usersdoc_datagrid').datagrid('loadData',[]);
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
					$('#usersdoc_datagrid').datagrid('checkAll');
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
/**选择类型重新载入文档*/
function reloadthedocbystyle(record){
	$('#usersdoc_datagrid').datagrid('loadData',[]);
	var gid=$('#selectpedigree').combobox('getValue');
	if(gid!=""){
		var opts = $('#usersdoc_datagrid').datagrid("options");
		opts.url="";
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'styid='+record.pid+'&gid='+gid,
			url : '<%=path%>/genealogyAction!reloadthedocbystyle.action',//请求的action路径  
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
					$('#usersdoc_datagrid').datagrid('checkAll');
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
function changetheimg(v){
	if(v!=0){
		$("#pdfimgregion").html();
		var str="<img alt='' style='display:block;width:100%;height:100%' src='../pdffile/"+v+".jpg'>";
		$("#pdfimgregion").html(str);
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
							<div id="voltoolbar" style="padding:3px;height:auto">
								<div style="margin-bottom:5px">
									<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										id="addVolume" onclick="addVolume()">新建卷</a>
									<a class="easyui-linkbutton" iconCls="icon-remove" plain="true"
										id="delVolume" onclick="deleteVolume()">删除</a>
									<a class="easyui-linkbutton" iconCls="icon-save" plain="true"
										id="saveVolume" onclick="saveVolume()">保存</a>
									<a class="easyui-linkbutton" iconCls="icon-edit" plain="true"
										onclick="editVolname()">编辑卷名</a>
										<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
										onclick="openaddcontentdialog()">新建章节</a>
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
									data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#addcontent-dlg-buttons'" title="输入章节信息"
									style="width:450px;height:270px;padding:10px">
									<div class="easyui-layout" data-options="fit:true">
									<div data-options="region:'west'" style="width:250px">
									<div  style="margin-top:15px">
									<label for="contentname">章节名称：</label><input id="contentname" class="easyui-validatebox" style="width:156px"></input> 
									</div>
									<div  style="margin-top:15px">
									<label for="contenttype">章节类型：</label><select id="contenttype" name="contenttype">
									<option value ="0">在卷中独立扉页来显示</option>
									<option value ="1">在卷中作为标题来显示</option>
									</select>
									</div>
									<div style="margin-top:15px">
									<label for="titletype">扉页类型：</label><select id="titletype" name="titletype" style="width:60px" onchange="changetheimg(this.value)">
									<option value ="0" checked="checked">0</option>
									<option value ="1" checked="checked">1</option>
									<option value ="2">2</option>
									<option value ="3">3</option>
									<option value ="4">4</option>
									<option value ="5">5</option>
									<option value ="6">6</option>
									<option value ="7">7</option>
									<option value ="8">8</option>
									<option value ="9">9</option>
									</select>
									</div>
									<div style="margin-top:15px">
									<input type="radio" style="vertical-align:middle" id="islone1" name="islone" value="0" checked="checked" />独立章节
									<input type="radio" style="vertical-align:middle" id="islone2" name="islone" value="1" />子章节
									</div>
									</div>
									<div data-options="region:'center'" id="pdfimgregion">
									<img alt='' style='display:block;width:100%;height:100%' src=''>
									</div>
								</div>
									<div id="addcontent-dlg-buttons">
										<a href="javascript:void(0)" class="easyui-linkbutton" id="confirmcontent" onclick="addcontent()">确定</a>
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
								style="height:80px">
								<div style="margin-top:10px">								
								<label for="selectrule">文档排序规则：</label> <select
									id="selectrule" name="selectrule" style="width:100px"></select>
								</div>
								<div style="margin-top:10px">								
								<label for="selectbystyle">文档类型筛选：</label> <select
									id="selectbystyle" name="selectbystyle" style="width:100px"></select>
								</div>
								</div>
							<div data-options="region:'center'" style="height:500px">
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
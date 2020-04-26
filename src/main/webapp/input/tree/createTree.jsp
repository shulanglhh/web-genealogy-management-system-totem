<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); 
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script>
var isdrag=0;
var initTreeAction = '<%=path %>/tRelationAction!initTree.action'; 
var getTreeAction = '<%=path %>/tRelationAction!getPersonTree.action';
var getIndividualAction = '<%=path %>/tRelationAction!fetchIndividualById.action';
var deleteAction = '<%=path %>/tRelationAction!deletePersonTree.action';
var seprateAction='<%=path %>/tRelationAction!sepratePersonTree.action';
var changeRelationAction = '<%=path %>/tRelationAction!changeRelation.action';
var showNewShuAction = '<%=path %>/tIndividualAction!showNewSuShiStyle.action';
var getPhotoUrlAction = '<%=path %>/tIndividualAction!getPhotoUrl.action';
var wifeRank = new Array('', '继', '三', '四', '五', '六', '七', '八', '九', '十', 
		'十一', '十二', '十三', '十四', '十五', '十六', '十七', '十八', '十九', '二十');
var childrenNum = new Array('一', '二', '三', '四', '五', '六', '七', '八', '九', '十', 
		'十一', '十二', '十三', '十四', '十五', '十六', '十七', '十八', '十九', '二十');
var maniconpath = 'man.png';
var womaniconpath = 'woman.png';

//删除。
function removeNode(treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	zTree.selectNode(treeNode);
	if(confirm("确认删除 以人物 " + treeNode.name + "为首的该支吗？")){
		var deleteDone=false;
		if(typeof treeNode.id == 'undefined' || treeNode.id < 0){
			return true;
		}
		$.ajax({
			type:'POST',
			url:deleteAction,
			async:false,
			data:'treeid='+treeNode.id,
			success:function(r){
				rObj = eval('(' + r + ')');
				if(rObj.success){
					deleteDone = true;
					$.messager.show({
						title : '提示',
						msg : rObj.msg					
					});
				}
				else 
					deleteDone = false;
			}
		});
		
		return deleteDone;//if(deleteDone)return true;else return false;
	}
	else
		return false;
};
//让该人物从树中分离
function separateout(treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	zTree.selectNode(treeNode);
		var deleteDone;
		if(typeof treeNode.id == 'undefined' || treeNode.id < 0){
			return true;
		}
		$.ajax({
			type:'POST',
			url:seprateAction,
			async:false,
			data:'pid='+treeNode.id,
			success:function(r){
				rObj = eval('(' + r + ')');
				if(rObj.success){
					deleteDone = true;
					$.messager.show({
						title : '提示',
						msg : rObj.msg					
					});
					zTree.moveNode(null, treeNode, "inner");
					clickNodezwj( treeId, treeNode);
				}
				else 
					$.messager.alert("警告","分离失败，请重试！","warning");
			}
		});
		
		return deleteDone;//if(deleteDone)return true;else return false;
};
//右键
function rightClick(event, treeId, treeNode) {
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	// 判断点击了tree的“空白”部分，即没有点击到tree节点上
	if (!treeNode && event.target.tagName.toLowerCase() != "button"
			&& $(event.target).parents("a").length == 0) {
		zTree.cancelSelectedNode();
		// 只显示添加菜单项，这个只是外观上的控制，不能控制到点击事件！菜单项的点击事件还要额外判断！
		$('#onekeyexpand').attr('disabled', '');
		$('#hook').attr('disabled', true);
		$('#hookmother').attr('disabled', true);
		$('#changerank').attr('disabled', true);
		$('#refreshtree').attr('disabled', true);
		$('#changeggen').attr('disabled', true);
		$('#Timport').attr('disabled', true);
		$('#Texport').attr('disabled', true);
		$('#removemenu').attr('disabled', true);
		$('#separateout').attr('disabled', true);
	} else if (treeNode) {//// && !treeNode.noR // 判断点击的是tree节点，treeNode.noR为true为禁止右键菜单。
		zTree.selectNode(treeNode); // 选中tree节点
		$('#onekeyexpand').attr('disabled', false);
		$('#hook').attr('disabled', false);
		$('#hookmother').attr('disabled', false);
		$('#changerank').attr('disabled', false);
		$('#refreshtree').attr('disabled', false);
		$('#changeggen').attr('disabled', false);
		$('#Timport').attr('disabled', false);
		$('#Texport').attr('disabled', false);
		$('#removemenu').attr('disabled', false);
		$('#separateout').attr('disabled', false);
		// 在ztree右击事件中注册easyui菜单的显示和点击事件，让这两个框架实现共用event，这个是整合的关键点
		$('#mm').menu(
				{
					onClick : function(item) {
						if (item.name == 'onekeyex'
								&& !$('#onekeyexpand').attr('disabled')) {// 这里是一键展开的接口
							zTree.expandAll(true);
							// alert("一键展开");						
						}else if (item.name == 'hook'
								&& !$('#hook').attr('disabled')) {						
							$('#hook-tree-dialog').dialog('open');						
							//$('#hook-person').datagrid('deleteRow', 0);
							var row = new Array();
							row[0] = evalObject(treeNode.nodeDetailInfo);//eval('(' + treeNode.nodeDetailInfo + ')');
							var dataRow = {total:1, rows:row };
							$('label[name="hooktype"]').html($('input[name="hooktype"]:checked').next('span').text());
							if(treeNode.nodeDetailInfo==null
									||typeof treeNode.nodeDetailInfo == 'undefined'
									||treeNode.nodeDetailInfo==''){		
								$('#hook-person').datagrid('deleteRow', 0);
								$('label[name="person1"]').html('');							
								return;
							}
							$('#hook-person').datagrid('loadData',dataRow);
							$('label[name="person1"]').html('<strong>'+treeNode.name+'</strong>');
							
							//alert(JSON.stringify(dataRow));
							
						}else if (item.name == 'hookmother'
								&& !$('#hookmother').attr('disabled')) {// 挂接母亲
							$('#choosemother').combobox('clear');
							$("#treeid").attr("value", treeNode.id);
							var husband = treeNode.getParentNode().id;
							$('#choose-mother-dialog').dialog('open');
							$.ajax({
								async : false,
								cache : false,
								type : 'post',
								data : 'husband=' + husband,
								url : '${pageContext.request.contextPath}/genealogyAction!choosethemother.action',//请求的action路径  
								error : function() {//请求失败处理函数  
									alert('母亲列表失败，请检查网络');
								},
								success : function(j){ 
									var rObj = jQuery.parseJSON(j);
									if (rObj.success) {
										$('#choosemother').combobox('loadData', rObj.obj);//异步加载父亲的所有配偶
										//若有母亲，设置combobox显示其母亲
										if(treeNode.nodeRelInfo.motherPid>0){
											$('#choosemother').combobox('setValue',treeNode.nodeRelInfo.motherPid);
										}
									} 
								}
							});												
						}
						else if (item.name == 'changerank'
								&& !$('#changerank').attr('disabled')) {
							$('#nodename').html(treeNode.name + ' 的排行数更改为:');
							$("#treeid").attr("value", treeNode.id);
							var nodeDetailInfotmp=treeNode.nodeDetailInfo;
							if(nodeDetailInfotmp.arrangenum==undefined){
								nodeDetailInfotmp=jQuery.parseJSON(treeNode.nodeDetailInfo);
							}
							$('#noderank').val(nodeDetailInfotmp.arrangenum);//打开录入框应当显示其当前的排行数
							$('#change-rank-dialog').dialog('open');
						} else if (item.name == 'refreshtree'
								&& !$('#refreshtree').attr('disabled')) {
							zTree.reAsyncChildNodes(treeNode, "refresh");
							//alert("刷新树");							
						} else if (item.name == 'changeggen'
								&& !$('#changeggen').attr('disabled')) {
							var tmp=treeNode.nodeDetailInfo;
							if(treeNode.nodeDetailInfo.ggen==undefined){
								nodeDetailInfotmp=jQuery.parseJSON(treeNode.nodeDetailInfo);
								if(nodeDetailInfotmp.ggen==undefined){
									alert("配偶不能更改世代！");
									return;
								}
							}
							$('#ggen-nodename').html(treeNode.name + ' 的世代数更改为:');
							$("#treeid").attr("value", treeNode.id);
							$('#nodeggen').val('');
							$('#change-ggen-dialog').dialog('open');
						}else if (item.name == 'Timport'
								&& !$('#Timport').attr('disabled')) {
							//add by zwj
							importPersonbyd();
							//end add by zwj
							//alert("导入");
						} else if (item.name == 'Texport'
								&& !$('#Texport').attr('disabled')) {
							ExportData();
							
						}else if(item.name =='removemenu'&& !$('#removemenu').attr('disabled')){
							var issuccess=removeNode(treeId, treeNode);
							if(issuccess){
								zTree.removeNode(treeNode);
							}
						}else if(item.name =='separateout'&& !$('#separateout').attr('disabled')){
							separateout(treeId,treeNode);
						}
					}
				});
		$('#mm').menu('show', {
			left : event.pageX,
			top : event.pageY
		});
	}
	
}
//点击节点：填充表单，显示模板，若在常规录入模式下要加载图片
function clickNode(event, treeId, treeNode) { 	
	var treeObj = $.fn.zTree.getZTreeObj(treeId);
	treeObj.expandNode(treeNode, true, false,true);
	//alert(treeId);
	var selectedNode = treeNode;//treeObj.getNodeByParam('id', treeId, null);//treeObj.getSelectedNodes()[0];
	var treeNodeId = (selectedNode.id);	
	$('#mother-name').text('');
	$("#treeid").attr("value", treeNodeId);//设置隐藏表单treeNodeId，用于给后台传值
	if(treeNodeId < 0){
		$('#hotkey-individual-form')[0].reset();
		return false;
	}
	var nodeInfo = evalObject(selectedNode.nodeDetailInfo);
	var nodeRelInfo = evalObject(selectedNode.nodeRelInfo);

	if (nodeInfo != null) {		
		fillForm(nodeInfo);
		setRelInfo(nodeRelInfo);//保存于树节点中的关联信息       
		setTemplateContent(nodeInfo, nodeRelInfo);
	}
	//add by zwj
	var tmp=$('#data-input-table input[name=surname]').val();
	$('#data-input-table input[name=surname]').val("").focus().val(tmp);//每次初始化人物树的时候要定位到录入表单中的第一个元素。
	//end
	var motherId = nodeRelInfo.motherPid;
	if(motherId > 0){
		var mothernode = treeObj.getNodeByParam("id", motherId, null);
		var motherName=nodeRelInfo.motherName;
		var a ='女';
		if(mothernode!=undefined&&mothernode!=null){
			motherName=mothernode.name;
			//var index=motherName.indexOf("("); 
			//motherName=motherName.substring(0,index);
			a=mothernode.sex;
		}
		var showtitle = a=='女' ? '母亲：' : '父亲 ：';
		$('#mother-name').text(showtitle+motherName);
	}	
	else{		
		$('#mother-name').text('母亲不详');
	}
	if(nodeInfo.arrangenum==undefined){
		$('#arrange-num').text('家中排行：未指定');
	}else
		$('#arrange-num').text('家中排行：' + nodeInfo.arrangenum);

	var sizi = '', tiaozi = '';
	if(nodeRelInfo.relType == '入继'){
		sizi = nodeRelInfo.fatherName + '嗣子 ';
	}
	if(nodeRelInfo.relType == '出祧'){
		//tiaozi = nodeRelInfo.fatherName + '祧子 ';
		tiaozi = nodeRelInfo.fatherinlawid + '祧子 ';
	}
	var info=sizi + tiaozi + nodeRelInfo.hasSpecialRelDesc;
	if(info.indexOf("配偶")>0)
	   {
	     var repalce=info.substr(2,5);
	   }
	info=info.replace(repalce,"");
	$('#special-rel-desc').text(info);
	var appenstr="";
	if(nodeInfo.remark!=null){
		appenstr+=nodeInfo.remark;
	}
	if(nodeInfo.endnote!=null){
		appenstr+=nodeInfo.endnote;
	}
	var htmlzwj="<p class='intro'>"+appenstr+"</p>";
	if(appenstr!=""){
		$("#rt_content").append(htmlzwj);
	}
	$("input[name='curpid']").attr("value", treeNodeId);//防止被setNodeData中的prevRelInfo设置为0了
	//是否加载图片的代码段
	var tab = $('#input-tabs').tabs('getSelected');
	var index = $('#input-tabs').tabs('getTabIndex',tab);//常规录入的Index为1	
	if(index==1){
		loadPersonPhoto();
	}
};
function clickNodezwj( treeId, treeNode) { 	
	var treeObj = $.fn.zTree.getZTreeObj(treeId);
	treeObj.expandNode(treeNode, true, false,true);
	treeObj.selectNode(treeNode);
	//alert(treeId);
	var selectedNode = treeNode;//treeObj.getNodeByParam('id', treeId, null);//treeObj.getSelectedNodes()[0];
	var treeNodeId = (selectedNode.id);	
	$('#mother-name').text('');
	$("#treeid").attr("value", treeNodeId);//设置隐藏表单treeNodeId，用于给后台传值
	if(treeNodeId < 0){
		$('#hotkey-individual-form')[0].reset();
		return false;
	}
	var nodeInfo = evalObject(selectedNode.nodeDetailInfo);
	var nodeRelInfo = evalObject(selectedNode.nodeRelInfo);

	if (nodeInfo != null) {		
		fillForm(nodeInfo);
		setRelInfo(nodeRelInfo);//保存于树节点中的关联信息       
		setTemplateContent(nodeInfo, nodeRelInfo);
	}
	//add by zwj
	var tmp=$('#data-input-table input[name=surname]').val();
	$('#data-input-table input[name=surname]').val("").focus().val(tmp);//每次初始化人物树的时候要定位到录入表单中的第一个元素。
	//end
	var motherId = nodeRelInfo.motherPid;
	if(motherId > 0){
		var mothernode = treeObj.getNodeByParam("id", motherId, null);
		var motherName=nodeRelInfo.motherName;
		var a ='女';
		if(mothernode!=undefined&&mothernode!=null){
			motherName=mothernode.name;
			//var index=motherName.indexOf("("); 
			//motherName=motherName.substring(0,index);
			a=mothernode.sex;
		}
		var showtitle = a=='女' ? '母亲：' : '父亲 ：';
		$('#mother-name').text(showtitle+motherName);
	}	
	else{		
		$('#mother-name').text('母亲不详');
	}
	if(nodeInfo.arrangenum==undefined){
		$('#arrange-num').text('家中排行：未指定');
	}else
		$('#arrange-num').text('家中排行：' + nodeInfo.arrangenum);

	var sizi = '', tiaozi = '';
	if(nodeRelInfo.relType == '入继'){
		sizi = nodeRelInfo.fatherName + '嗣子 ';
	}
	if(nodeRelInfo.relType == '出祧'){
		//tiaozi = nodeRelInfo.fatherName + '祧子 ';
		tiaozi = nodeRelInfo.fatherinlawid + '祧子 ';
	}
	$('#special-rel-desc').text(sizi + tiaozi + nodeRelInfo.hasSpecialRelDesc);
	var appenstr="";
	if(nodeInfo.remark!=null){
		appenstr+=nodeInfo.remark;
	}
	if(nodeInfo.endnote!=null){
		appenstr+=nodeInfo.endnote;
	}
	var htmlzwj="<p class='intro'>"+appenstr+"</p>";
	if(appenstr!=""){
		$("#rt_content").append(htmlzwj);
	}
	$("input[name='curpid']").attr("value", treeNodeId);//防止被setNodeData中的prevRelInfo设置为0了
	//是否加载图片的代码段
	var tab = $('#input-tabs').tabs('getSelected');
	var index = $('#input-tabs').tabs('getTabIndex',tab);//常规录入的Index为1	
	if(index==1){
		loadPersonPhoto();
	}
};
function addtheemplatezwj(){
	if(motherId > 0){
		var mothernode = treeObj.getNodeByParam("id", motherId, null);
		var motherName=nodeRelInfo.motherName;
		var a ='女';
		if(mothernode!=undefined&&mothernode!=null){
			motherName=mothernode.name;
			//var index=motherName.indexOf("("); 
			//motherName=motherName.substring(0,index);
			a=mothernode.sex;
		}
		var showtitle = a=='女' ? '母亲：' : '父亲 ：';
		$('#mother-name').text(showtitle+motherName);
	}	
	else{		
		$('#mother-name').text('母亲不详');
	}
	if(nodeInfo.arrangenum==undefined){
		$('#arrange-num').text('家中排行：未指定');
	}else
		$('#arrange-num').text('家中排行：' + nodeInfo.arrangenum);

	var sizi = '', tiaozi = '';
	if(nodeRelInfo.relType == '入继'){
		sizi = nodeRelInfo.fatherName + '嗣子 ';
	}
	if(nodeRelInfo.relType == '出祧'){
		tiaozi = nodeRelInfo.fatherinlawid + '祧子 ';
		//tiaozi = nodeRelInfo.fatherName + '祧子 ';
	}
	$('#special-rel-desc').text(sizi + tiaozi + nodeRelInfo.hasSpecialRelDesc);
	var appenstr="";
	if(nodeInfo.remark!=null){
		appenstr+=nodeInfo.remark;
	}
	if(nodeInfo.endnote!=null){
		appenstr+=nodeInfo.endnote;
	}
	var htmlzwj="<p class='intro'>"+appenstr+"</p>";
	if(appenstr!=""){
		$("#rt_content").append(htmlzwj);
	}
}
/**
 * 加载人物的照片
 */
function loadPersonPhoto(){
	$.post(getPhotoUrlAction, {treeid: $("#treeid").attr("value")}, function(data){				
		var rObj = eval('('+data+')');
		var url = '${pageContext.request.contextPath}/images/qq.jpg';
		if(rObj.obj != null && typeof rObj.obj != 'undefined' && rObj.obj != ''){
			url = '${pageContext.request.contextPath}/photo/'+rObj.obj;
		}
		
		$('#person-photo').attr('src',url);
		//$('#img-edit').attr('src', url);
		$('#img-small').attr('src', url);
		jcrop_api.setImage(url);//jcrop_api定义在imgEdit1.jsp中
		jcrop_api.release();
	});
	//$('#person-photo').attr('src','/pedigree/images/man.png');
}

function dragNode(treeId, treeNodes, targetNode){
	var myId = treeNodes[0].id;
	var parentId = targetNode.id;
	var ggensource=treeNodes[0].nodeDetailInfo.ggen;
	var ggentarget=targetNode.nodeDetailInfo.ggen;
	if(treeNodes[0].nodeRelInfo.isAlien){
		if(confirm("确认将  " + treeNodes[0].name + "  挂接为  " + targetNode.name + "  配偶吗  ")){		
			var isChanged = false; 
			$.ajax({
				async : false, 
				type : "POST",
				url : changeRelationAction, 			
				data : 'sourceId=' + myId + '&targetId=' + parentId + '&relType=9',
				success : function(r){
					var rObj = eval('(' + r + ')');
					if(rObj.success){
						isChanged = true;
						return true;
					}else{
						$.messager.show({
							title : '提示',
							msg : '节点不合法，无法拖拽！'		
						});
					};
				}
			});
			return isChanged == true ? true : false;
		}
	}
	if(typeof myId == 'undefined' 
		|| myId <= 0 			
		|| typeof parentId == 'undefined' 
		|| parentId <= 0||ggensource!=ggentarget+1){
		$.messager.show({
			title : '提示',
			msg : '节点不合法，无法拖拽！'		
		});
		return false;
	}
	if(treeNodes[0].getParentNode()!=null&&parentId == treeNodes[0].getParentNode().id){
		$.messager.show({
			title : '提示',
			msg : '节点不合法，无法拖拽！'		
		});
		return false;
	}
	//console.info("id:"+ myId + parentId);
	if(confirm("确认将  " + treeNodes[0].name + "  挂接为  " + targetNode.name + "  孩子吗  ")){		
		var isChanged = false; 
		$.ajax({
			async : false, 
			type : "POST",
			url : changeRelationAction, 			
			data : 'sourceId=' + myId + '&targetId=' + parentId + '&relType=5',
			success : function(r){
				var rObj = eval('(' + r + ')');
				if(rObj.success){
					isChanged = true;
					return true;
				}else{
					$.messager.show({
						title : '提示',
						msg : '节点不合法，无法拖拽！'		
					});
				};
			}
		});
		return isChanged == true ? true : false;
	}
	return false;
}


//定义zTree的具体参数。
var setting = {
	async : {
		enable : true,
		type : "post",
		url : getTreeAction,
		autoParam : [ "id", "name" ],
		otherParam:["depth",inputSetting.maxDepth, "inputperson", <%=session.getAttribute("userid") %>]//inputsetting在individualTree.jsp中
	},
	view : {
		selectedMulti : false //禁止多点选中  	
	},
	data : {
		simpleData : {
			enable : true,
			idKey : "id",
			pIdKey : "parentId",
			rootPId : ""
		},
		keep: {
			parent: true
		}
	},
	edit : {
		enable : false,
		editNameSelectAll : true,
		removeTitle : "删除人物",
		showRemoveBtn : true,
		showRenameBtn : false,
	},
	callback : {
		onClick : clickNode,	
		beforeRemove: removeNode,
		onRightClick : rightClick,
		beforeDrop : dragNode,
		onDrop: zTreeOnDrop,
		onAsyncSuccess: zTreeOnAsyncSuccess
	}
};
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	$.messager.progress("close");
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	treeObj.expandAll(true);
    if(issearch){
    	var nodes =  treeObj.getNodeByParam("id", lastpid, null);
    	if(nodes!=null){	
    		zwj_filltheform(treeObj,nodes);
    		treeObj.selectNode(nodes);	
    		//需要加滑动条的动作让其移动使得node节点到div的中间add by zwj
    		var westtree=parent.document.getElementById('westtree');
    		
    		var westtreej=$(westtree);
    		//treeObj.cancelSelectedNode();
    		treeObj.selectNode(nodes);
    		var oldx = westtreej.offset().top; 
    		//console.log(oldx);
    		var oldy = westtreej.offset().left; 
    		//console.log(oldy);
    		var nodeid=nodes.tId;
    		var nodej=$("#"+nodeid);
    		var newx = nodej.offset().top; 
    		//console.log(newx);
    		var newy = nodej.offset().left; 
    		westtreej.scrollTop(0);
    		westtreej.scrollLeft(0);
    		var topnew=newx-oldx+oldx/2;
			var leftnew=(newy-oldy)+oldy/2;
    		//console.log(newy);
    		if(newx>oldx){
    			westtree.scrollTop=topnew;
    			westtreej[0].scrollTop=topnew;
    		}
    		if(newy>oldy){
    			westtree.scrollLeft=leftnew;
    			westtreej[0].scrollLeft=leftnew;
    		}
    		 var cc=document.getElementById(nodeid);
 		    cc.scrollIntoView();
    		// add end
    			$.messager.show({
					title : '提示',
					msg : '成功搜索到结果！'					
				});
    }
    	issearch=false;
    }
    if(isguajie){
    	var nodes =  treeObj.getNodeByParam("id", lastpid, null);
    	if(nodes!=null){	
    		zwj_filltheform(treeObj,nodes);
    		treeObj.selectNode(nodes);	
    		//需要加滑动条的动作让其移动使得node节点到div的中间add by zwj
    		var westtree=parent.document.getElementById('westtree');
    		
    		var westtreej=$(westtree);
    		//treeObj.cancelSelectedNode();
    		treeObj.selectNode(nodes);
    		var oldx = westtreej.offset().top; 
    		//console.log(oldx);
    		var oldy = westtreej.offset().left; 
    		//console.log(oldy);
    		var nodeid=nodes.tId;
    		var nodej=$("#"+nodeid);
    		var newx = nodej.offset().top; 
    		//console.log(newx);
    		var newy = nodej.offset().left; 
    		westtreej.scrollTop(0);
    		westtreej.scrollLeft(0);
    		var topnew=newx-oldx+oldx/2;
			var leftnew=(newy-oldy)+oldy/2;
    		//console.log(newy);
    		if(newx>oldx){
    			westtree.scrollTop=topnew;
    			westtreej[0].scrollTop=topnew;
    		}
    		if(newy>oldy){
    			westtree.scrollLeft=leftnew;
    			westtreej[0].scrollLeft=leftnew;
    		}
    		 var cc=document.getElementById(nodeid);
 		    cc.scrollIntoView();
    		// add end
    			$.messager.show({
					title : '提示',
					msg : '挂接成功！'					
				});
    }
    	isguajie=false;
    }
    if(iseditrank){
    	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    	var nodes=editnode;
    	if(nodes!=null){				
    		//需要加滑动条的动作让其移动使得node节点到div的中间add by zwj
    		var westtree=parent.document.getElementById('westtree');
    		zwj_filltheform(treeObj,nodes);
    		// add end
    		treeObj.selectNode(nodes);
    		clickNodezwj( "treeDemo", nodes);
    }
    	iseditrank=false;
    	editnode=null;
    }
    if(selectnodeidzwj!=undefined){
    	var nodes =  treeObj.getNodeByParam("id", selectnodeidzwj, null);
    	treeObj.selectNode(nodes);
    	clickNodezwj( "treeDemo", nodes);
    	selectnodeidzwj=undefined;
    }
};
function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
    if(moveType=="inner"){
    	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
    	treeObj.reAsyncChildNodes(targetNode, "refresh");
    }
};
function setTemplateContent(personInfo, relInfo) {
	$("#rt_content").html(" ");
	$("#bt_content").html(" ");
	if(relInfo.isAlien){
		return;//is alien, just return 
	}
	var pPid = personInfo.pid;
	
	var rt_content = getSanDaiShiStyle(pPid);
	$("#rt_content").html(rt_content);
	
	var bt_content = getNewSuShiStyle(pPid);
	$("#bt_content").html(bt_content);
}

function getPersonDescById(pid){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var person = treeObj.getNodeByParam("id", pid, null);
	if(typeof person == 'undefined' || person == null){
		return '';
	}
	//找到pid这个节点，若nodeInfo没有保存个人信息，则从服务器获取。
	else{
		if(isStrValid(person.nodeDetailInfo)){			
			var personInfo = evalObject(person.nodeDetailInfo);//eval('(' + person.nodeDetailInfo + ')');
			return getPersonDescByNodeInfo(personInfo);
		}
		else{
			$.post(getIndividualAction, {treeid: pid}, function(data){				
				var rObj = jQuery.parseJSON(data);
				setNodeData(rObj);	
				return getPersonDescByNodeInfo(rObj.obj);
			});
		}
		//get person info from the server
		//var personInfo = eval('(' + person.nodeInfo + ')');			
	}
}

function getSanDaiShiStyle(pid){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var pNode = treeObj.getNodeByParam('id', pid, null);
	if(pNode.icon == 'wife.png' || pNode.icon == 'husband.png'){
		return;
	}
	var pName = toRealName(pNode.name);////pNode.nodeDetailInfo.name?
	var rt_content = "";
	if(isStrValid(pName)){
		rt_content = rt_content 
		+ '<div class="top-line"><p><strong>'
		+pName+
		'</strong><img src="h-line.png" style="float:right;"></img></p></div>';
	}
	rt_content = rt_content + '<div class="rt_div"><p class="intro">';

	if(pid>0){
		var pIntro = getPersonDescById(pid);
		rt_content = rt_content + pIntro;
	}
	var mateInfo = getMateInfo(pid);
	rt_content = rt_content + '</p>' + mateInfo + '</div>' + '<div class="bottom-line"><p>&nbsp;</p></div>';
	return rt_content;
}

function getNewSuShiStyle(pid){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var pNode = treeObj.getNodeByParam('id', pid, null);
	if(pNode.icon == 'wife.png' || pNode.icon == 'husband.png'){
		return;
	}
	var parentNode = pNode.getParentNode();
	if(parentNode == null)
		return;//当为根节点时会出现这种情况
	var parentName = toRealName(parentNode.name);//pNode.getParentNode().nodeDetailInfo.name;//
	var pName = toRealName(pNode.name);//pNode.nodeDetailInfo.name?
	var bt_content = '';
	bt_content = '<table class="t_table"><tr><td style="width:10%; padding-top:15px;" valign="top" align="center"><strong>'
		+ parentName 
		+ '</strong></td><td style="width:10%; padding-top:15px;" valign="top" align="center"><strong>' 
		+ pName 
		+ '</strong></td>';	
	var pIntro = makePersonIntro(pid);//is an object
	var mateInfo = '';
	for(i = 0; i < pIntro.mate.length; i++){
		var mate = pIntro.mate[i];
		var mateSelf = '', mateSon = '' , mateDaughter = '';
		mateSelf = '<p>'+ wifeRank[i] +'妻<strong>' + mate.name + '</strong> ' + mate.desc + '</p>';
		//儿子描述是一段
		if(mate.son.length>0){
			mateSon = '<p>子' + childrenNum[mate.son.length-1] + ' ';
			for(j = 0; j < mate.son.length; j++){
				mateSon = mateSon + toRealName(mate.son[j]) + ' ';//儿子的谱名
			}
			mateSon = mateSon + '</p>';
		}
		//女儿描述是一段
		if(mate.daughter.length>0){
			mateDaughter = '<p>女' + childrenNum[mate.daughter.length-1] + ' ';
			for(m = 0; m < mate.daughter.length; m++){
				mateDaughter = mateDaughter + toRealName(mate.daughter[m]);//列举女儿的谱名
			}
			mateDaughter = mateDaughter + '</p>';
		}
		mateInfo = mateInfo + mateSelf + mateSon + mateDaughter;
	}
	bt_content = bt_content 
	+ '<td class="p_intro"><p>'
	+ pIntro.self.desc 
	+ '</p>'
	+ mateInfo 
	+ '</td></tr></table>';
	return bt_content;
}

function makePersonIntro(pPid){	
	var personIntro = new Object();
	var self = new Object();
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	self.desc = getPersonDescById(pPid);//pPid的个人简介	
	self.name = toRealName(treeObj.getNodeByParam('id', pPid, null).name);//pPid的谱名
	personIntro.self = self;
	var children = treeObj.getNodesByParam("parentId", pPid, null);//树中的子节点。
	var mateIds = new Array();
	//异步得到孩子节点的人物数据，保存在节点中
	for(i = 0; i < children.length; i++){
		if(children[i].icon == 'wife.png'){//仅限配偶为女性
			mateIds.push(children[i].id); //配偶的id数组。
		}
		if (typeof children[i].nodeRelInfo == "undefined"
			|| children[i].nodeRelInfo == null) {
			$.post(getIndividualAction, {treeid: children[i].id}, function(data){				
				var rObj = ('('+data+')');
				setNodeData(rObj);												
			});
		}
	}
	var mateInfo = new Array();//
	//再次取得孩子节点，计算配偶所生的孩子
	var mChildren = treeObj.getNodesByParam("parentId", pPid, null);
	for(var i=0 ; i < mateIds.length ; i++){
		var mateName = treeObj.getNodeByParam("id", mateIds[i], null).name;
		var mateDesc = getPersonDescById(mateIds[i]);
		var mSon = new Array();
		var mDaughter = new Array();
		for(var j=0; j<mChildren.length; j++){
			var mCNodeRelInfo = evalObject(mChildren[j].nodeRelInfo);//eval('(' + mChildren[j].nodeRelInfo + ')');
			if(mCNodeRelInfo.motherPid == mateIds[i]){//从节点关联信息找到母亲的孩子
				if(mChildren[j].icon == 'woman.png' || mChildren[j].icon == 'dwoman.png'){
					mDaughter.push(mChildren[j].name);					
				}
				else{
					mSon.push(mChildren[j].name);						
				}						
			}			
		}
		var mateObject = {
				name:mateName,
				desc:mateDesc,
				son:mSon,
				daughter:mDaughter
		};
		mateInfo[i] = mateObject;
	}
	personIntro.mate = mateInfo;
	return personIntro;
}

function getMateInfo(pPid){	
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var children = treeObj.getNodesByParam("parentId", pPid, null);
	//显示预览必须已载入了孩子节点！if(personInfo.sex == '男'){}
	var mate = new Array();
	for (i = 0; i < children.length; i++) {
		if(children[i].icon == 'wife.png'){//仅限配偶为女性
			mate.push(children[i].id); 
		}
		if (typeof children[i].nodeRelInfo == "undefined"
				|| children[i].nodeRelInfo == null) {
			$.post(getIndividualAction, {treeid: children[i].id}, function(data){				
				var rObj = jQuery.parseJSON(data);
				setNodeData(rObj);					
				//console.info("nodeRelInfo from getting children info:"+rObj.prevRelInfo.curPid);				
			});
		}
	}
	var mateInfo = '';
	var mChildren = treeObj.getNodesByParam("parentId", pPid, null);
	for(var i=0 ; i < mate.length ; i++){
		var mateDesc = getPersonDescById(mate[i]);
		var mSon = new Array();
		var mDaughter = new Array();
		var mateNode = treeObj.getNodeByParam("id", mate[i], null);
		mateInfo = mateInfo + '<p>' +wifeRank[i]+ '妻<strong>' + mateNode.name + '</strong></p>';//妻子名
		if(isStrValid(mateDesc)){
			mateInfo = mateInfo + '<p class="intro">' + mateDesc + '</p>';//妻子描述
		}		
		
		for(var j=0; j<mChildren.length; j++){
			var mCNodeRelInfo = evalObject(mChildren[j].nodeRelInfo);//eval('(' + mChildren[j].nodeRelInfo + ')');
			if(mCNodeRelInfo.motherPid == mate[i]){//从节点关联信息找到母亲的孩子
				if(mChildren[j].icon == 'woman.png' || mChildren[j].icon == 'dwoman.png'){
					mDaughter.push(mChildren[j].name);
				}
				else
					mSon.push(mChildren[j].name);								
			}			
		}
		if(mSon.length>0){
			mateInfo = mateInfo + '<p>子' + childrenNum[mSon.length-1] + ' ';
			for(var sIndex=0; sIndex<mSon.length; sIndex++){
				mateInfo = mateInfo + toRealName($.trim(mSon[sIndex])) + ' ';
			}
			mateInfo = mateInfo + '</p>';
		}
		if(mDaughter.length>0){
			mateInfo = mateInfo + '<p>女' + childrenNum[mDaughter.length-1] + ' ';
			for(var dIndex=0; dIndex<mDaughter.length; dIndex++){
				mateInfo = mateInfo + toRealName($.trim(mDaughter[dIndex])) + ' ';
			}
			mateInfo = mateInfo + '</p>';
		}		
	}
	return mateInfo;
}

function getPersonDescByNodeInfo(nodeInfo){
	var personDesc = '';
	var pGivenname = nodeInfo.givenname;//名
	var pNickname = nodeInfo.nickname;//字
	var pTitle = nodeInfo.title;//号
	var pSex = nodeInfo.sex;
	var pBirthday = nodeInfo.birthday;
	var pDeathplace = nodeInfo.deachplace;
	var pDeathday = nodeInfo.deathday;
	var pOfficaltitle = nodeInfo.officialtitle;
	var pLifedsc = nodeInfo.lifedsc;
	if(isStrValid(pGivenname)){
		personDesc = personDesc + '名'+$.trim(pGivenname)+' ';
	}
	if(isStrValid(pNickname)){
		personDesc = personDesc + '字'+$.trim(pNickname)+' ';
	}
	if(isStrValid(pTitle)){
		personDesc = personDesc + '号'+$.trim(pTitle)+' ';
	}
	if(isStrValid(pBirthday)){
		personDesc = personDesc + '生于'+$.trim(pBirthday) + ' ';		
	}
	if(isStrValid(pDeathplace)){
		personDesc = personDesc + '殁于'+$.trim(pDeathplace) + ' ';
	}
	if(isStrValid(pLifedsc)){
		personDesc =personDesc + pLifedsc + ' '; 
	}
	return personDesc;
}

function isStrValid(str){
	if(typeof str != "undefined" && str != null && $.trim(str) != ""){
		return true;
	}
	return false;
}

//设置节点的附加属性nodeDetailInfo及nodeRelInfo，为Json字符串，保存了节点的人物详细信息及关联人物信息
function setNodeData(rJson) {
	var nodeDetailInfo = JSON.stringify(rJson.obj);//就是你获得的JSON那个对象
	var nodeRelInfo = JSON.stringify(rJson.prevRelInfo);//对保存提交方式和点击查询方式，统一用prevRelInfo为rJson.obj人物的关联信息
	//console.info("node Json: " + nodeDetailInfo);
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var nodeselect = treeObj.getSelectedNodes();
	//var nodeSet= treeObj.getNodeByParam("id", rJson.obj.pid, null);
	if(nodeselect!=null){
		var nodeSet=nodeselect[0];
		nodeSet.nodeDetailInfo = nodeDetailInfo;
		nodeSet.nodeRelInfo = nodeRelInfo;
	}
	//console.info("nodedetail:" + nodeSet.nodeDetailInfo );
	treeObj.updateNode(nodeSet);
	//console.info("nodeset: " + nodeSet);
}

//给parentId增加一下性别为sex的虚节点，id为负值
function addVirtualNode(parentId, isSpouse,isAlien) {		
	var flagCount = -Math.ceil(Math.random()*1000);///-1;
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var parentNode = treeObj.getNodeByParam("id", parentId, null);
	var parentNodeInfo = evalObject(parentNode.nodeDetailInfo);
	var newnodes=treeObj.addNodes(parentNode, {
		id : (--flagCount),
		//pId : parentId,
		parentId : parentId,
		name : "新的人物"
	});
	//var newnode = treeObj.getNodeByParam("id", flagCount, null);	
	var newnode=newnodes[0];
	treeObj.selectNode(newnode, false);//選中,选中相当于点击，会解决Onclick回调函数
	if(isAlien==true){
		
	}
	else{$('input[name="surname"]').val(parentNodeInfo.surname);}
	
	if(isSpouse == true && parentNodeInfo.sex=='男'){
		$("form input[name='sex'][value='女']").attr("checked", true);
	}else{
		$("form input[name='sex'][value='男']").attr("checked", true);			
	}
	if(inputSetting.defaultAlive==true || inputSetting.defaultAlive=='true'){
		$("form input[name='islive'][value='true']").attr("checked", true);				
	}else
		$("form input[name='islive'][value='false']").attr("checked", true);
}
//接收的参数为对象，由服务器返回的数据格式，见后台的ResponseJson类
//如何找到需要回写的节点？？当前选中的节点能保证正确吗？
function updateVirtualNode(rJson) {
	if (!rJson.success) {
		return;//未保存成功，直接返回
	}
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var sNodes = treeObj.getSelectedNodes();//var sNode = treeObj.getNodeByParam('id', rJson.obj.pid, null);
	if (sNodes.length>0) {
		var virtualNode = sNodes[0];
		var parentNode = virtualNode.getParentNode();//treeObj.getNodeByParam('id', virtualNode.parentId, null);//getParentNode()得到的为什么一直是null!!!
		if(parentNode != null){
			if (parentNode.id != rJson.prevRelInfo.fatherPid
					&& parentNode.id != rJson.prevRelInfo.motherPid
					&& parentNode.id != rJson.prevRelInfo.matePid) {
				//alert(parentNode.id+'--parentId--relInfo:'+rJson.prevRelInfo);
				return;//树的父亲节点与所保存的人物的父亲节点不对应。父亲节点只能是fatherPid,motherPid,matePid之一
			}
		}
		virtualNode.id = rJson.obj.pid;
		virtualNode.parentId = virtualNode.parentId;
		var gen = '';
		if(rJson.prevRelInfo.isAlien == false 
				&& isStrValid(rJson.obj.ggen)){			
			gen = '(' + rJson.obj.ggen + '世)';
		}else{
			if($.trim(rJson.obj.sex)=="男"){
				gen='(夫)';
			}else{
				gen='(妻)';
			}
		}
		virtualNode.originName = rJson.obj.name;
		virtualNode.name = rJson.obj.name+gen;				
		virtualNode.sex = $.trim(rJson.obj.sex);
		virtualNode.isParent = true;		
		var icon = virtualNode.sex == "男" ? "man.png" : "woman.png";
		if(rJson.obj.islive==false)
			icon = virtualNode.sex == "男" ? "dman.png" : "dwoman.png";
		if(rJson.relInfo.isAlien == true){
			virtualNode.isParent = false;//配偶节点无子节点
			if(rJson.obj.islive)			
				icon = virtualNode.sex == "男" ? "husband.png" : "wife.png";		
			else icon = virtualNode.sex == "男" ? "dhusband.png" : "dwife.png";
		}
		virtualNode.icon = icon;//????
		virtualNode.nodeDetailInfo = JSON.stringify(rJson.obj);
		if(rJson.relInfo.hasSpecialRelDesc!="0"){
			//virtualNode.nodeDetailInfo.arrangenum=rJson.relInfo.hasSpecialRelDesc;
			$("input[name='arrangenum']").attr("value", rJson.relInfo.hasSpecialRelDesc);//如何是侧室的话更新arragenum，=10000+正真的rank
		}
		virtualNode.nodeRelInfo = JSON.stringify(rJson.prevRelInfo);
		treeObj.updateNode(virtualNode);
	}
}
function toRealName(name){
	if(isStrValid(name)){
		var index = name.indexOf('(');
		if(index > 0)
			return name.substring(0, index);
	}
	return name;
}
function evalObject(s){
	return typeof s == 'object' ? s : eval('(' + s + ')');
}
//add by zwj 模板的更新
function updatethetemplet(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	if(treeObj!=undefined){
		var sNodes = treeObj.getSelectedNodes();
	if (sNodes.length > 0) {
		var selectedNode=sNodes[0];
		var treeNodeId = (selectedNode.id);	
	var nodeInfo = evalObject(selectedNode.nodeDetailInfo);
	var nodeRelInfo = evalObject(selectedNode.nodeRelInfo);

	//add by zwj
	var tmp=$('#data-input-table input[name=surname]').val();
	$('#data-input-table input[name=surname]').val("").focus().val(tmp);//每次初始化人物树的时候要定位到录入表单中的第一个元素。
	//end
	var motherId = nodeRelInfo.motherPid;
	if(motherId > 0){
		var mothernode = treeObj.getNodeByParam("id", motherId, null);
		var motherName=nodeRelInfo.motherName;
		var a ='女';
		if(mothernode!=undefined&&mothernode!=null){
			motherName=mothernode.name;
			//var index=motherName.indexOf("("); 
			//motherName=motherName.substring(0,index);
			a=mothernode.sex;
		}
		var showtitle = a=='女' ? '母亲：' : '父亲 ：';
		$('#mother-name').text(showtitle+motherName);
	}	
	else{		
		$('#mother-name').text('母亲不详');
	}
	if(nodeInfo.arrangenum==undefined){
		$('#arrange-num').text('家中排行：未指定');
	}else
		$('#arrange-num').text('家中排行：' + nodeInfo.arrangenum);

	var sizi = '', tiaozi = '';
	if(nodeRelInfo.relType == '入继'){
		sizi = nodeRelInfo.fatherName + '嗣子 ';
	}
	if(nodeRelInfo.relType == '出祧'){
		//tiaozi = nodeRelInfo.fatherName + '祧子 ';
		tiaozi = nodeRelInfo.fatherinlawid + '祧子 ';
	}
	$('#special-rel-desc').text(sizi + tiaozi + nodeRelInfo.hasSpecialRelDesc);
	var appenstr="";
	if(nodeInfo.remark!=null){
		appenstr+=nodeInfo.remark;
	}
	if(nodeInfo.endnote!=null){
		appenstr+=nodeInfo.endnote;
	}
	var htmlzwj="<p class='intro'>"+appenstr+"</p>";
	if(appenstr!=""){
		$("#rt_content").append(htmlzwj);
	}
	$("input[name='curpid']").attr("value", treeNodeId);//防止被setNodeData中的prevRelInfo设置为0了
	//是否加载图片的代码段
	var tab = $('#input-tabs').tabs('getSelected');
	var index = $('#input-tabs').tabs('getTabIndex',tab);//常规录入的Index为1	
	if(index==1){
		loadPersonPhoto();
	}
		}
		else{alert("当前没有选择人物树上人物！");}
		}
}
//add end
</script>


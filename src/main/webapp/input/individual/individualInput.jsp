<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="pragma" content="no-cache" />
<title>世系录入</title>

  <jsp:include page="../../inc.jsp"></jsp:include>
  <script>
  //add by zwj
  var zwj_selectfocus="";
  //var zwj_formID="#hotkey-individual-form";//全局变量保存当前的表单。
   $(function(){
	   $('.easyui-accordion').accordion('select', '族谱制作');
	   $("#hotkey-individual-form :input").blur(function(){
		   zwj_selectfocus=event.target|| event.srcElement;
  		});
	   Mousetrap.bindGlobal('down', function(){
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			if(treeObj!=undefined){
				var sNodes = treeObj.getSelectedNodes();
				if (sNodes.length > 0) {
					var nodes=sNodes[0];
					var node;
					//if(nodes.children!='[]'){
						//nodes.isLastNode=false;
					//}
					var nodeschildren=nodes.children;
					if(nodes.children!=undefined&&nodes.children!=null&&nodes.children.length!=0){
						node=nodes.children[0];
					}
					else{
						node = nodes.getNextNode();
						if(node==null){
							if(nodes.parentTId!=null){
								node=nodes.getParentNode();
								node=node.getNextNode();
							}
						}
					}
					//if(node==null&&nodes.isLastNode){
						//return;
					//}
					//else if(nodes.children!='[]'&&nodes.children!=undefined){
						//var nodechildren=nodes.children;
						//node=nodechildren[0];
					//}
					//else if(nodes.getParentNode()!=null){
						//nodes=nodes.getParentNode();
						//node = nodes.getNextNode();
					//}
					if(node!=null&&node!=undefined){
						treeObj.selectNode(node);
						zwj_filltheform(treeObj,node);
					}
					//clickNode(,node);
				}
				else{
					 alert("请先选择一个节点");
				}
			}

			});
	   Mousetrap.bindGlobal('up', function(){
			var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
			if(treeObj!=undefined){
				var sNodes = treeObj.getSelectedNodes();
				if (sNodes.length > 0) {
					var nodes=sNodes[0];
					var node=nodes.getPreNode();
					if(node==null){
						if(nodes.parentTId!=null){
							node=nodes.getParentNode();
						}
					}
					//if(nodes.parentTId!=null){
						//nodes.isFirstNode=false;
					//}
					//if(node==null&&nodes.isLastNode){
						//return;
					//}
					//else if(node==null){
						//node=nodes.getParentNode();
					//}
					if(node!=null&&node!=undefined){
						treeObj.selectNode(node);
						zwj_filltheform(treeObj,node);
					}
				}
				else{
					 alert("请先选择一个节点");
				}
			}

			});
   });
  //add end
  </script>
</head>

<body class="easyui-layout" data-options="fit:true" style="width:1200px;height:800px;">


	<div data-options="region:'north'" style="height:50px;overflow:hidden;" data-options="fit:true">
		<div align=right>
		<span>
			<jsp:include page="../../header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'菜单'"
		style="width:200px">
		<jsp:include page="../../newnav.jsp"></jsp:include>

	</div>
	<div data-options="region:'center',overflow:'hidden'" id="centerLayout">
		<div  id="individualzwj" class="easyui-layout" data-options="fit:true">
		
			<%--
	style="width:1200px;height:700px;"
		--%>
			<div id="westtree" data-options="region:'west', split:true" title="人物树" style="width:250px;overflow:auto;">
				<jsp:include page="individualTree.jsp"></jsp:include>
			</div>
			<div data-options="region:'center', split:true" title="录入人物信息" style="overflow-x:scroll;overflow-y:scroll">
				<%--导入人物录入表单的JSP，实现为tabs--%>
				<%--点击造字出现造字模块浮层start--%>
				<div id="creat-font-dialog" class="easyui-dialog easyui-draggable"
		data-options="modal:true,closed:true,iconCls:'icon-save',resizable:true,handle:'#title'" title="造字" style="width:765px;height:400px">
				<div align="center" id="chareditor">
				<div align="center" style="width:725px;height:350px;background-color:RGB(240,240,240);border-style:solid;border-width:1px;border-color:black;">
				
				<!--<div><a onclick="closethechw();"><img src='./title.jpg' align="right"></a></div>  -->
				<object id="DCO" WIDTH=725 HEIGHT=300 classid="CLSID:E75D5679-CBA6-4A9A-8D53-AAED7A313AA1">
				<param NAME="_Version" VALUE="65536">
		<param NAME="_ExtentX" VALUE="12806">
		<param NAME="_ExtentY" VALUE="1747">
		<param NAME="_StockProps" VALUE="0">
		</object> 
		<table width="70%">
		<tr>
		<td width="50%" align="center"><button id="usethechar" onclick="usethechar();"  style="height:30px">
		使用该字
		</button></td>
		<td width="50%" align="center"><button id="editthechar" onclick="editthechar();" style="height:30px">
		编辑该字
		</button></td>
		</tr>
		</table>
				</div>
		</div>
		</div>
		<%--点击造字出现造字模块浮层end--%>
				<jsp:include page="individualForm.jsp"></jsp:include>
				
				<%--<jsp:include page="testPhotoForm.jsp"></jsp:include>
		--%>
			</div>
			<div data-options="region:'east', split:true"" title="模板显示" style="width:220px;">
				<jsp:include page="r_template.jsp"></jsp:include>
			</div>
			<div data-options="region:'south'" style="width:1200px;height:120px;">
				<div class="easyui-layout" data-options="fit:true,split:true">
					<div data-options="region:'west',split:true" style="width:250px">
						<jsp:include page="pediStat.jsp"></jsp:include>
					</div>
					<div data-options="region:'center'">
						<jsp:include page="b_template.jsp"></jsp:include>
					</div>
				</div>
			</div>


		</div>
	</div>
	<%--
	<jsp:include page="login.jsp"></jsp:include>
	<jsp:include page="reg.jsp"></jsp:include>
--%>
<script>
function editthechar(){
	//调用控件编辑字
	var obj = document.getElementById("DCO");

    obj.BeginEditingChar();

}
function usethechar(){
	//调用控件使用自编码
	var obj = document.getElementById("DCO");
	//$("#chareditor").css("display","none");
	//var result=obj.GetSelectedCharAndSaveImage();
	$('#creat-font-dialog').dialog("close");
    var result = obj.GetSelectedChar();
    var a=zwj_selectfocus.value+result;
    zwj_selectfocus.value=a;
    zwj_selectfocus.focus();
    
}
function closethechw(){
	$("#chareditor").css("display","none");
}
function zwj_filltheform(treeObj,treeNode){
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
	var tmp=$("input[name='name']").val();
	$("input[name='name']").val("").focus().val(tmp);//每次初始化人物树的时候要定位到录入表单中的第一个元素。
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
		tiaozi = nodeRelInfo.fatherinlawid + '祧子 ';
		//tiaozi = nodeRelInfo.fatherName + '祧子 ';
	}
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
	
	$('#special-rel-desc').text(sizi + tiaozi + nodeRelInfo.hasSpecialRelDesc);
	$("input[name='curpid']").attr("value", treeNodeId);//防止被setNodeData中的prevRelInfo设置为0了
	//是否加载图片的代码段
	var tab = $('#input-tabs').tabs('getSelected');
	var index = $('#input-tabs').tabs('getTabIndex',tab);//常规录入的Index为1	
	if(index==1){
		loadPersonPhoto();
	}
	treeObj.selectNode(treeNode);
}
</script>
</body>
</html>
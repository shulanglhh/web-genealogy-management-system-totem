<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ResourceBundle resourceBundle = ResourceBundle.getBundle("doc");
String ServerIP = resourceBundle.getString("ServerIP");
String FTPDocHome = resourceBundle.getString("FTPDocHome");
String FTPPort = resourceBundle.getString("FTPPort");
String FTPUserName = resourceBundle.getString("FTPUserName");
String FTPPassword = resourceBundle.getString("FTPPassword"); 
String HttpAddr = resourceBundle.getString("HttpAddr"); 

%>
<style type="text/css">
body{ font-size:14px;}
input{ vertical-align:middle; margin:0; padding:0}
.file-box{ position:relative;width:340px}
.txt{ height:22px; border:1px solid #cdcdcd; width:180px;}
.btn{ background-color:#FFF; border:1px solid #CDCDCD;height:24px; width:70px;}
.file{ position:absolute; top:0; right:80px; height:24px; padding:10px;filter:alpha(opacity:0);opacity: 0;width:260px }
</style>
<script type="text/javascript"
	src="<%=path %>/jslib/treejs/jquery.ztree.all-3.5.min.js"></script>

<script><%--
	//global var, used in createTree.js
	var getTreeAction = '${pageContext.request.contextPath}/tRelationAction!getPersonTree.action';
	var getIndividualAction = '${pageContext.request.contextPath}/tRelationAction!fetchIndividualById.action';
	var deleteAction = '${pageContext.request.contextPath}/tRelationAction!deletePersonTree.action';
	var changeRelationAction = '${pageContext.request.contextPath}/tRelationAction!changeRelation.action';
	var showNewShuAction = '${pageContext.request.contextPath}/tIndividualAction!showNewSuShiStyle.action';--%>
	var searchAction = '${pageContext.request.contextPath}/tIndividualAction!searchPerson.action';
	var userid, username;
	var issearch=false;
	var iseditrank=false;
	var editnode;
	var inputSetting={
			maxDepth : <%=session.getAttribute("maxDepth")%>,//最多加载层数，非正数表示加载全部
			defaultAlive : <%=session.getAttribute("defaultAlive")%>,//默认生死
			saveRemind : <%=session.getAttribute("saveRemind")%>//保存是否提示
	};
	var selectnodeidzwj;
	var setthemother='<%=path%>/disposalAction!setthemother.action';
	//alert(maxDepth + saveRemind);
	$(function() {
		//$('#zwjlogin-dialog').dialog('open');
		$('#zwjloginForm').form({
			url : '${pageContext.request.contextPath}/userAction!login.action',
			success : function(r) {
				//console.info(r);
				var obj = jQuery.parseJSON(r);
				if (obj.success) {
					//usercode=$('#index_loginForm input[name=name]').attr('value');
					//console.info(usercode);
					$('#zwjlogin-dialog').dialog('close');
					 $('#zwjloginForm').form('clear');
				}
				$.messager.show({
					title : '提示',
					msg : obj.msg
				});
			}
		});
		//var x=$("#westtree").offset().left;
		//var y=$("#westtree").offset().top;
		//$("#treecomzwj").css("left",x);
		//$("#treecomzwj").css("top",y);
		username="<%=session.getAttribute("usercode")%>";
		userid="<%=session.getAttribute("userid")%>";		
		//inputSetting.maxDepth = "<%=session.getAttribute("maxDepth")%>";	
		//inputSetting.defaultAlive = "<%=session.getAttribute("defaultAlive")%>";
		//inputSetting.saveRemind = "<%=session.getAttribute("saveRemind")%>";
		
		$('#peditree').combobox({
			required: true,
			//url : '${pageContext.request.contextPath}/userAction!showthegname.action',
			valueField : 'pid',
			textField : 'text',
			missingMessage:'请先选择族谱再进行操作！',
			onSelect : initPediTree
		});
		$('#choose-import-form').form({
			url : '${pageContext.request.contextPath}/fUploadAction!uploadSXTFile.action',
			onSubmit : function() {
				var fileText=$("#textfield").val();
				fileText =fileText.substring(fileText.lastIndexOf("."),fileText.length);
				if($("#textfield").val()==''){
					alert("未选择导入文件。");
					return false;
					}
				else if(fileText!='.sxt'){
					alert("未选择正确的sxt文件。");
					return false;
				}
				else if($("#useridzwj").val()==''){
					alert("网络错误，请重新登录。");
					return false;
				}
				else if($("#gidzwj").val()==''){
					alert("请选择族谱。");
					return false;
				}
				$.messager.progress();
			},
			success : function(data) {
				if(data==undefined){
					$.messager.progress('close');
					alert('导入文件失败，请重新选择');
					return;
				}
				var dataj = jQuery.parseJSON(data);
				$.messager.progress('close');
				if (dataj.success) {
					$('#choose-import-dialog').dialog('close');
					$('#input-root-dialog').dialog('close');
					
					$.messager.show({
						title : '提示',
						msg : dataj.msg		
					});
					var o = new Object();
					o.text=$('#peditree').combobox('getText');
					o.pid=$('#peditree').combobox('getValue');
					initPediTree(o, null);
					
				} else {
					alert('导入文件失败，请重新选择');}
			}		
		});
		$('#choose-mother-form').form({
			url : setthemother,
			onSubmit : function() {
				if(!$("#choose-mother-form").form('validate')){
					return false;
					}else{
						var hookperson=$('#hook-person').datagrid('getRows');
						if(hookperson=[]){
						}
						else{sonnode=$('#hook-person').datagrid('getRows')[0].pid;}
						$('#sourceId').val(sonnode);
				}
			},
			success : function(data) {
				var dataj = jQuery.parseJSON(data);
				if (dataj.success) {
					$.messager.show({
						title : '提示',
						msg : dataj.msg		
					});
					$('#choose-mother-dialog').dialog('close');
				} else {
					alert('指定母亲失败，请重新选择');}
			}		
		});
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'username=' + username,
			url : '${pageContext.request.contextPath}/userAction!showthegname.action',//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('获取族谱列表失败，请登录后使用');
			},
			success : function(j) { //请求成功后处理函数。  
				var rObj = eval('(' + j + ')');
				if (rObj.success) {					
					$('#peditree').combobox('loadData', rObj.obj);					
				} else {
					alert(rObj.msg);
				}
			}
		});
	});
	
	function initPediTree(record, curNode){	
		$("#backzwj").hide();
		$("#containzwj").hide();
		//document.getElementById('hotkey-individual-form').style.display = 'block';
		var tmp=$('#data-input-table input[name=surname]').val();
		$('#data-input-table input[name=surname]').val("").focus().val(tmp);//每次初始化人物树的时候要定位到录入表单中的第一个元素。
		//设置增加根节点和录入设置按钮为不可用
		$('#addrootnode').linkbutton('enable');
		$('#setinputsetting').linkbutton('enable');
		//初始化全局的搜索变量
		searchNextTimes = 0;//“搜索下一个”的次数，置空
		lastSearchCntx = '';//上一次搜索的内容也置空
		//设置母亲、排行等信息为空
		$('#mother-name').text('');
		$('#arrange-num').text('');
		$("input[name=gid]").attr("value", record.pid);//每次选中都设置gid
		var newTreeNodes;//;
		var rootNode = {
				id : 0,
				parentId : -1,
				name : record.text,//族谱根节点
				isParent : true,
				icon : "",
				sex : "男",	
				nodeDetailInfo : "",
				nodeRelInfo : ""
		};
		$.fn.zTree.destroy("treeDemo");
				
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			dataType:'json',//必须
			data : 'userId=' + userid + '&pediId=' + record.pid,
			url : '${pageContext.request.contextPath}/tRelationAction!initPediTree.action',//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('获取' + record.text + ' 族谱树失败，请稍后重试');
			},
			success : function(rObj) { //请求成功后处理函数。  				
				//var rObj = eval('(' + j + ')');
				if (rObj!=null){
					newTreeNodes = rObj;
					zTree = $.fn.zTree.init($("#treeDemo"), setting, newTreeNodes);	
					var nodes = zTree.getNodes();
					zTree.selectNode(nodes[0]);
					zwj_filltheform(zTree,nodes[0]);
					$('#addrootnode').linkbutton('enable');
					$('#setinputsetting').linkbutton('enable');
					if(curNode!=null && curNode!=undefined){
						var node = zTree.getNodeByTId(curNode.id);
						zTree.selectNode(node);
						//zTree.addNodes(null, curNode);
						setRelInfo(curNode.nodeRelInfo);
					}
					showGroupThing();////显示“选择根人物，新增根节点”
				} 
				//else {										
				//	alert('获取“' + record.text + '”族谱树失败，可能是您尚未录入第一个人物');	
				//	$('#input-root-dialog').dialog('open');						
				//}
			}
		});
		$.post('${pageContext.request.contextPath}/tRelationAction!showStatInfo.action', 
				{userId: userid, pediId: record.pid}, 
				function(data){					
					var rObj = eval('(' + data + ')');					
					if(rObj.success){
						showStatInfo(rObj.obj);//PediStatistics						
					}
					else{
						alert('获取统计信息');
					}
		});
	}
	
	function showStatInfo(pediStat){
		var total = pediStat.total;
		var maleNum = pediStat.maleNum;
		var femaleNum = pediStat.femaleNum;
		var maleAliveNum = pediStat.maleAliveNum;
		var femaleAliveNum = pediStat.femaleAliveNum;
		var maleSpouseNum = pediStat.maleSpouseNum;
		var femaleSpouseNum = pediStat.femaleSpouseNum;

		var aliveTotal = maleAliveNum + femaleAliveNum;
		var alivePercent = getPercent(aliveTotal, total);
		
		var malePercent = getPercent(maleNum, total);
		var femalePercent = getPercent(femaleNum, total);
		
		var maleAlivePercent = getPercent(maleAliveNum, maleNum);
		var femaleAlivePercent = getPercent(femaleAliveNum, femaleNum);
		
		var maleDead = maleNum - maleAliveNum;
		var maleDeadPercent = getPercent(maleDead, maleNum);
		
		var femaleDead = femaleNum - femaleAliveNum;
		var femaleDeadPercent = getPercent(femaleDead, femaleNum);
		
		var maleSpousePercent = getPercent(maleSpouseNum, total);
		var femaleSpousePercent = getPercent(femaleSpouseNum, total);
		
		$('#tr1-td2').text(total);//总人数
		$('#tr1-td5').text(aliveTotal);//在生总人数
		$('#tr1-td6').text(alivePercent);
		
		$('#tr2-td2').text(maleNum);//男
		$('#tr2-td3').text(malePercent);
		$('#tr2-td5').text(femaleNum);//女
		$('#tr2-td6').text(femalePercent);
		
		$('#tr3-td2').text(maleAliveNum);//男在生
		$('#tr3-td3').text(maleAlivePercent);
		$('#tr3-td5').text(femaleAliveNum);//女在生
		$('#tr3-td6').text(femaleAlivePercent);
		
		$('#tr4-td2').text(maleDead);//男已故
		$('#tr4-td3').text(maleDeadPercent);
		$('#tr4-td5').text(femaleDead);//女已故
		$('#tr4-td6').text(femaleDeadPercent);
		
		$('#tr5-td2').text(maleSpouseNum);//男配偶 
		$('#tr5-td3').text(maleSpousePercent);
		$('#tr5-td5').text(maleSpouseNum);//女配偶
		$('#tr5-td6').text(femaleSpousePercent);
	}
	
	function getPercent(num, total) { 
		num = parseFloat(num); 
		total = parseFloat(total); 
		if (isNaN(num) || isNaN(total)) { 
		return "-"; 
		} 
		return total <= 0 ? "0.0%" : (Math.round(num / total * 1000) / 10.00 + "%");
	} 
	
	function showGroupThing(){
		////realize later
	}
	
	var saveNewRel = '${pageContext.request.contextPath}/tRelationAction!changeRelation.action';
	function saveRank(){
		$('#saveRank').linkbutton('disable');
		var rankNum = $('#noderank').val();
		var treeId = $('#treeid').val();
		$.post('${pageContext.request.contextPath}/tRelationAction!changeRelationRank.action', 
				{treeid: treeId, ranknumber: rankNum}, 
				function(data){
					$('#saveRank').linkbutton('enable');
					var rObj = eval('(' + data + ')');					
					if(rObj.success){
						/*更新成功后，同时更新模板显示中的排行显示，以及人物节点的arrangenum属性
						  但是，更新一个人的arrangenum，会影响其他兄弟节点的arrangenum，故，这里刷新父节点，有利
						*/
						closeChangeRankDialog();
						$.messager.show({
							title:'提示',
							msg:'更新排行成功'
						});
						var tree = $.fn.zTree.getZTreeObj("treeDemo");
						var node = tree.getNodeByParam('id', treeId, null);
						iseditrank=true;
						editnode=node;
						tree.reAsyncChildNodes(node.getParentNode(), "refresh");
						tree.selectNode(node);
						$('#arrange-num').text('家中排行：' + rankNum);
						
					}
					else{
						alert('更新排行失败');
					}
		});
	};
	function saveGgen(){
		$('#saveGgen').linkbutton('disable');
		var ggenNum = $('#nodeggen').val();
		var treeId = $('#treeid').val();
		$.post('${pageContext.request.contextPath}/tIndividualAction!changeGgen.action', 
				{treeid: treeId, ggennumber: ggenNum}, 
				function(data){
					$('#saveGgen').linkbutton('enable');
					var rObj = eval('(' + data + ')');
					if(rObj.success){
						closeChangeGgenDialog();
						alert('更新世代成功' + rObj.msg);
						var treeNode = zTree.getNodeByParam('id', treeId, null);
						treeNode.name = toRealName(treeNode.name) + '('+ ggenNum +'世)';
						zTree.updateNode(treeNode);
						selectnodeidzwj=treeNode.id;
						//var pTreeNode = zTree.getNodeByParam('parentId', treeId, null);//重载父亲的子节点。另一种方法是重载其子节点，然后更新树节点的显示名
						zTree.reAsyncChildNodes(treeNode, "refresh");
					}
					else{
						alert('更新世代失败'+rObj.msg);
					}
		});
	}
	function saveNewRelation(){
		//var saveNewRel = '${pageContext.request.contextPath}/tIndividualAction!save.action';
		//var person1 = $('#hook-person').datagrid('selectRow', 0);	
		var row = $('#hook-person').datagrid('getRows');
		if(row.length < 1){
			var dataRows = new Array();
			dataRows[0] = evalObject($.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes()[0].nodeDetailInfo);
			var dataRow = {total:1, rows:dataRows };
			$('#hook-person').datagrid('loadData',dataRow);
			row = $('#hook-person').datagrid('getRows');
			if(row.length < 1){
				alert('请选择需要挂接的人物');
				return;
			}
		}
		
		var pPid1 = row[0].pid;
		var ggen1 = row[0].ggen;
		var p2 = $('#search-result').datagrid('getSelected');
		var pPid2 = p2.pid;
		var ggen2 = p2.ggen;
		var hooktype = $('input[name="hooktype"]:checked').val();					
		//&&hooktype>0
		if(ggen1==''){
			alert('节点不合法，请重新选择');
			return;
		}
		if(pPid1==pPid2)
		{
		   alert('非法挂接本人！');
		   return;
		}
		if(pPid1>0 && pPid2>0 ){
			if(hooktype == '6' || hooktype == '7'){
				if(ggen1!=ggen2+1){
					alert('世代数不合法，嗣子或者祧子只能挂接给上一世代的人物！');
					return false;
				}
			}
			$('#saveNewRelation').linkbutton('disable');
			$.post(saveNewRel, {sourceId:pPid1, targetId:pPid2, relType:hooktype}, function(data){
				$('#saveNewRelation').linkbutton('enable');
				var rData = eval('('+data+')');
				if(rData.success){	
					if(hooktype == '5' || hooktype == '6')//挂为子节点和出继节点，需要把节点移到目标节点下
					
						moveNode(pPid1, pPid2);//p1移动为p2的子节点
					//alert('挂接成功，刷新树可见结果');
						else if( hooktype == '8'){
							if(rData.obj!=null){
								moveNode(pPid1, pPid2);
							}
						}
						else if( hooktype == '7'){
								moveNode(pPid1, pPid2);
						}
					closeHookDialog();
				}
				else
					alert('挂接失败');
			});
		}
		else{
			$('#saveNewRelation').linkbutton('enable');
			alert('请选择人物及挂接类型');
		}
	}
	
	function moveNode(pPid1, pPid2){
		var hooktype = $('input[name="hooktype"]:checked').val();	
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var person1 = treeObj.getNodeByParam("id", pPid1, null);
		var person2 = treeObj.getNodeByParam("id", pPid2, null);
		selectnodeidzwj=pPid1;
		if(hooktype!="7"){
			if(person1!=null){
				if(person2!=null){
					treeObj.removeNode(person1);
					if(hooktype!="8"){
						selectnodeidzwj=pPid1;
						zTree.reAsyncChildNodes(person2, "refresh");
						//treeObj.expandNode(person2, true, true, false);
						//treeObj.selectNode(person1);
					}
					else{
						searchzwjbypid(pPid1);
					}
				}
				else{
					treeObj.removeNode(person1);
					searchzwjbypid(pPid1);
				}
			}else{
				searchzwjbypid(pPid1);
			}
		}else{
			if(person1!=null){
				 treeObj.addNodes(person2, person1);
			}else{
				searchzwjbypid(pPid2);
			}
		}
	};
	//保存根节点
	function saveMyPediRoot(){
		$('#saveMyPediRoot').linkbutton('disable');
		var rootName = $('#rootname').val();
		var rootSurname = $('#rootsurname').val();
		var rootGgen = $('#rootggen').val();
		var pediId = $('#peditree').combobox('getValue');
		if(!isStrValid(rootName) || !isStrValid(rootGgen) 
				|| !isStrValid(pediId) || !isStrValid(rootSurname)){
			alert('请检查是否选择了一个族谱，并输入了谱名、世代');
			$('#saveMyPediRoot').linkbutton('enable');
		}
		else if(!isStrValid(userid)){
			alert('您未登录！请登录后再操作！');
			return;
		}
		else{
			$.post('${pageContext.request.contextPath}/tIndividualAction!addRootPerson.action', 
					{rootName: rootName, rootSurname : rootSurname, rootGgen: rootGgen, userId: userid, pediId: pediId}, 
					function(data){
						$('#saveMyPediRoot').linkbutton('enable');
						var rObj = eval('(' + data + ')');
						if(rObj.success){
							closeInputRootDialog();
							var record = {
									pid:$('#peditree').combobox('getValue'),
									text:$('#peditree').combobox('getText')
							};
														
							//initPediTree(record, rObj.obj);	
							var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
							var newNode =treeObj.addNodes(null, rObj.obj);
							treeObj.selectNode(newNode[0]);
							zwj_filltheform(treeObj,newNode[0]);
							//$.fn.zTree.destroy("treeDemo");
							//zTree = $.fn.zTree.init($("#treeDemo"), setting, rObj.obj);	
							//setRelInfo(rObj.obj.nodeRelInfo);
							window.location.reload();
						}
						else{
							alert('增加根节点失败');
						}
			});
			$('#saveMyPediRoot').linkbutton('enable');
		}		
	}
	
	//显示增加根节点的面板
	function addRootNode(){
		$('#input-root-dialog').dialog('open');	
	}
	
	//录入设置面板
	function setInputSetting(){
		$('#input-setting-dialog').dialog('open');
		//加载用户偏好
		$('#input-setting-dialog input[name="maxDepth"]').val(inputSetting.maxDepth);
		if(inputSetting.defaultAlive==true || inputSetting.defaultAlive=='true'){
			$("#input-setting-dialog input[name='defaultAlive'][value='true']").attr("checked", true);				
		}else
			$("#input-setting-dialog input[name='defaultAlive'][value='false']").attr("checked", true);
		if(inputSetting.saveRemind==true || inputSetting.saveRemind=='true'){
			$("#input-setting-dialog input[name='saveRemind'][value='true']").attr("checked", true);				
		}else
			$("#input-setting-dialog input[name='saveRemind'][value='false']").attr("checked", true);
	}
	function saveInputSetting(){		
		var mxDepth = $('#input-setting-dialog input[name="maxDepth"]').val();
		var dftAlive = $('#input-setting-dialog input[name="defaultAlive"]:checked').val();
		var saveRmd = $('#input-setting-dialog input[name="saveRemind"]:checked').val();
		$.post('${pageContext.request.contextPath}/userAction!saveInputSetting.action', 
				{maxDepth: mxDepth, defaultAlive: dftAlive, saveRemind: saveRmd, userId: userid}, 
				function(data){					
					var rObj = eval('(' + data + ')');
					if(rObj.success){						
						//console.info(inputSetting.maxDepth+inputSetting.defaultAlive+dftAlive+save);
						inputSetting.maxDepth = mxDepth;
						inputSetting.defaultAlive = dftAlive;
						inputSetting.saveRemind = saveRmd;						
						$.messager.show({
							title:'提示',
							msg:'录入偏好设置成功'
						});
						setting.async.otherParam = ["depth", mxDepth];
						$.fn.zTree.getZTreeObj("treeDemo").setting.async.otherParam = ["depth",mxDepth];
					}
					else{
						alert('录入偏好设置失败');
					}
		});
		closeInputSettingDialog();
	}
	function saveMother(){		
		var motherId = $('#choosemother').combobox('getValue');		
		if(motherId ==  null || typeof motherId == 'undefined' || motherId == ''){
			$.messager.alert('提示', '请选择母亲');
		}
		var treeId = $('#treeid').val();
		$.post('${pageContext.request.contextPath}/disposalAction!setthemother.action', 
				{sourceId: treeId, choosemother: motherId}, 
				function(data){					
					var dataj = jQuery.parseJSON(data);
					if (dataj.success) {
						$.messager.show({
							title : '提示',
							msg : dataj.msg		
						});						
						//$('#choosemother').combobox('setValue',motherId);//挂上母亲后显示？
						$('#choose-mother-dialog').dialog('close');
						var tree = $.fn.zTree.getZTreeObj("treeDemo");
						var node = tree.getNodeByParam("id", treeId, null);
						var mothernode = tree.getNodeByParam("id", motherId, null);
						var motherName = mothernode.originName;
						//var index=motherName.indexOf("("); 
						//motherName=motherName.substring(0,index);
						node.nodeRelInfo.motherPid = motherId;//挂成功之后更改node.nodeRelInfo.motherPid;使其挂接后正确显示母亲
						node.nodeRelInfo.motherName = motherName;//
						setTemplateContent(node.nodeDetailInfo, node.nodeRelInfo);//显示模板的信息
						//显示母亲和排行的代码						
						var a = mothernode.sex;							
						var showtitle = a=='女' ? '母亲：' : '父亲 ：';
						$('#mother-name').text(showtitle+motherName);
						
						if(node.nodeDetailInfo.arrangenum==undefined){
							$('#arrange-num').text('家中排行：未指定');
						}else
							$('#arrange-num').text('家中排行：' + node.nodeDetailInfo.arrangenum);
					} else {
						$.messager.alert('提示', '指定母亲失败，请重新选择');}
		});
		//需要加入新的功能：更新模板展示上的变化。
		closeInputSettingDialog();
		
	}
	
	function closeInputSettingDialog(){
		$('#input-setting-dialog').dialog('close');
	}
	function closeChangeRankDialog(){
		$('#noderank').val('');
		$('#change-rank-dialog').dialog('close');
	};
	function closeChangeGgenDialog(){
		$('#nodeggen').val('');
		$('#change-ggen-dialog').dialog('close');
	}
	function closeHookDialog(){
		$('#hook-tree-dialog').dialog('close');
	}
	function closeInputRootDialog(){
		//$('input[name=gid]').attr('value', '');
		var form = $('form');
		for(var i=0; i<form.length; i++){
			form[i].reset();
		}
		//alert('重置表单成功');
		$('#rootname').val('');
		$('#rootsurname').val('');
		$('#rootggen').val('');		
		$('#input-root-dialog').dialog('close');
	}
	function closeChooseDialog() {
		$('#choose-mother-dialog').dialog('close');
	};
	function resetAllForm(){
		var form = $('form');
		for(var i=0; i<form.length; i++){
			form[i].reset();
		}
		alert('重置表单成功');
	}
	
	var searchNextTimes = 0;//“搜索下一个”的次数
	var lastSearchCntx = '';//上一次“搜索下一个”的搜索内容，根据该内容和搜索次数来定位到下一个节点上
	/**在人物树中搜索节点，第一次搜索时会从后台查询并载入到树中。
	不是第一次则自动选择到下一个节点*/
	function searchNode(value, type){
		 var st=new Date().getTime();
		if(value == '' || value == undefined){
			$.messager.show({
                title:'提示',
                msg:'请输入搜索内容',
                timeout:1000,
                showType:'slide'
            });
			return false;
		}
		var pediId = $('#peditree').combobox('getValue');
		if(!isStrValid(pediId)){
			$.messager.alert('提示','请先选择族谱');
			return false;
		}
		//上一次查找的内容跟本次的相同，则查找下一个。否则，异步载入并设置lastSearchCntx为value
		var tree = $.fn.zTree.getZTreeObj('treeDemo');
		//var nodeszwjtest = tree.transformToArray(tree.getNodes());//这里说明没有载入圣根下面的那个。。
		if(type == 'nextNode' && lastSearchCntx == value){			
			var nodes = tree.getNodesByParamFuzzy('originName', value, null);
			
			if(nodes.length > searchNextTimes){				
				tree.selectNode(nodes[searchNextTimes]);	
				//需要加滑动条的动作让其移动使得node节点到div的中间add by zwj
				var westtree=parent.document.getElementById('westtree');
				var westtreej=$(westtree);
				var oldx = westtreej.position().top; 
				//console.log(oldx);
				var oldy = westtreej.position().left; 
				//console.log(oldy);
				var nodeid=nodes[searchNextTimes].tId;
				var nodej=$("#"+nodeid);
				var newx = nodej.position().top; 
				//console.log(newx);
				var newy = nodej.position().left; 
				//console.log(newy);
				westtreej.scrollTop(newx-oldx-10);
				westtreej.scrollLeft(newx-oldx-10);
				zwj_filltheform(tree,nodes[searchNextTimes]);
				// add end
				searchNextTimes++;
			}
			else{
				if(nodes.length > 0){
					tree.selectNode(nodes[0]);
					var westtree=parent.document.getElementById('westtree');
					var westtreej=$(westtree);
					var oldx = westtreej.position().top; 
					//console.log(oldx);
					var oldy = westtreej.position().left; 
					//console.log(oldy);
					var nodeid=nodes[0].tId;
					var nodej=$("#"+nodeid);
					var newx = nodej.position().top; 
					//console.log(newx);
					var newy = nodej.position().left; 
					//console.log(newy);
					westtreej.scrollTop(newx-oldx-10);
					westtreej.scrollLeft(newx-oldx-10);
					zwj_filltheform(tree,nodes[0]);
					//add end
					searchNextTimes = 1;//再初始化为1
				}
				else{
					$.messager.show({
						title : '提示',
						msg : '未搜索到结果'					
					});
				}
			}
		}
		
		/** 1).ajax请求返回一个直系继承的路径（1世人物-2世人物----value人物），入坠的该如何处理？
		 *  2)然后在树中从value向上寻找，直到找到树中已存在的离value最近的祖先
		 *	3)载入该祖先到value的所有人物
		 *	4)选择value人物
		 */
		else{
			//
			$.messager.progress();
			lastSearchCntx = value;
			searchNextTimes = 0;
			$.ajax({
				type:'POST',
				url: '${pageContext.request.contextPath}/tRelationAction!getInheritPaths.action',
				async:false,
				data:'pediId='+pediId+'&name='+value,
				success:function(r){
					rObj = eval('(' + r + ')');		
					if(rObj.success){
						var paths = rObj.obj;						
						var hashMap = new Array();
						//循环对paths进行分组，相同根节点的分为一组，保存在hashMap变量中，key为老祖name，value为属于相同分组的path的数组
						for(var i = 0; i < paths.length ; i++){	
							var rootName = paths[i][0].name;//每个路径的根节点name
							if(hashMap[rootName] == undefined){
								var group  = new Array();								
								group.push(paths[i]);
								hashMap[rootName] = group;								
							}
							else{
								hashMap[rootName].push(paths[i]);//								
							}									
						}
						//循环每个分组
						for(var name in hashMap){
							var pathArray = hashMap[name];//二维数组，存有公共根祖先的多条路径
							var pathArrLen = pathArray.length;
							//处理只有一个路径的分组
							if(pathArrLen == 1){
								loadTreePath(pathArray[0]);//长度为1的
								continue;
							}
							loadInheritTree(pathArray, 0);
							continue;
							//
							var cmnAncstorPos = -1;//共同祖先的层数
							maxLength = pathArray[0].length;//初始值	//分组中最长路径的长度
							var ancestor = null;
							//处理有多个路径的分组，循环层数round
							for(var round = 0; round < pathArray[0].length-1; round++) {		
								ancestor = pathArray[0][pathArray[0].length-1-round].name;//初始值为第一个path的倒数第round个人
															
								//循环每个路径，如果只有一个路径那么，上边已处理。
								for(var i = 1; i < pathArray.length; i++){	
									if(round == 0 && pathArray[i].length > maxLength){										
											maxLength = pathArray[i].length;									
									}
									if(ancestor != pathArray[i][pathArray[i].length-1-round].name) {										
										cmnAncstorPos = round;
										break;
									}
								}
								if(cmnAncstorPos == round)
									break;
							}
							var pid = pathArray[0][pathArray[0].length-cmnAncstorPos].pid;	
							var path = new Array();//注意，这里是从共同祖先到根节点的路径
							for(var m = pathArray[0].length-cmnAncstorPos, n = 0; 
									n < cmnAncstorPos; m++,n++){
								path[n] = pathArray[0][m];
							}
							loadChildNodes(path, maxLength-cmnAncstorPos);
							//loadChildNodes(pid, maxLength-cmnAncstorPos);
						}
						$.messager.progress('close');
					}
					else{
						$.messager.show({
							title : '提示',
							msg : '未搜索到结果'					
						});
					} 						
				}
			});
		}
		$.messager.progress("close");
	}
	/***/
	function loadInheritTree(pathArray, start){
		var pathArrLen = pathArray.length;
		var minLen = 10000, minLenIndex = 0;//
		var ztree = $.fn.zTree.getZTreeObj('treeDemo');
		for(var i = 0; i<pathArrLen; i++){
			if(pathArray[i].length<minLen){
				minLen = pathArray[i].length;
				minLenIndex = i;
			}
		} 
		//if(ztree.getNodeByTId(pathArray[0][start].pid) == null){
			//重载[start-1]节点的子树
		//	return;
		//}
		for(var cmnAncestorPos = start; cmnAncestorPos < minLen; cmnAncestorPos++){
			/**如果该层节点都相同，并且不在树中，则重载cmnAncestorPos-1节点子树，并return;
			如果该层节点都相同，并且在树中，则循环进入下一层cmnAncestorPos+1节点
			如果该层节点不全相同，并且不在树中，则重载cmnAncestorPos-1节点子树，并return;
			如果该层节点不全相同，并且在树中，则将相同的分成一组，每一组都调用loadInheritTree*/
			//该层节点未载入到树中
			if(ztree.getNodeByParam('id', pathArray[0][cmnAncestorPos].pid, null) == null){
				//重载[cmnAncestorPos-1]节点的子树				
				var hashPid = new Array();//数组，key为pid，为构造不重复的pid们			
				for(var i = 0; i < pathArrLen; i++){
					var pathLen = pathArray[i].length;
					for(var j = cmnAncestorPos-1; j < pathLen; j++){
						var pid = pathArray[i][j].pid;
						if(hashPid[pid] == undefined){
							hashPid[pid] = pid;
						}
					}
				}
				var pidString = "";
				for(var id in hashPid){	
					pidString = pidString + id + ', ';		
				}
				ztree.setting.async.otherParam = ["paths", pidString.substring(0, pidString.length-2)];//JSON.stringify(pidString)			
				ztree.reAsyncChildNodes(ztree.getNodeByParam('id', pathArray[0][cmnAncestorPos-1].pid, null), "refresh");
				ztree.setting.async.otherParam = ["paths", ""];
				return;				
			}
			//该层的兄弟节点已载入
			else{
				var hash = new Array();//用于分组的hash数组
				for(var whichArr = 0; whichArr < pathArrLen; whichArr++){
					//如果不在
					var id = pathArray[whichArr][cmnAncestorPos].pid;
					if(hash[id] == undefined){
						var group  = new Array();								
						group.push(pathArray[whichArr]);
						hash[id] = group;	
					}
					else{
						hash[id].push(pathArray[whichArr]);
					}
				}
				if(hash.length = 1){//说明该层节点全相等，并且已存在于树中，则进入下一层节点
					continue;
				}
				else{//该层节点不全相等，并且已存在于树中，故递归调用loadInheritTrees
					for(var hashid in hash){
						var groupArrs = hash[hashid];
						loadInheritTree(groupArrs, cmnAncestorPos);
					}
				}
			}			
		}
	}
	/**把id节点载入depth层的树*/
	function loadChildNodes(path, depth){
		var tree = $.fn.zTree.getZTreeObj('treeDemo');		
		
		for(var i = 0; i < path.length; i++ ){
			var node = tree.getNodeByParam('id', path[i].pid, null);
			if(node == null){				
				depth++;
			}
			else
				break;
		}
		if(node != null){
			tree.setting.async.otherParam = ["depth",depth];
			tree.reAsyncChildNodes(node, "refresh");
			tree.setting.async.otherParam = ["depth", inputSetting.maxDepth];
		}
	}
	/**根据path(用数组存包括Id和Name，辈份小的在前)载入人物树(二分法找已经在树上的节点)*/
	function loadTreePath(path){
		var l = path.length;
		var tree = $.fn.zTree.getZTreeObj('treeDemo');
		var nodes = tree.getNodes();
		var small=0;
		//var firstPerson = path[0];
		var found = false;
		var node;
		var large = path.length - 1;
		var curPos;
		var nodetmp = tree.getNodeByParam("id", lastpid, null);
		if(nodetmp!=undefined){
			tree.reAsyncChildNodes(nodetmp, "refresh");
			tree.cancelSelectedNode();
			zwj_filltheform(tree,nodetmp);
			tree.selectNode(nodetmp);
			return;
		}
		while(!found){
			curPos = Math.ceil((large+small)/2);
			node = tree.getNodeByParam("id", Number(path[curPos].pid), null);
			if(typeof node == 'undefined' || node == null||node.length==0){
				if(curPos==large){
					if(curPos!=0){
						node = tree.getNodeByParam("id", Number(path[curPos-1].pid), null);
						found = true;
						curPos=large-1;
						break;
					}
					else{
						$.messager.alert("提示","搜索失败请重试！","warning");
						$.messager.progress("close");
					}
				}
				large = curPos;
				continue;
			}
			else{
				if(curPos == large){
					found = true;
					break;
				}
				else{
					small = curPos;
					continue;
				}				
			}
			if(path[length-1].pid==lastpid){
				issearch=false;
				tree.selectNode(node);
				var westtree=parent.document.getElementById('westtree');
	    		var westtreej=$(westtree);
	    		zwj_filltheform(tree,node);
	    		treeObj.selectNode(node);
	    		var oldx = westtreej.offset().top; 
	    		//console.log(oldx);
	    		var oldy = westtreej.offset().left; 
	    		//console.log(oldy);
	    		var nodeid=node.tId;
	    		var nodej=$("#"+nodeid);
	    		var newx = nodej.offset().top; 
	    		//console.log(newx);
	    		var newy = nodej.offset().left; 
	    		//console.log(newy);
	    		if(newx>oldx){
	    			westtreej.scrollTop((newx-oldx)+oldx/2);
	    		}
	    		if(newy>oldy){
	    			westtreej.scrollLeft((newy-oldy)+oldy/2);
	    		}
	    		 var cc=document.getElementById(nodeid);
	    		    cc.scrollIntoView();
				return;
			}
		}
		var pidString = "";
		for(var i=0;i<path.length;i++){	
			pidString = pidString + path[i].pid + ', ';		
		}
		//tree.setting.async.otherParam = ["paths", pidString.substring(0, pidString.length-2)];
		var depthtmp=path.length -curPos;
		var depth = inputSetting.maxDepth >= depthtmp ? inputSetting.maxDepth : depthtmp;//载入多少层
		var oldParam=tree.setting.async.otherParam;
		//if(tree.setting.async.otherParam.depth!=null){
			//tree.setting.async.otherParam.depth=depth;
		//}
		//else{
			//tree.setting.async.otherParam["depth"]=depth;
		//}
		tree.setting.async.otherParam = ["paths", pidString.substring(0, pidString.length-2)];
		tree.reAsyncChildNodes(node, "refresh");
		tree.setting.async.otherParam = oldParam;
	}
	
</script>
<link rel="stylesheet" href="<%=path %>/css/zTreeStyle/zTreeStyle.css"
	type="text/css"></link>
<style type="text/css">
.ztree li span.button.add {
	margin-left: 2px;
	margin-right: -1px;
	background-position: -144px 0;
	vertical-align: top;
	*vertical-align: middle
}
.pedispan {
	<%--position:relative;
	width:200px;
	height:30px;
	margin-top:5px;--%>
}
</style>
<jsp:include page="/input/tree/createTree.jsp"></jsp:include>

<div class="ind-tree" id="treecontainerzwj">
<div style="height:80px;z-index:999;background-color:white;">
<div id="treecomzwj" style="position:absolute;top:5%;left:0%;z-index:999;background-color:white;">
<span class='pedispan' style="display:inline-block;margin-top:3px;">
	<label for="peditree">选择族谱：</label>
	<select id="peditree" name="peditree" style="width:150px;" autofocus="autofocus"></select>
	</span>
	<span class='pedispan' style="display:inline-block;margin-left:10px;margin-right:10px;">	
		<a href="javascript:void(0)" class="easyui-linkbutton" id="addrootnode" onclick="addRootNode()" 
			data-options="disabled:true">增加根人物</a>	
	</span>
	<span class='pedispan' style="display:inline-block;margin-left:10px;margin-right:10px;">	
		<a href="javascript:void(0)" class="easyui-linkbutton" id="setinputsetting" onclick="setInputSetting()"
			data-options="disabled:true">录入设置</a>	
	</span>		
	<span class='pedispan' style="">	
		<input id="search-node" class="easyui-searchbox"
							data-options="prompt:'输入谱名',width:'30px',menu:'#searchType',searcher:doSearchzwj"
							style=""></input>	
		<div id="searchType">
        	<div data-options="name:'nextNode'">找下一个</div>
        	<div data-options="name:'reSearch'">重载结果</div>
    	</div>					
	</span>	
</div>
</div>
<div>
<span>
	<ul id="treeDemo" class="ztree">
	</ul>
	</span>
</div>
</div>

<div id="input-root-dialog" class="easyui-dialog"
		data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#dlg-input-root-buttons', 
		onClose:function(){
			var form = $('form');
			var j=form.length;
			while(j>0){
				form[j-1].reset();j--;
				}
		}" title="录入根节点简要信息"
		style="width:300px;height:180px;padding:10px">
		<table>
		<tr><td>
		<label>谱&nbsp;&nbsp;&nbsp;&nbsp;名：</label><input id="rootname" class="easyui-validatebox" required="true"
					data-options="validType:'lengthRange[1,20]'"></input> 
		</td></tr>
		<tr><td>
		<label>姓&nbsp;&nbsp;&nbsp;&nbsp;氏：</label><input id="rootsurname" class="easyui-validatebox"	required="true"
					data-options="validType:'lengthRange[1,20]'"></input> 	
		</td></tr>
		<tr><td>
		<label>世&nbsp;代&nbsp;数：</label><input id="rootggen" class="easyui-validatebox"	required="true"
					data-options="validType:'numRange[1, 1000]'"></input> 	
		</td></tr>
		</table>		
		
		<div id="dlg-input-root-buttons">
		<!-- add by zwj 可以使用SXT文件加入到数据库中去新的节点-->
		<a href="javascript:void(0)" class="easyui-linkbutton" id="saveMyPediRoot" onclick="importPersonbyd(1)">从文件中导入</a>
		<!--end-->
			<a href="javascript:void(0)" class="easyui-linkbutton" id="saveMyPediRoot" onclick="saveMyPediRoot()">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="closeInputRootDialog()">取消</a>
		</div>		
</div>

<div id="input-setting-dialog" class="easyui-dialog"
		data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#setting-dlg-buttons'" title="录入设置"
		style="width:400px;height:200px;padding:10px">
		<label>默认加载最大层数：</label><input name="maxDepth" class="easyui-validatebox"
			data-options="validType:'numRange[0, 100]'"></input> 
		<label>默认生卒：</label><label>生</label> <input type="radio" checked="checked"
					name="defaultAlive" value="true" /> <label>卒</label> <input
					type="radio" name="defaultAlive" value="false" />
		<label>录入保存提示：</label><label>是</label> <input type="radio" checked="checked"
					name="saveRemind" value="true" /> <label>否</label> <input
					type="radio" name="saveRemind" value="false" />
		<div id="setting-dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" id="saveInputSetting" onclick="saveInputSetting()">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="closeInputSettingDialog()">取消</a>
		</div>		
</div>
	<div id="zwjlogin-dialog" class="easyui-dialog"
		data-options="title:'登陆',closed:true,closable:false,modal:true, buttons:[{
  				text:'取消',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#zwjloginForm')[0].reset();
  				}
  			},{
  				text:'登陆',
  				iconCls:'icon-help',
  				handler:function(){
  				
  				$('#zwjloginForm').submit();
  				}
  				}]" style="width:250px;height:150px;">
		<form id="zwjloginForm" method="post">
			<table cellpadding="5">
				<tr>
					<th>登录名</th>
					<td style="width:100px"><input name="username" class="easyui-validatebox"
						data-options="required:true,missingMessage:'登陆名称必填'"/></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input type="password" name="password"
						class="easyui-validatebox"
						data-options="required:true,missingMessage:'密码必填'"/></td>
				</tr>
			</table>
		</form>
	</div>
<div id="mm" class="easyui-menu" style="width:120px;">
	<div id="removemenu" data-options="name:'removemenu'">删除该支</div>
</div>
<div id="hidden" align="center" style="display:'none'">
	<form id="individualTree-id-form" method="get">
		<input type="hidden" id="treeid" name="treeid" />
	</form>	
</div>

<div id="change-rank-dialog" class="easyui-dialog"
		data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#dlg-buttons'" title="更改排行"
		style="width:400px;height:200px;padding:10px">
		<label id="nodename">排行数：</label><input id="noderank" class="easyui-validatebox"
			data-options="validType:'numRange[1, 100]'"></input> 
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" id="saveRank" onclick="saveRank()">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="closeChangeRankDialog()">取消</a>
		</div>		
</div>

<div id="change-ggen-dialog" class="easyui-dialog"
		data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#ggen-dlg-buttons'" title="更改世代"
		style="width:400px;height:200px;padding:10px">
		<label id="ggen-nodename">世代数：</label><input id="nodeggen" class="easyui-validatebox"
			data-options="validType:'numRange[1, 1000]'"></input> 
		<div id="ggen-dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" id="saveGgen" onclick="saveGgen()">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="closeChangeGgenDialog()">取消</a>
		</div>		
</div>
<div id="hook-tree-dialog" class="easyui-dialog"
		data-options="href:'hookTree.jsp',modal:true,closed:true,iconCls:'icon-save',buttons:'#hook-dlg-buttons'" title="搜索挂接"
		style="width:800px;height:500px;padding:10px">
		<%--<jsp:include page="hookTree.jsp"></jsp:include>
		--%><div id="hook-dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton" id="saveNewRelation" onclick="saveNewRelation()">提交</a>
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="closeHookDialog()">取消</a>
		</div>		
</div>

<div id="choose-mother-dialog" class="easyui-dialog"
		data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#choose-mother-buttons'"
		title="选择母亲" style="width:200px;height:200px;padding:10px">
		<label for="choosemother">选择母亲：</label> 
		<select id="choosemother" class="easyui-combobox" data-options="
				valueField : 'pid',
				textField : 'text',
				required : true,
				missingMessage : '请选择母亲'
		" style="width:100px"></select>		

	<div id="choose-mother-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			id="choosethemother" onclick="saveMother()">确定</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			onclick="closeChooseDialog()">取消</a>
	</div>
</div>
<!-- add by zwj -->
<div id="choose-import-dialog" class="easyui-dialog"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		title="选择导入文件" style="width:380px;height:100px;padding:10px;position:relative;">
		  <form id="choose-import-form" method="post" enctype="multipart/form-data">
		  <input type='text' name='textfield' id='textfield' class='txt' />  
		  <a id="viewbtnzwj" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">浏览...</a>
    <input type="file" name="myFile" class="file" id="myFile" size="28" onchange="document.getElementById('textfield').value=this.value" />
 <input type="hidden" id="ggenzwj" name="ggenzwj"/>
 <input type="hidden" id="pidzwj" name="pidzwj"/>
 <input type="hidden" id="gidzwj" name="gidzwj"/>
 <input type="hidden" id="useridzwj" name="useridzwj"/>
  <a id="zwjsubmit" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="$('#choose-import-form').submit();">导入</a>
		  <!--  
 	<input type='text' name='textfield' id='textfield' class='txt' />  
 	<a href="javascript:void(0)" class="easyui-linkbutton">浏览...</a>
    <input type="file" name="fileField" class="file" id="fileField" size="28" onchange="document.getElementById('textfield').value=this.value" />
 	<a href="javascript:void(0)" class="easyui-linkbutton"
			id="choosethemother" onclick="importPersonservice()">确定&nbsp;&nbsp;&nbsp;&nbsp;</a>
			-->
 	</form>
</div>
<div id="choose-export-dialog" class="easyui-dialog"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		title="选择导出位置" style="width:380px;height:100px;padding:10px;position:relative">
		  <object id="fileUploader" classid="clsid:A8F4FF40-E558-4209-9324-D2F92A357756" codebase="PedigreePlugins.CAB#version=1,0,0" style="display: none;"></object>
		  <input type='text' name='local_path' id='local_path' class='txt' />
		  <a id="viewbtnzwj" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="getLocalBackupDir()">浏览...</a>
		   <a id="exportbtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="exportdatazwj()">导出</a>
</div>
<div id="searchresultdialog" class="easyui-dialog" data-options="modal:true,closed:true"
		title="多个结果，请选择一个" style="width:650px;height:230px">
					<div class="divRowInCol"
						style="height:160px;border:1px solid gray;">						
						<table class="easyui-datagrid" id="searchpersonzwj"
							data-options="rownumbers:true,fit:true,pagination:'true',singleSelect: true, checkOnSelect:true,selectOnCheck:true">
							<thead>
								<tr class="datagrid-header">
									<th data-options="field:'ck',checkbox:true"></th>
									<th data-options="field:'name',sortable:true,width:100">谱名</th>
									<th data-options="field:'fathername',sortable:true,width:100">父亲谱名</th>
									<th data-options="field:'pid',hidden:true,width:50">人物编号</th>									
									<th data-options="field:'sex',width:50">性别</th>
									<th data-options="field:'ggen',width:50">世代数</th>
									<th data-options="field:'arrangenum',width:50">排行数</th>									
									<%--<th data-options="field:'fullname',width:100">姓名</th>
									<th data-options="field:'givenname',width:50">名</th>
									<th data-options="field:'nickname',width:50">字</th>
									<th data-options="field:'title',width:50">号</th>
									<th data-options="field:'huiname'">讳</th>
									<th data-options="field:'borntime'">出生时辰</th>
									<th data-options="field:'bornplace'">出生地</th>
									<th data-options="field:'borndsc'">出生描述</th>
									<th data-options="field:'islive'">生死状况</th>
									<th data-options="field:'deathday'">去世日期</th>
									<th data-options="field:'deathplace'">卒地</th>
									<th data-options="field:'graveyard'">葬地及朝向</th>
									<th data-options="field:'deathtime'">去世时辰</th>
									<th data-options="field:'deathdsc'">卒世概述</th>
									<th data-options="field:'deathname'">谥号</th>
									<th data-options="field:'education'">文化程度</th>
									<th data-options="field:'officialtitle'">职称</th>
									<th data-options="field:'duty'">职务</th>
									<th data-options="field:'homeplace'">居住地</th>
									<th data-options="field:'homeplacedsc'">居住地描述</th>
									<th data-options="field:'lifedsc'">生平概述</th>
									<th data-options="field:'remark'">备注</th>
									<th data-options="field:'endmark'">尾注</th>

								--%></tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
					<div align="center">
					<a href="javascript:void(0)" class="easyui-linkbutton" id="choosethecrrectperson" onclick="choosecrrectpzwj()">确定</a>
				<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="$('#searchresultdialog').dialog('close');">取消</a>
					</div>
</div>
<script type="text/javascript">
var hasjiazai=false;
var isguajie=false;
var lastpid=0;
var lastSearchzwj = '';
//add by zwj;搜索出来多个人物的时候通过对话框选择去选择录入员需要搜索的人物
function choosecrrectpzwj(){
	var selectedrow=$("#searchpersonzwj").datagrid("getSelected");
	if(selectedrow==null){
		$.messager.alert("提示","请先选择你要搜索的人物再点确定","warning");
		return false;
	}
	else{
		$('#searchresultdialog').dialog('close');
		var pid=selectedrow.pid;
		$.ajax({
			type:'POST',
			url: '${pageContext.request.contextPath}/tRelationAction!getInheritPathsbyperson.action',
			async:false,
			data:'pid='+pid,
			success:function(r){
				rObj = eval('(' + r + ')');		
				if(rObj.success){
					var path = rObj.obj;		
					if(path!=null)
					{
						hasjiazai=true;
						lastpid=pid;
						$.messager.progress();
						loadTreePath(path);
					//selectthesearchnode(pid);
					//selectthesearchnode(pid);
					//var value=lastSearchzwj;
					//doSearchzwj(value);
					}
					else{
						$.messager.show({
							title : '提示',
							msg : '未搜索到结果,请检查您输入的名字！'					
						});
					}
					
				}
				else{
					$.messager.show({
						title : '提示',
						msg : '未搜索到结果,请检查您输入的名字！'					
					});
				} 						
			}
		});
	}
}
//专门作为挂接的时候如果目标节点没有加载进来的话，就去异步的加载数据。
function searchzwjbypid(pid){
	$.ajax({
		type:'POST',
		url: '${pageContext.request.contextPath}/tRelationAction!getInheritPathsbyperson.action',
		async:false,
		data:'pid='+pid,
		success:function(r){
			rObj = eval('(' + r + ')');		
			if(rObj.success){
				var path = rObj.obj;		
				if(path!=null)
				{
					isguajie=true;
					lastpid=pid;
					loadTreePath(path);
				}
				else{
					$.messager.show({
						title : '提示',
						msg : '挂接未成功，请检查目标节点是否存在！'					
					});
				}
				
			}
			else{
				$.messager.show({
					title : '提示',
					msg : '挂接未成功，请重试！'					
				});
			} 						
		}
	});
}
//add by zwj;人物搜索时候先搜索到该人名的人物。
function doSearchzwj(value) {
	var tree = $.fn.zTree.getZTreeObj('treeDemo');
		if(value == '' || value == undefined){
			$.messager.show({
                title:'提示',
                msg:'请输入搜索内容',
                timeout:1000,
                showType:'slide'
            });
			return;
		}
		issearch=true;
		lastSearchzwj=value;
			$.post(searchAction, {
				searchName : value, 
				pediId : $('#peditree').combobox('getValue')
			}, function(data) {
				var rData = jQuery.parseJSON(data)	;
				if (rData.success) {				
					var row=rData.obj.rows;
					if(row.length==1){
						var row0=row[0];
						var pid=row0.pid;
						$.ajax({
							type:'POST',
							url: '${pageContext.request.contextPath}/tRelationAction!getInheritPathsbyperson.action',
							async:false,
							data:'pid='+pid,
							success:function(r){
								rObj = eval('(' + r + ')');		
								if(rObj.success){
									var path = rObj.obj;		
									if(path!=null)
									{
										hasjiazai=true;
										lastpid=pid;
										$.messager.progress();
									loadTreePath(path);
									//loadChildNodes(path, 0);
									//selectthesearchnode(pid);
									//$.messager.progress();
									//selectthesearchnode(pid);
									//$.messager.progress("close");
									}
									else{
										$.messager.show({
											title : '提示',
											msg : '未搜索到结果,请检查您输入的名字！'					
										});
									}
								}
								else{
									$.messager.show({
										title : '提示',
										msg : '未搜索到结果,请检查您输入的名字！'					
									});
								} 						
							}
						});
					}
					else{
						$('#searchresultdialog').dialog('open');
						$('#searchpersonzwj').datagrid('loadData',rData.obj);
						
					}
				} else {
					alert(rData.msg);
					$('#zwjlogin-dialog').dialog('open');
				}
			});
	}
function selectthesearchnode(pid) {
	var tree = $.fn.zTree.getZTreeObj('treeDemo');
	tree.expandAll(true);
	var nodes =  tree.getNodeByParam("id", pid, null);
	if(nodes!=null){				
		tree.selectNode(nodes);	
		//需要加滑动条的动作让其移动使得node节点到div的中间add by zwj
		var westtree=parent.document.getElementById('westtree');
		var westtreej=$(westtree);
		var oldx = westtreej.position().top; 
		//console.log(oldx);
		var oldy = westtreej.position().left; 
		//console.log(oldy);
		var nodeid=nodes.tId;
		var nodej=$("#"+nodeid);
		var newx = nodej.position().top; 
		//console.log(newx);
		var newy = nodej.position().left; 
		//console.log(newy);
		westtreej.scrollTop(newx-oldx-10);
		westtreej.scrollLeft(newx-oldx-10);
		zwj_filltheform(tree,nodes);
		// add end
		return;
	}
	else{
		tree.expandAll(true);
		selectthesearchnode(pid);
	}
}
//add by zwj
//用来导入数据前对表单的填充
function importPersonbyd(i){
	$('#useridzwj').val(userid);
	var gid = $('#peditree').combobox('getValue');
	$('#gidzwj').val(gid);
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	if(treeObj!=undefined){
		var sNodes = treeObj.getSelectedNodes();
		if (sNodes.length > 0) {
			var nodes=sNodes[0];
			$('#ggenzwj').val(nodes.nodeDetailInfo.ggen);
			$('#pidzwj').val(nodes.nodeDetailInfo.pid);
				}
		else{
			$('#ggenzwj').val(0);
			$('#pidzwj').val(0);
			}
	}
	else{
		$('#ggenzwj').val(0);
		$('#pidzwj').val(0);
		}
	if(i=1){
		$('#ggenzwj').val(0);
	}
	$('#choose-import-dialog').dialog('open');
	
}
function ExportData(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var sNodes = treeObj.getSelectedNodes();
	if(sNodes.length > 0){
		$('#choose-export-dialog').dialog('open');
	}else{
		alert("请选择一个导出的根节点！");
	}
}
function exportdatazwj(){
	var localpath=$('#local_path').val();
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var sNodes = treeObj.getSelectedNodes();
	var node;
	if(sNodes.length > 0){
		node=sNodes[0];
	}
	else{
		alert("请选择一个导出的根节点！");
		return;
	}
	if(localpath==""){
		alert("请选择一个导出位置！");
		return;
	}else{
		$("#viewbtnzwj").attr("disabled",true); 
		$("#exportbtn").attr("disabled",true); 
		$('#choose-export-dialog').dialog({modal:false});
		$('#choose-export-dialog').dialog('close');
		$.messager.progress();
		$.ajax({
			async : false,
			cache : false,
			type : 'post',
			data : 'pid=' + node.id+'&userid='+userid,
			url : '${pageContext.request.contextPath}/tRelationAction!exportdata.action',//请求的action路径  
			beforeSend: function(){
				  $.messager.progress();
			},
			error : function() {//请求失败处理函数  
				$.messager.progress('close');
				alert('导出数据失败，请检查网络！');
			},
			success : function(j) { //请求成功后处理函数。  
				$.messager.progress('close');
				var rObj = eval('(' + j + ')');
				if(rObj.success){
					var uploader = document.getElementById('fileUploader');
					var type = uploader.FtpDownload(localpath, rObj.obj, '<%=ServerIP%>', '/exportdatafiles/', '<%=FTPUserName%>', '<%=FTPPassword%>','<%=FTPPort%>');
					
					if(type==0){
						$.messager.show({
							title:'提示',
							msg:'导出数据成功，文件名为!'+rObj.obj,
							timeout:10000
						});
					}
					else{
						alert("从服务器下载导出文件出现问题，请重试！");
						$.messager.progress('close');
						$('#choose-export-dialog').dialog('open');
					}
				}else{
					$.messager.show({
						title:'提示',
						msg:'导出数据失败!'
					});
					$.messager.progress('close');
					$('#choose-export-dialog').dialog('open');
				}
				
			}
		});
		$("#viewbtnzwj").attr("disabled",false);
		$("#exportbtn").attr("disabled",false);
	}
}
function getLocalBackupDir() {
    var uploader = document.getElementById('fileUploader');
  	var localpath = uploader.getDownloadPath();
  	if (localpath == "ERROR") {
  		document.getElementById('local_path').innerText = "";
  	} else {
  		document.getElementById('local_path').innerText = localpath;
  	}
  }
function importPersonservice(){
	alert("yes");
}
function closeImprotDialog(){
	$('#choose-import-dialog').dialog('close');
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
	var info=sizi + tiaozi + nodeRelInfo.hasSpecialRelDesc;
	if(info.indexOf("配偶")>0)
	   {
	     var repalce=info.substr(2,4);
	   }
	info=info.replace(repalce,"");
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
	treeObj.selectNode(treeNode);
}
//end
</script>




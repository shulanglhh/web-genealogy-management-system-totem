<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<script type="text/javascript"
	src="<%=path %>/jslib/jquery.dragsort-0.5.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/jslib/mousetrap.min.js"></script>
<script type="text/javascript" src="<%=path %>/jslib/mousetrap-global-bind.min.js"></script>

<style>
input{
	background-color: transparent;   
	border:  1px solid;
}
textarea{
	background-color: transparent;   
	border:  1px solid;
}
select{
	background-color: transparent;   
	border:  1px solid;
}
</style>
<div id="containzwj" style='background-color: white;opacity:0.7;z-index:500;position:absolute;width:100%;height:100%;top:0;left:0'></div>
 <div id='backzwj' style="float:left;position:absolute;z-index:500">
 </div>
<div class="easyui-tabs" id="input-tabs" data-options="fit:true">
	<div title="快捷键录入" data-options="iconCls:'icon-save'" style="width:670px;padding:10px" id="hotkeyForm">	
		<jsp:include page="hotkeyForm.jsp"></jsp:include>
	</div>
	<div title="精简录入" data-options="href:'simpleForm.jsp',iconCls:'icon-save'" style="width:670px;padding:10px">	
		<%--<jsp:include page="simpleForm.jsp"></jsp:include>--%>
	</div>
	<%--<div title="常规录入" data-options="href:'commonForm.jsp', iconCls:'icon-save'" style="padding:10px">
		<jsp:include page="commonForm.jsp"></jsp:include>
	</div>--%>
	<div title="苏式对照" data-options="href:'suCompareForm.jsp', iconCls:'icon-save'" style="padding:10px">
		<%--<jsp:include page="suCompareForm.jsp"></jsp:include>
	--%></div>
	<div title="快捷录入" data-options="href:'fastForm.jsp', iconCls:'icon-save'" style="padding:10px">
		<%--<jsp:include page="fastForm.jsp"></jsp:include>
	--%></div>
	<div title="入谱登记表录入" id="tableFormTab",
		data-options="href:'tableForm.jsp',iconCls:'icon-save',
			tools:[{
				iconCls:'icon-reload',
				handler:function(){
					$('#tableFormTab').panel('refresh','tableForm.jsp');
				}
			}]
		" 
		style="padding:10px">
		<%--<jsp:include page="tableForm.jsp"></jsp:include>
	--%></div>
	<%--<div title="入" data-options="href:'datagridEditTest.jsp'" style="padding:10px">
		<jsp:include page="tableForm.jsp"></jsp:include>
	</div>
--%></div>
<script type="text/javascript">
$('#input-tabs').tabs({
	onSelect:function(title, index){
		//if(index==0){
			//Mousetrap.unpause();
		//}
		//else{
			//Mousetrap.pause();
		//}
		var tree = $.fn.zTree.getZTreeObj('treeDemo');
		if(tree!=undefined&&tree!=[]){
			var nodes = tree.getSelectedNodes();
			var tid='#'+nodes[0].tId+'_a';
			$(tid).click();
			if(index==0){
				var tmp=$('#data-input-table input[name=name]').val();
				$('#data-input-table input[name=name]').val("").focus().val(tmp);
			}else if(index==1){
				var tmp=$('#simple-individual-form input[name=name]').val();
				$('#simple-individual-form input[name=name]').val("").focus().val(tmp);
			}else if(index==2){
				var tmp=$('#su-individual-form input[name=name]').val();
				$('#su-individual-form input[name=name]').val("").focus().val(tmp);
			}else if(index==3){
				var tmp=$('#fast-individual-form input[name=name]').val();
				$('#fast-individual-form input[name=name]').val("").focus().val(tmp);
			}
		}
	}
});
	var formChanged = false;
	$("form input, select").change(function(){			
		formChanged = true;
		//console.info(formChanged + " formchaged work!!!");
	});	
	//$(document).delegate("form input[type='checkbox']","click");
	$("form input[type='checkbox']").click(function(){
		
		if($(this).attr("checked"))
			$(this).attr("value", true);
		
		else
			$(this).attr("value", false);
	});
	
	function submitForm(type, formId){
		var pediId = $('#peditree').combobox('getValue');
		if(!isStrValid(pediId)){
			$.messager.alert('提示','请先选择族谱');
			return false;
		}
		$("input[name=gid]").attr("value", pediId);
		var sNodes = $.fn.zTree.getZTreeObj("treeDemo").getSelectedNodes();
		if (sNodes.length<=0) {
			$.messager.alert('提示','请选中一个节点再提交');
			return false;
		}
		window.setTimeout(function() {
			$(formId+' input[name=sex]').focus();
		}, 0);
		var typeValid = checkSubmitType(type);
		if(!typeValid){
			$.messager.show({
				title : '提示',
				msg : '注意：不能给配偶节点添加兄妹或配偶！'		
			});
			return typeValid;
		}
		var formValid = $(formId).form('validate');
		if (!formValid){
			return formValid;	// return false will stop the form submission
		}		
		var inputperson = $(formId+' input[name=inputperson]').val();
		var gid = $(formId+' input[name=gid]').val();
		if(!isStrValid(inputperson) || !isStrValid(gid)){//inputperson 和gid的判断
			if(!(gid>0) || !(inputperson>0)){
				alert('您未登录，或未选择族谱');
				return false;	
			}
		}
		//验证通过需要判断该人物表单是否发生变化，若变化则更新该人物，否则不向服务器提交
		if(formChanged){			
			$("input[name=formchanged]").attr("value", true);
			var t = $("input[name=formchanged]").attr("value");
			//console.info("formchanged true?"+t);
		}else{
			//console.info("formchanged false!!!");
			$("input[name=formchanged]").attr("value", false);
		}	
		if(!formChanged && type==1){
			//console.info("表单未变化，将不提交");
			$.messager.show({
				title : '提示',
				msg : '表单未变化，将不会保存！'		
			});
			return false;
		}
		if(!formChanged){
			;//不提交，设置表单等信息。
		}
		
		//设置提交类型1：保存；2：添加子女；3：添加兄妹；4添加配偶;5增加侧室
		$("input[name=submittype]").attr("value", type);
		if(formChanged && inputSetting.saveRemind == "true"){
			if(confirm("确认保存 " + $("input[name='name']").val() + "吗 ？")){
				;
			}
			else
				return false;
		}
		Mousetrap.pause();
		$.messager.progress();	
		$(formId).submit();	
		//add by zwj 是为了每次更新表单的时候要立刻更新其模板的信息doesnot work
		//updatethetemplet();
		//add end
	}
	//提交时做验证，验证：1.输入验证;2.验证添加配偶->添加配偶、添加配偶->添加兄妹(需要判断按钮的类型:添加配偶还是添加兄妹)
	function checkSubmitType(type){
		var isAlien = $("input[name=isalien]").attr('value');
		var fatherPid = $("input[name=fatherpid]").attr('value');
		var isFemale = $('input:radio[name="sex"]:checked').val() == "男" ? false : true; //是否女性，但是有几个表单，而只有一个表单被选中。。
		if(type==3||type==4||type==5){//选择的操作是 添加兄妹或者添加配偶			
			if(isAlien == "true"){//当前人物是外族人
				return false;//验证不通过
			}
		}
		/*if(type==2||type==4){//选择的操作是 添加儿女或者添加配偶
			if(isFemale == true && isAlien != "true" && fatherPid > 0){//当前人物是女性，且不是配偶，是某人的女儿
				return false;
			}
		}*/
		return true;
	}
	
	function resetForm(formId){
		$(formId)[0].reset();
	}
	
	$.extend($.fn.validatebox.defaults.rules, {   
	    maxLength: {   
	        validator: function(value, param){   
	            return value.length <= param[0];   
	        },   
	        message: '不能超过 {0} 个字符'  
	    }   
	});  
	
	//填充表单
	function fillForm(r){		
		$("input[name='gid']").val(r.gid);
		$("input[name='ggen']").val(r.ggen);
		$("input[name='grpid']").val(r.grpid);//设置世代数！！！
		$("input[name='name']").val(r.name);
		$("input[name='surname']").val(r.surname);
		$("input[name='fullname']").val(r.fullname);
		$("input[name='photoid']").val(r.photoid);
		
		$("input[name='nickname']").val(r.nickname);
		$("input[name='givenname']").val(r.givenname);
		$("input[name='title']").val(r.title);
		if($.trim(r.sex)=="男"){
			$("form input[name='sex'][value='男']").attr("checked", true);
		}else{
			$("form input[name='sex'][value='女']").attr("checked", true);			
		}
		if(r.islive){
			$("form input[name='islive'][value='true']").attr("checked", true);				
		}else
			$("form input[name='islive'][value='false']").attr("checked", true);
		
		$("input[name='birthday']").val(r.birthday);
		$("[name='borntime']").val(r.borntime);		
		$("input[name='deathday']").val(r.deathday);
		$("[name='deathtime']").val(r.deathtime);
		
		$("input[name='bornplace']").val(r.bornplace);
		$("input[name='deathplace']").val(r.deathplace);
		$("input[name='borndsc']").val(r.borndsc);
		$("input[name='deathdsc']").val(r.deathdsc);
		$("[name='remark']").val(r.remark);
		$("[name='endmark']").val(r.endmark);
		$("input[name='huiname']").val(r.huiname);
		$("input[name='deathname']").val(r.deathname);
		$("input[name='ranknum']").val(r.ranknum);
		$("input[name='arrangenum']").val(r.arrangenum);
		//alert($("input[name='arrangenum']").val());
		$("input[name='spousedsc']").val(r.spousedsc);
		//$("input[name='genword']").val(r.genword);//在数据库对象中没有genword属性
		$("input[name='education']").val(r.education);
		$("input[name='homeplace']").val(r.homeplace);
		$("input[name='homeplacedsc']").val(r.homeplacedsc);
		$("input[name='duty']").val(r.duty);
		$("input[name='officialtitle']").val(r.officialtitle);
		$("input[name='lifedsc']").val(r.lifedsc);
		$("input[name='graveyard']").val(r.graveyard);
		$("input[name='deathname']").val(r.deathname);
		$("input[name='branch']").val(r.branch);
		$("input[name='page']").val(r.page);
		$("input[name='shire']").val(r.shire);
		$("input[name='arrangedsc']").val(r.arrangedsc);
		$("input[name='rankdsc']").val(r.rankdsc);
		$("input[name='dna']").val(r.dna);
		$("input[name='bloodtype']").val(r.bloodtype);
		$("input[name='photo']").val(r.photo);
		$("input[name='birthdaydetail']").val(r.birthdaydetail);
		$("input[name='endnote']").val(r.endnote);
		$("input[name='othername']").val(r.othername);
		$("input[name='otherinfo']").val(r.otherinfo);
		
		if(r.hiddenchild){
			$("input[name='hiddenchild']").attr("checked", true);
			$("input[name='hiddenchild']").attr("value", true);
			$("input[name='hiddenchildzwj']").attr("checked", true);
			$("input[name='hiddenchildzwj']").attr("value", true);
		}
		else{
			$("input[name='hiddenchild']").attr("checked", false);
			$("input[name='hiddenchild']").attr("value", false);
			$("input[name='hiddenchildzwj']").attr("checked", false);
			$("input[name='hiddenchildzwj']").attr("value", false);
		}
		if(r.inbiology){
			$("input[name='inbiology']").attr("checked", true);
			$("input[name='inbiology']").attr("value", true);
		}
		else{
			$("input[name='inbiology']").attr("checked", false);
			$("input[name='inbiology']").attr("value", false);
		}
		if(r.inrelation){
			$("input[name='inrelation']").attr("checked", true);
			$("input[name='inrelation']").attr("value", true);
			$("input[name='inrelationzwj']").attr("checked", true);
			$("input[name='inrelationzwj']").attr("value", true);
		}
		else{
			$("input[name='inrelation']").attr("checked", false);
			$("input[name='inrelation']").attr("value", false);
			$("input[name='inrelationzwj']").attr("checked", false);
			$("input[name='inrelationzwj']").attr("value", false);
		}
		if(r.inbiography){
			$("input[name='inbiography']").attr("checked", true);
			$("input[name='inbiography']").attr("value", true);
			$("input[name='inbiographyzwj']").attr("checked", true);
			$("input[name='inbiographyzwj']").attr("value", true);
		}
		else{
			$("input[name='inbiography']").attr("checked", false);
			$("input[name='inbiography']").attr("value", false);
			$("input[name='inbiographyzwj']").attr("checked", false);
			$("input[name='inbiographyzwj']").attr("value", false);
		}
		//$("input[name='endnote']").val(r.endnote);//在数据库对象中没有尾注属性			
		formChanged = false;//全局变量用于在提交时判断表单内容是否因人为输入而更改
	}
	function setRelInfo(relInfo){		
		$("input[name='curpid']").attr("value", relInfo.curPid);
		$("input[name='fatherpid']").attr("value", relInfo.fatherPid);
		$("input[name='motherpid']").attr("value", relInfo.motherPid);
		$("input[name='matepid']").attr("value", relInfo.matePid);
		$("input[name='isalien']").attr("value", relInfo.isAlien);			
	}
	
	
	$.extend($.fn.validatebox.defaults.rules, {   
	    lengthRange: {   
	        validator: function(value, param){  
	        	var len = value.length;
	            return ((len >= param[0]) && len<= param[1]);   
	        },   
	        message: '字数范围：{0} - {1}'  
	    }   
	}); 
	
	$.extend($.fn.validatebox.defaults.rules, {   
	    numRange: {   
	        validator: function(value, param){  
	        	 if (value!=null && value!="")	{        	   
	        	     if(!isNaN(value)){
	        	    	 return ((value >= param[0]) && value<= param[1]);   
	        	     }	   	        	     
	        	 }  	    
	        	 return false;	           
	        },   
	        message: '请输入{0} - {1}范围的数字'  
	    }   
	});

	function setCurPid(pid){		
		$("input[name=curpid]").attr("value",pid);
	};
	function setFatherPid(pid){
		$("input[name=fatherpid]").attr("value",pid);
	};
	function setMotherPid(pid){
		$("input[name=motherpid]").attr("value",pid);
	};
	function setMatePid(pid){
		$("input[name=matepid]").attr("value",pid);
	};
	function setIsAlien(isAlien){
		//console.info("seIsAlien"+isAlien);
		$("input[name=isalien]").attr("value", isAlien);
	};
	
	function nodeChanged(){
		alert("要实现判断表单内容是否变化的代码！");
		return true;//未变化返回false
	};
	//支持添加女婿，当女儿添加子女时，fatherPid为女儿pid，motherPid为女婿的Pid
	function addVirtualNodeByInfo(relInfo){		
		var parentId = 0;
		var isSpouse = false;
		if(relInfo.curPid>0)//如果关联信息的当前人物id大于0说明是更新一个人物。不应增加虚拟节点
			return;				
		if(relInfo.isAlien==true && relInfo.matePid>0){//外族人，即配偶
			parentId = relInfo.matePid;	
			isSpouse = true;
		}
		if(relInfo.isAlien!=true && relInfo.fatherPid>0){
			parentId = relInfo.fatherPid;
			//addVirtualNode(relInfo.fatherPid);//如果是母亲是族人呢？			
		}
		if(parentId > 0){
			addVirtualNode(parentId, isSpouse,relInfo.isAlien);
		}
		//add by zwj
		if(relInfo.isAlien==true){
			var tmp=$('#data-input-table input[name=surname]').val();
			$('#data-input-table input[name=surname]').val("").focus().val(tmp);//每次初始化人物树的时候要定位到录入表单中的第一个元素。
		}
		else{
			var tmp=$('#data-input-table input[name=name]').val();
			$('#data-input-table input[name=name]').val("").focus().val(tmp);//每次初始化人物树的时候要定位到录入表单中的第一个元素。
		}
		$("input[name='arrangedsc']").val("");
		//$('#data-input-table input[name=borndsc]').val("生于");
		//var islivetmp=$("form input[name='islive'][value='true']").attr("checked");
		//if(!islivetmp){
			//$('#data-input-table input[name=deathdsc]').val("殁于");
			//$('#data-input-table input[name=graveyard]').val("葬于");
		//}
		//$('#data-input-table input[name=deathdsc]').val("殁于");
		//$('#data-input-table input[name=graveyard]').val("葬于");
		//end		
	};	

	/**打开/切换到造字程序*/
	function openCreateFont(){
		//var exists = $('#input-tabs').tabs('exists', '造字');
		//if(exists){
			//$('#input-tabs').tabs('select', '造字');
		//}
		//else{
			//$('#input-tabs').tabs('add', {
				//title:'造字',
				//closable:true,
				//href:'${pageContext.request.contextPath}/createfont/2.htm'
			//});
		//}
		$('#creat-font-dialog').dialog("open");
		//$("#chareditor").css("display","block");
		
	}
	//$(document).ready(function(){
      // $('#hotkeyForm').trigger("click");
    //});
</script>
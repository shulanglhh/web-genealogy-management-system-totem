<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<style>
div .div-row{
	margin-top:10px;
}

</style>

<form id="su-individual-form" method="post" >
	<div class="easyui-panel" style="width:620px;padding:10px;">
	
	<div class="div-row">
		<span >
			<label>谱名： </label>
			<input name="name" class="easyui-validatebox" required="true" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
		</span>
		<span >
			<label>姓氏： </label>
			<input name="surname" class="easyui-validatebox" required="true" data-options="validType:'lengthRange[1,20]'" style="width:30px;"></input>
		</span>
		<%--<span >
			<label>字辈： </label>
			<input name="" class="easyui-validatebox" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
		</span>
		--%><span >
			<label>名： </label>
			<input name="givenname" class="easyui-validatebox" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
		</span>
		<span >
			<label>字： </label>
			<input name="nickname" class="easyui-validatebox" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
		</span>
		<span >
			<label>号： </label>
			<input name="title" class="easyui-validatebox" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
		</span>
		<span >
			<label>行号： </label>
			<input name="ranknum"  class="easyui-validatebox"
			 data-options="validType:'numRange[1, 200000]'" style="width:30px;"></input>
		</span>
		
	</div>
	<div class="div-row">
		<span>
			<label>性别：</label> 
			<input type="radio" checked="checked" name="sex" value="男"/> 
			<label>男</label> 
			<input type="radio" name="sex" value="女"/><label>女</label> 
		</span>
		<span>
			<label>排行数:</label><input name="arrangenum" class="easyui-validatebox"
			data-options="validType:'numRange[1, 200000]'" style="width:30px;"/>			
		</span>
		<%--<span>
			<label>过继或兼祧：</label>
			<input name="" class="easyui-validatebox" data-options="validType:'maxLength[10]'" ></input>
		</span>
	--%></div>
	<div class="div-row">
		<span>
			<label>家住地描述：</label>
			<input name="homeplacedsc" class="easyui-validatebox" data-options="validType:'maxLength[10]'" ></input>	
		</span>	
	</div>
	<div class="div-row">
		<span>
			<label>卒世描述：</label>
			<input name="deathdsc" class="easyui-validatebox" data-options="validType:'maxLength[10]'" ></input> 
		</span>
	</div>
	<div class="div-row">
		<span>
			<label>在世或已故：</label> <input type="radio" checked="checked"
							name="islive" value="true"/> 
							<label>在世</label> <input type="radio" name="islive" value="false"/><label>已故</label> 
		</span>
		<span>
			<input name="hiddenchild" type="checkbox" value="false"/><label>不统计子女</label>
					<input name="inbiography" type="checkbox" value="true" checked="checked"/><label>是否在行传中出现</label>
					<input name="inrelation" type="checkbox" value="true" checked="checked"/><label>是否在吊线中出现</label>
		</span>
	</div>
	<div class="div-row">
		<span>
			<label style="float:left;">葬地及朝向：</label>
			<input name="graveyard" type="text"></input>
		</span>	
	</div>
	<div class="div-row">
		<span>
			<label style="float:left;">生平简介：</label>
			<input name="lifedsc" type="text"></input>
		</span>	
	</div>
	<div class="div-row"  style="vertical-align:center;">
		<span>
			<label style="float:left;">备注：</label>
			<input name="remark" style="width:90%;"></input>
		</span>	
	</div>
	<div class="div-row"  style="vertical-align:center;">
		<span>
			<label style="float:left;">尾注：</label>
			<input name="endnote" style="width:90%;"></input>
		</span>	
	</div>	
	</div>
	<br />
	<div>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm(1, '#su-individual-form')">保存</a>
			<a href="#" class="easyui-linkbutton" onclick="resetForm('#su-individual-form')">重置</a> 
			<a href="#" class="easyui-linkbutton" onclick="openCreateFont()">造字</a>
		<a href="#" class="easyui-linkbutton" onclick="submitForm(2, '#su-individual-form')">添加子女</a>
		<a href="#" class="easyui-linkbutton" onclick="submitForm(3, '#su-individual-form')">添加兄妹</a>
		<a href="#" class="easyui-linkbutton" onclick="submitForm(4, '#su-individual-form')">添加配偶</a>
	</div>
	<input name="ggen" type="hidden" value="" />	
	<input name="inputperson" type="hidden" value="<%=session.getAttribute("userid") %>" />
	<input name="gid" type="hidden" value="0" />
	<input name="grpid" type="hidden" value="" />	
	
	<input name="spousedsc" type="hidden" value="" />
	<input name="photoid" type="hidden" value="" />		
	<input name="fullname" type="hidden" value="" />	
	<input name="huiname" type="hidden" value="" />
	<input name="birthday" type="hidden" value="" />
	<input name="bornplace" type="hidden" value="" />	
	<input name="borntime" type="hidden" value="" />	
	<input name="deathtime" type="hidden" value="" />
	<input name="deathday" type="hidden" value="" />
	<input name="deathplace" type="hidden" value="" />	
	<input name="borndsc" type="hidden" value="" />			
	<input name="deathname" type="hidden" value="" />	
	<input name="education" type="hidden" value="" />
	<input name="officialtitle" type="hidden" value="" />
	<input name="duty" type="hidden" value="" />
	<input name="homeplace" type="hidden" value="" />		
	<input name="branch" type="hidden" value="" />	
	<input name="page" type="hidden" value="" />
	
	<input name="inbiology" type="hidden" value="" />
	
	<input name="shire" type="hidden" value="" />
	<input name="arrangedsc" type="hidden" value="" />
	<input name="rankdsc" type="hidden" value="" />
	<input name="dna" type="hidden" value="" />
	<input name="bloodtype"	type="hidden" value="" />
	<input name="photo"	type="hidden" value="" />
	<input name="birthdaydetail" type="hidden" value="" />
	<input name="othername" type="hidden"></input>
	<input name="otherinfo" type="hidden"></input>
	
	<input name="curpid" type="hidden" value="0" /> 
	<input name="fatherpid" type="hidden" value="0"> 
	<input name="motherpid" type="hidden" value="0">
	<input name="matepid" type="hidden" value="0"> 
	<input name="isalien" value="false" type="hidden"> 
	<input name="submittype" type="hidden"> 
	<input name="formchanged" type="hidden" value="false">
</form>
<script>
$("#su-individual-form input, select").change(function(){			
	formChanged = true;	
});	
$("form input[type='checkbox']").click(function(){
	
	if($(this).attr("checked"))
		$(this).attr("value", true);
	
	else
		$(this).attr("value", false);
});
$(function() {
	   $("#su-individual-form :input").focus(function(){
		   zwj_selectfocus=event.target;
  		});
	$('#su-individual-form').form({//form中需要包括隐藏的关联人物信息{关联人物的id，父母id|关联人物的配偶id}
		url : '${pageContext.request.contextPath}/tIndividualAction!save.action',//保存
		onSubmit : function() {				
			//console.info('onSubmit...');				
			},
		success : function(r) {
			//关闭进度条代码
			$.messager.progress('close');
			var rObj = jQuery.parseJSON(r);
			if (rObj.success) {//插入成功
				if(rObj.relInfo.curPid==0){
					$("#su-individual-form")[0].reset();
				}
				//写回人物树，树节点id、名字、性别、parentId、icon五个属性为必需
				updateVirtualNode(rObj);//保存成功后，先更新虚节点(更新时验证一下必须为已选中的节点)的数据，再根据relInfo判断是否应当再添加虚节点
				setNodeData(rObj);//createTree.js中实现		
				setRelInfo(rObj.relInfo);//设置当前人物的关联信息
				//保存成功回来要根据当前人物决定增加虚拟节点。addVirtualNode					
				addVirtualNodeByInfo(rObj.relInfo);			
			}
			
			$.messager.show({
				title : '提示',
				msg : rObj.msg
			//提示是否成功的信息
			});
		}
	});
});
</script>
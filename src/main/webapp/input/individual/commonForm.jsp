<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<style>
div .c-f-c-top{
	float:left;
	width:100%;
}
div .c-f-c-top-left{
	float:left;
	width:22%;
	
}
div .c-f-c-top-right{
	float:right;
	width:78%;
}
div .c-f-c-center{
	clear:both;
	margin-top:10px;
}
div .div-row{

	margin-top:10px;
}

</style>

<form id="common-individual-form" method="post" >
	<div class="easyui-panel" style="width:620px;padding:10px;">
	<div class="common-form-container">
		<div class="c-f-c-top">
			<div class="c-f-c-top-left">
				<span >  
        			<img id="person-photo" style="width:125px;height:125px" src="<%=path %>/images/qq.jpg"/>  
   				</span>
				<span><a href="javascript:void(0)" class="easyui-linkbutton"  onclick="openImgEditWindow('#img-edit-window')">编辑</a></span>
				<span><a href="javascript:void(0)" class="easyui-linkbutton" onclick="deletePhoto()">删除</a></span>				
			</div>
			<div class="c-f-c-top-right">
				<div class="div-row">
					<span >
						<label>谱名： </label>
						<input id="commonname" name="name" class="easyui-validatebox" required="true" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
					</span>
					<span >
						<label>姓氏： </label>
						<input name="surname" class="easyui-validatebox" required="true" data-options="validType:'lengthRange[1,20]'" style="width:30px;"></input>
					</span>
					<span >
						<label>名： </label>
						<input name="givenname" class="easyui-validatebox" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
					</span>
					<span >
						<label>字： </label>
						<input name="nickname" class="easyui-validatebox" data-options="validType:'maxLength[10]'" style="width:30px;"></input>
					</span>
					<span >
						<label>号： </label>
						<input name="title" class="easyui-validatebox" style="width:30px;"></input>
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
					<%--<span>
						<label>过继或兼祧：</label>
						<input name="" class="easyui-validatebox" data-options="validType:'maxLength[10]'" ></input>
					</span>
				--%></div>
				<div class="div-row">
					<%--<span>
						<label>字辈:</label><input name="" style="width:30px;"/>	
					</span>	
					--%><span>
						<label>排行数:</label><input name="arrangenum" class="easyui-validatebox"
						data-options="validType:'numRange[1, 1000]'" style="width:30px;"/>	
					</span>	
					<span>
						<label>文化程度:</label><input name="education" style="width:100px;"/>	
					</span>	
				</div>
				<div class="div-row">
					<span>
						<label>家庭地址：</label>
						<input name="homeplace" class="easyui-validatebox" data-options="validType:'maxLength[10]'" ></input>	
					</span>	
				</div>
				<div class="div-row">
					<span>
						<label>家住地描述：</label>
						<input name="homeplacedsc" class="easyui-validatebox" data-options="validType:'maxLength[10]'" ></input>	
					</span>	
				</div>
			</div>
		</div>

		<div class="c-f-c-center">
			<div class="div-row">
				<span>
					<label>出生日期：</label>
					<input name="birthday" style="width:80px;"></input>
				</span>
				<span>
					<label>时辰：</label>
					<select name="borntime">
						<option value =""></option>
						<option value ="子时">子时</option>
						<option value ="丑时">丑时</option>				
						<option value ="寅时">寅时</option>
						<option value ="卯时">卯时</option>
						<option value ="辰时">辰时</option>				
						<option value="巳时">巳时</option>
						<option value ="午时">午时</option>
						<option value ="未时">未时</option>				
						<option value="申时">申时</option>
						<option value ="酉时">酉时</option>
						<option value ="戌时">戌时</option>				
						<option value="亥时">亥时</option>
					</select>
				</span>
				<span>
					<label>出生地：</label>
					<input name="bornplace" style="width:80px;"></input>
				</span>
			</div>
			<div class="div-row">
				<span>
					<label style="float:left;">出生概述：</label>
					<input name="borndsc" type="text"></input>
				</span>	
			</div>
			<div class="div-row">
				<span>
					<label>职务：</label>
					<input name="duty" style="width:80px;"></input>
				</span>
				<span>
					<label>职称：</label>
					<input name="officialtitle" style="width:80px;"></input>
				</span>
				<span>
					<label>生平简介：</label>
					<input name="lifedsc" type="text"></input>
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
					<label>卒于：</label>
					<input name="deathday" style="width:80px;"></input>
				</span>
				<span>
					<label>时辰：</label>
					<select name="deathtime">
						<option value =""></option>
						<option value ="子时">子时</option>
						<option value ="丑时">丑时</option>				
						<option value ="寅时">寅时</option>
						<option value ="卯时">卯时</option>
						<option value ="辰时">辰时</option>				
						<option value="巳时">巳时</option>
						<option value ="午时">午时</option>
						<option value ="未时">未时</option>				
						<option value="申时">申时</option>
						<option value ="酉时">酉时</option>
						<option value ="戌时">戌时</option>				
						<option value="亥时">亥时</option>
					</select>
				</span>
				<span>
					<label>卒地：</label>
					<input name="deathplace" ></input> 
				</span>
			</div>
			<div class="div-row">
				<span>
					<label>谥号：</label>
					<input name="deathname" ></input>
				</span>
				<span>
					<label>葬地及朝向：</label>
					<input name="graveyard" type="text"></input>
				</span>	
			</div>
			<div class="div-row">
				<span>
					<label style="float:left;">卒世概述：</label>
					<input name="deathdsc" type="text"></input>
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
		<div class="c-f-c-bottom">
			<br />
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="submitForm(1, '#common-individual-form')">保存</a> 
				<a href="#" class="easyui-linkbutton" onclick="resetForm('#common-individual-form')">重置</a> 
				<a href="#" class="easyui-linkbutton" onclick="openCreateFont()">造字</a>
				<a href="#" class="easyui-linkbutton" onclick="submitForm(2, '#common-individual-form')">添加子女</a>
				<a href="#" class="easyui-linkbutton" onclick="submitForm(3, '#common-individual-form')">添加兄妹</a>
				<a href="#" class="easyui-linkbutton" onclick="submitForm(4, '#common-individual-form')">添加配偶</a>
			</div>
		</div>
	</div>	
	</div>	
	<input name="ggen" type="hidden" value="" />	
	<input name="inputperson" type="hidden" value="<%=session.getAttribute("userid") %>" />
	<input name="gid" type="hidden" value="0" />
	<input name="grpid" type="hidden" value="" />
	<input name="spousedsc" type="hidden" value="" />
	<input name="photoid" type="hidden" value="" />	
	<input name="fullname" type="hidden" value="" />
	<input name="huiname" type="hidden" value="" />
	<input name="branch" type="hidden" value="" />	
	<input name="page" type="hidden" value="" />
	
	<input name="inbiology" type="hidden" value="" />
	
	<input name="shire" type="hidden" value="" />	
	<input name="arrangedsc" type="hidden" value="" />
	<input name="rankdsc" type="hidden" value="" />
	<input name="dna" type="hidden" value="" />
	<input name="bloodtype"	type="hidden" value="" />
	<input name="photo"	type="hidden" value="" />
	<input name="birthdaydetail"	type="hidden" value="" />
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
<div id="img-edit-window" class="easyui-window" title="编辑上传图片" 
data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#win-buttons'" 
style="width:900px;height:500px;padding:5px;">
	<jsp:include page="imgEdit1.jsp"></jsp:include>
	<div id="win-buttons">			
			<a href="javascript:void(0)" class="easyui-linkbutton"
				onclick="$('#img-edit-window').window('close');">关闭</a>
		</div>		
</div>
<script>
$("#common-individual-form input, select").change(function(){			
	formChanged = true;	
});	
$("form input[type='checkbox']").click(function(){
	
	if($(this).attr("checked"))
		$(this).attr("value", true);
	
	else
		$(this).attr("value", false);
});
$(function() {
	 $("#common-individual-form :input").focus(function(){
		   zwj_selectfocus=event.target;
		});
	$('#common-individual-form').form({//form中需要包括隐藏的关联人物信息{关联人物的id，父母id|关联人物的配偶id}
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
					$("#common-individual-form")[0].reset();
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

function openImgEditWindow(windowId){
	$(windowId).window('open');

	initWindowContent(windowId);
}

function deletePhoto(){
	var pid = $('#treeid').attr('value');
	$.ajax({
		//async:false,
		data:{'pid':pid},
		type:'post',
		url:'${pageContext.request.contextPath}/tPhotoAction!deletephoto.action',
		success:function(){
			if(pid == $('#treeid').attr('value') ){
				var url = '${pageContext.request.contextPath}/images/qq.jpg';				
				$('#person-photo').attr('src',url);				
				$('#img-small').attr('src', url);
				jcrop_api.setImage(url);//jcrop_api定义在imgEdit1.jsp中
				jcrop_api.release();
			}
		}
	});
}
/**
 * 初始化
 */
function initWindowContent(windowId){
	//$(windowId).html('');
}
</script>

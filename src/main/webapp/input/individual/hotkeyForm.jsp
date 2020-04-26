<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<% 
//java.util.List<Character> l = (java.util.List)session.getAttribute("inputSort");
//String[] inputSortArr = (String[])session.getAttribute("inputSort");
String inputSortStr = (String)session.getAttribute("inputSortStr");
if(inputSortStr == null || inputSortStr.equals("")){
	inputSortStr = "ABEYCXPUTHGIJNOQRSWZKFL";
}
%>
<style>
#data-input-table .table-tr {	
	width:98%;
	height: 24px;
	font-family: 微软雅黑;
	font-size: 1em;
	border: 1px;
}
#data-input-table input {
	height: 16px;
	font-size: 12px;
}

#data-input-table .td1{
	width:85px;	
}
#data-input-table .td2{
	width:70px;	
}
#data-input-table .td3{
	width:400px;	
}

#data-input-table .input-text {
	width:96%;
}
#data-input-table .td4{
	width:40px;	
}
.chkBox{
　　_vertical-align:-1px;　　/*针对IE6使用hack*/
　　vertical-align:-2px;
}
</style>
<form id="hotkey-individual-form" method="post" onload="bangDing()">
	<div class="easyui-panel" id="table-container" data-options="fit:true" style="overflow:hidden;height:690px">
	<div id="buttonzwj" style="margin-top:10px">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="submitForm(1, '#hotkey-individual-form')">保存(alt+1)</a> 
		<a href="#" class="easyui-linkbutton" onclick="submitForm(2, '#hotkey-individual-form')">添加子女(alt+2)</a>
		<a href="#" class="easyui-linkbutton" onclick="submitForm(3, '#hotkey-individual-form')">添加兄妹(alt+3)</a>
		<a href="#" class="easyui-linkbutton" onclick="submitForm(4, '#hotkey-individual-form')">添加配偶(alt+4)</a>
		<a href="#" class="easyui-linkbutton" onclick="resetForm('#hotkey-individual-form')">重置</a>
	</div>

		<table id="data-input-table" style="width:610px;display:block;height:610px" onkeydown="Move()">
 			<% 
				int len = inputSortStr.length();
				String s1 = "<tr class=\"table-tr\" data-itemidx=\"",
					s2 = "\"><td class=\"td1\">",
					s3 = "</td><td class=\"td2\">",
					s4 = "</td><td class=\"td3\">",
					s5 = "</td></tr>\n";
				for(int i=0; i<len; i++){
					Character c = inputSortStr.charAt(i);					
					String s = "";
					String cnt1="",cnt2="",cnt3="",cnt4="";
					String down = "</td><td class=\"td4\"><a href=\"#\" class=\"hk-order\" onclick=\"hotkeyDown(\'";//hiddenchild')">d</a><a href="#" class="easyui-linkbutton" onclick="hotkeyUp('hiddenchild\')\">u</a>";
					String downup ="\')\"> </a><span> </span><a href=\"#\" class=\"hk-order\" onclick=\"hotkeyUp(\'";
					String up = "\')\"> </a>";
					//String ud = down+c+downup+c+up;
					if(c=='A' || c=='a'){
						cnt1 = "2";
						cnt2 = "Alt+Shift+A";
						cnt3 = "姓氏:";
						cnt4 = "<input id=\"123\" name=\"surname\" data-itemidx=\"A\" class=\"easyui-validatebox mousetrap input-text\" required=\"true\""
						+"data-options=\"validType:\'lengthRange[1,20]\'\" ></input>"+down+"surname"+downup+"surname"+up;
					}		
					else if(c=='B' || c=='b'){
						cnt1 = "3";
						cnt2 = "Alt+Shift+B";
						cnt3 = "谱名:";
						cnt4 = "<input id=\"pediname\" name=\"name\" data-itemidx=\"B\" class=\"easyui-validatebox mousetrap input-text\" required=\"true\"" 
						+"data-options=\"validType:\'lengthRange[1,20]\'\"></input>"+down+"name"+downup+"name"+up;
					}
					else if(c=='E' || c=='e'){
						cnt1 = "4";
						cnt2 = "Alt+Shift+E";
						cnt3 = "字:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"nickname\" data-itemidx=\"E\"></input>"+down+"nickname"+downup+"nickname"+up;
					}
					else if(c=='C' || c=='c'){
						cnt1 = "5";
						cnt2 = "Alt+Shift+C";
						cnt3 = "男女:";
						cnt4 = "<label>男</label> <input type=\"radio\" checked=\"checked\" name=\"sex\" data-itemidx=\"C\" value=\"男\" class=\"mousetrap\" />" 
						+ "<label>女</label><input type=\"radio\" name=\"sex\" value=\"女\" class=\"mousetrap\" />"+down+"sex"+downup+"sex"+up;
					}
					else if(c=='X' || c=='x'){
						cnt1 = "6";
						cnt2 = "Alt+Shift+X";
						cnt3 = "生卒:";
						cnt4 = "<label>生</label> <input type=\"radio\" checked=\"checked\" name=\"islive\" data-itemidx=\"X\" value=\"true\" data-itemidx=\"X\" class=\"mousetrap\" />" 
						+ "<label>卒</label><input type=\"radio\" name=\"islive\" value=\"false\" class=\"mousetrap\" />"+down+"islive"+downup+"islive"+up;
					}
					else if(c=='P' || c=='p'){
						cnt1 = "7";
						cnt2 = "Alt+Shift+P";
						cnt3 = "出生描述:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"borndsc\" data-itemidx=\"P\"></input>"+down+"borndsc"+downup+"borndsc"+up;
					}
					else if(c=='U' || c=='u'){
						cnt1 = "8";
						cnt2 = "Alt+Shift+U";
						cnt3 = "卒世描述:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"deathdsc\" data-itemidx=\"U\"></input>"+down+"deathdsc"+downup+"deathdsc"+up;
					}
					else if(c=='T' || c=='t'){
						cnt1 = "9";
						cnt2 = "Alt+Shift+T";
						cnt3 = "备注:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"remark\" data-itemidx=\"T\"></input>"+down+"remark"+downup+"remark"+up;
					}
					else if(c=='H' || c=='h'){
						cnt1 = "10";
						cnt2 = "Alt+Shift+H";
						cnt3 = "讳:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"huiname\" data-itemidx=\"H\"></input>"+down+"huiname"+downup+"huiname"+up;
					}
					else if(c=='G' || c=='g'){
						cnt1 = "11";
						cnt2 = "Alt+Shift+G";
						cnt3 = "谥号:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"deathname\" data-itemidx=\"G\"></input>"+down+"deathname"+downup+"deathname"+up;
					}
					else if(c=='I' || c=='i'){
						cnt1 = "12";
						cnt2 = "Alt+Shift+I";
						cnt3 = "行号:";
						cnt4 = "<input name=\"ranknum\" data-itemidx=\"I\" class=\"mousetrap easyui-validatebox input-text\" "
							+ "data-options=\"validType:\'numRange[1, 200000]\'\"></input>"+down+"ranknum"+downup+"ranknum"+up;
					}
					else if(c=='J' || c=='j'){
						cnt1 = "13";
						cnt2 = "Alt+Shift+J";
						cnt3 = "号:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"title\" data-itemidx=\"J\"></input>"+down+"title"+downup+"title"+up;
					}
					else if(c=='N' || c=='n'){
						cnt1 = "15";
						cnt2 = "Alt+Shift+N";
						cnt3 = "文化程度:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"education\" data-itemidx=\"N\"></input>"+down+"education"+downup+"education"+up;
					}
					else if(c=='O' || c=='o'){
						cnt1 = "16";
						cnt2 = "Alt+Shift+O";
						cnt3 = "家住地址:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"homeplace\" data-itemidx=\"O\"></input>"+down+"homeplace"+downup+"homeplace"+up;
					}
					else if(c=='Q' || c=='q'){
						cnt1 = "17";
						cnt2 = "Alt+Shift+Q";
						cnt3 = "职务:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"duty\" data-itemidx=\"Q\"></input>"+down+"duty"+downup+"duty"+up;
					}
					else if(c=='R' || c=='r'){
						cnt1 = "18";
						cnt2 = "Alt+Shift+R";
						cnt3 = "职称:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"officialtitle\" data-itemidx=\"R\"></input>"+down+"officialtitle"+downup+"officialtitle"+up;
					}
					else if(c=='S' || c=='s'){
						cnt1 = "19";
						cnt2 = "Alt+Shift+S";
						cnt3 = "生平简介:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"lifedsc\" data-itemidx=\"S\"></input>"+down+"lifedsc"+downup+"lifedsc"+up;
					}
					else if(c=='W' || c=='w'){
						cnt1 = "20";
						cnt2 = "Alt+Shift+W";
						cnt3 = "葬地及朝向:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"graveyard\" data-itemidx=\"W\"></input>"+down+"graveyard"+downup+"graveyard"+up;
					}
					else if(c=='Z' || c=='z'){
						cnt1 = "21";
						cnt2 = "Alt+Shift+Z";
						cnt3 = "尾注:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"endnote\" data-itemidx=\"Z\"></input>"+down+"endnote"+downup+"endnote"+up;
					}
					else if(c=='K' || c=='k'){
						cnt1 = "22";
						cnt2 = "Alt+Shift+K";
						cnt3 = "其他名字:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"othername\" data-itemidx=\"K\"></input>"+down+"othername"+downup+"othername"+up;
					}
					else if(c=='F' || c=='f'){
						cnt1 = "23";
						cnt2 = "Alt+Shift+F";
						cnt3 = "吊线图中附加信息:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"otherinfo\" data-itemidx=\"F\"></input>"+down+"otherinfo"+downup+"otherinfo"+up;
					}
					else if(c=='Y' || c=='y'){
						cnt1 = "24";
						cnt2 = "Alt+Shift+Y";
						cnt3 = "行号描述:";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"rankdsc\" data-itemidx=\"Y\"></input>"+down+"rankdsc"+downup+"rankdsc"+up;
					}
					else if(c=='l' || c=='L'){
						cnt1 = "25";
						cnt2 = "Alt+Shift+L";
						cnt3 = "出生时间 :";
						cnt4 = "<input class=\"mousetrap input-text\" name=\"birthday\" data-itemidx=\"L\"></input>"+down+"birthday"+downup+"birthday"+up;
					}
					if(!cnt4.equals("")){
						s = s1+cnt1+s2+cnt2+s3+cnt3+s4+cnt4+s5;
						out.print(s);		
					}	
				}
			%>			
			
	 		<%-- <tr class="table-tr" data-itemidx="2">
				<td class="td1">Alt+Shift+A</td>
				<td class="td2">姓氏:</td>
				<td class="td3"><input id="123" name="surname"
					class="easyui-validatebox mousetrap input-text" required="true"
					data-options="validType:'lengthRange[1,20]'" autofocus="autofocus"></input></td>
			</tr>
			<tr class="table-tr" data-itemidx="3">
				<td class="td1">Alt+Shift+B</td>
				<td class="td2">谱名:</td>
				<td class="td3"><input name="name" id="pediname"
					class="easyui-validatebox mousetrap input-text" required="true"
					data-options="validType:'lengthRange[1,20]'"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="4">
				<td class="td1">Alt+Shift+E</td>
				<td class="td2">字 :</td>
				<td class="td3"><input class="mousetrap input-text" name="nickname"></input>
				</td>
			</tr>
			<tr class="table-tr" class="table-tr" data-itemidx="5">
				<td class="td1">Alt+Shift+C</td>
				<td class="td2">男女:</td>
				<td class="td3"><label>男</label> <input type="radio" checked="checked"
					name="sex" value="男" class="mousetrap" /> <label>女</label> <input
					type="radio" name="sex" value="女" class="mousetrap" /></td>
			</tr>
			<tr class="table-tr" data-itemidx="6">
				<td class="td1">Alt+Shift+X</td>
				<td class="td2">生卒:</td>
				<td class="td3"><label>生</label> <input type="radio" checked="checked"
					name="islive" value="true" class="mousetrap" /> <label>卒</label><input
					type="radio" name="islive" value="false" class="mousetrap" /></td>
			</tr>
			<tr class="table-tr" data-itemidx="7">
				<td class="td1">Alt+Shift+P</td>
				<td class="td2">出生概述:</td>
				<td class="td3"><input name="borndsc" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="8">
				<td class="td1">Alt+Shift+U</td>
				<td class="td2">卒世概述:</td>
				<td class="td3"><input name="deathdsc" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="9">
				<td class="td1">Alt+Shift+T</td>
				<td class="td2">备注:</td>
				<td class="td3"><input name="remark" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="9">
						<td>Alt+Shift+L</td>
						<td>过继/兼祧:</td>
						<td><label>过继 </label> <input type="radio" name="isGJorJT" />
							<label>兼祧</label> <input type="radio" name="isGJorJT" /> <label>均不是</label>
							<input type="radio" checked="checked" name="isGJorJT" />					
							
					</tr>
					
			<tr class="table-tr" data-itemidx="10">
				<td class="td1">Alt+Shift+H</td>
				<td class="td2">讳:</td>
				<td class="td3"><input name="huiname" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="11">
				<td class="td1">Alt+Shift+G</td>
				<td class="td2">谥号:</td>
				<td class="td3"><input name="deathname" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="12">
				<td class="td1">Alt+Shift+I</td>
				<td class="td2">行号:</td>
				<td class="td3"><input name="ranknum" class="mousetrap easyui-validatebox input-text"
					data-options="validType:'numRange[1, 200000]'"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="13">
				<td class="td1">Alt+Shift+J</td>
				<td class="td2">号:</td>
				<td class="td3"><input name="title" class="mousetrap input-text"></input>
				</td>
			</tr>
			<!-- <tr class="table-tr" data-itemidx="14">
				<td class="td1">Alt+Shift+M</td>
				<td class="td2">字辈:</td>
				<td class="td3"><input name="genword" class="mousetrap input-text"></input>
				</td>
			</tr> -->
			<tr class="table-tr" data-itemidx="15">
				<td class="td1">Alt+Shift+N</td>
				<td class="td2">文化程度:</td>
				<td class="td3"><input name="education" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="16">
				<td class="td1">Alt+Shift+O</td>
				<td class="td2">家住地址:</td>
				<td class="td3"><input name="homeplace" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="17">
				<td class="td1">Alt+Shift+Q</td>
				<td class="td2">职务:</td>
				<td class="td3"><input name="duty" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="18">
				<td class="td1">Alt+Shift+R</td>
				<td class="td2">职称:</td>
				<td class="td3"><input name="officialtitle" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="19">
				<td class="td1">Alt+Shift+S</td>
				<td class="td2">生平简介:</td>
				<td class="td3"><input name="lifedsc" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="20">
				<td class="td1">Alt+Shift+W</td>
				<td class="td2">葬地及朝向:</td>
				<td class="td3"><input name="graveyard" class="mousetrap input-text"></input>
				</td>
			</tr>
			<tr class="table-tr" data-itemidx="21">
						<td>Alt+Shift+Z</td>
						<td>尾注:</td>
						<td><input name="endnote" class="mousetrap input-text"></input></td>
			</tr>
			<tr class="table-tr" data-itemidx="22">
						<td>Alt+Shift+D</td>
						<td>其它名字:</td>
						<td><input name="othername" class="mousetrap input-text"></input></td>
			</tr>
			<tr class="table-tr" data-itemidx="23">
						<td>Alt+Shift+F</td>
						<td>附加信息:</td>
						<td><input name="otherinfo" class="mousetrap input-text"></input></td>
			</tr> --%>
		</table>
		
	</div>
	<input name="ggen" type="hidden" value="" />	
	<input name="inputperson" type="hidden" value="<%=session.getAttribute("userid") %>" />
	<input name="gid" type="hidden" value="0" />
	<input name="grpid" type="hidden" value="" />
	<input name="spousedsc" type="hidden" value="" />
	<input name="photoid" type="hidden" value="" />
	<input name="givenname" type="hidden" value="" />
	<input name="fullname" type="hidden" value="" />
	<input name="birthdaydetail" type="hidden" value="" />
	<input name="bornplace" type="hidden" value="" />
	<input name="borntime" type="hidden" value="" />
	<input name="deathday" type="hidden" value="" />
	<input name="deathplace" type="hidden" value="" />
	<input name="deathtime" type="hidden" value="" />
	<input name="homeplacedsc" type="hidden" value="" />
	<input name="branch" type="hidden" value="" />	
	<input name="page" type="hidden" value="" />
	
	<input name="inbiology" type="hidden" value="" />
		
	<input name="shire" type="hidden" value="" />	
	<input name="arrangedsc" type="hidden" value="" />
	<input name="arrangenum" type="hidden" value="" />
	
	<input name="dna" type="hidden" value="" />
    <input name="bloodtype"	type="hidden" value="" />
	<input name="photo"	type="hidden" value="" />
	<input name="inbiology"	type="hidden" value="" />
				
	<input name="table-order" type="hidden" />
	 
	<input name="curpid" type="hidden" value="0" /> 
	<input name="fatherpid" type="hidden" value="0"> 
	<input name="motherpid" type="hidden" value="0">
	<input name="matepid" type="hidden" value="0"> 
	<input name="isalien" value="false" type="hidden"> 
	<input name="submittype" type="hidden"> 
	<input name="formchanged" type="hidden" value="false">
</form>
<script>
$(function() {
	var x=$("#table-container").offset().left;
	var y=$("#table-container").offset().top;
	$("#buttonzwj").css("left",x);
	$("#buttonzwj").css("top",y);
	
	$('#hotkey-individual-form').form({//form中需要包括隐藏的关联人物信息{关联人物的id，父母id|关联人物的配偶id}
		url : '${pageContext.request.contextPath}/tIndividualAction!save.action',//保存
		onSubmit : function() {
	      //var nametest=$("input[name='surname']").val();
		  //alert(nametest);		
			},
		success : function(r) {
			//关闭进度条代码
			$.messager.progress('close');
			Mousetrap.unpause();
			var rObj = jQuery.parseJSON(r);
			if (rObj.success) {//插入成功
				if(rObj.relInfo.curPid==0){
					$("#hotkey-individual-form")[0].reset();
					$("input[name='arrangenum']").attr("value", 0);
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
/*/doesnt work well
$("#data-input-table").dragsort({
	itemSelector: "#data-input-table tr",
	dragSelector : "#data-input-table tr",
	dragBetween : true,
	//dragEnd : updateOrder,
	placeHolderTemplate : "<tr class='table-tr'></tr>",
	//scrollContainer:"#table-container"
});*/

function focusInput(el) {
	window.setTimeout(function() {
		$(el).focus();
	}, 0);
};
//use mousetrap.pause()
Mousetrap=function(a){var c=a.stopCallback,b=!0;a.stopCallback=function(a,d,e){return b?c(a,d,e):!0};a.pause=function(){b=!1};a.unpause=function(){b=!0};return a}(Mousetrap);	
Mousetrap.bindGlobal('alt+shift+a', function() {focusInput('#data-input-table input[name=surname]'); return false;});
Mousetrap.bindGlobal('alt+shift+b', function() {focusInput('#data-input-table input[name=name]'); return false;});
Mousetrap.bindGlobal('alt+shift+e', function() {focusInput('#data-input-table input[name=nickname]'); return false;});
//Mousetrap.bindGlobal('alt+shift+d', function() {focusInput('#data-input-table input[name=huiname]'); return false;});	
Mousetrap.bindGlobal('alt+shift+c', function() {$("#hotkey-individual-form input[value='女']").attr("checked", true); return false;});
Mousetrap.bindGlobal('alt+shift+x', function() {$("#hotkey-individual-form input[value='false']").attr("checked", true);return false;});
Mousetrap.bindGlobal('alt+shift+p', function() {focusInput('#data-input-table input[name=borndsc]'); return false;});
Mousetrap.bindGlobal('alt+shift+u', function() {focusInput('#data-input-table input[name=deathdsc]'); return false;});
Mousetrap.bindGlobal('alt+shift+t', function() {focusInput('#data-input-table input[name=remark]'); return false;});
Mousetrap.bindGlobal('alt+shift+h', function() {focusInput('#data-input-table input[name=huiname]'); return false;});
Mousetrap.bindGlobal('alt+shift+g', function() {focusInput('#data-input-table input[name=deathname]'); return false;});
Mousetrap.bindGlobal('alt+shift+i', function() {focusInput('#data-input-table input[name=ranknum]'); return false;});
Mousetrap.bindGlobal('alt+shift+j', function() {focusInput('#data-input-table input[name=title]'); return false;});
Mousetrap.bindGlobal('alt+shift+m', function() {focusInput('#data-input-table input[name=genword]'); return false;});
Mousetrap.bindGlobal('alt+shift+n', function() {focusInput('#data-input-table input[name=education]'); return false;});
Mousetrap.bindGlobal('alt+shift+o', function() {focusInput('#data-input-table input[name=homeplace]'); return false;});
Mousetrap.bindGlobal('alt+shift+r', function() {focusInput('#data-input-table input[name=officialtitle]'); return false;});
Mousetrap.bindGlobal('alt+shift+s', function() {focusInput('#data-input-table input[name=lifedsc]'); return false;});
Mousetrap.bindGlobal('alt+shift+w', function() {focusInput('#data-input-table input[name=graveyard]'); return false;});
Mousetrap.bindGlobal('alt+shift+q', function() {focusInput('#data-input-table input[name=duty]'); return false;});
Mousetrap.bindGlobal('alt+shift+z', function() {focusInput('#data-input-table input[name=endnote]'); return false;});
Mousetrap.bindGlobal('alt+shift+k', function() {focusInput('#data-input-table input[name=othername]'); return false;});
Mousetrap.bindGlobal('alt+shift+f', function() {focusInput('#data-input-table input[name=otherinfo]'); return false;});
Mousetrap.bindGlobal('alt+shift+y', function() {focusInput('#data-input-table input[name=rankdsc]'); return false;});
Mousetrap.bindGlobal('alt+shift+l', function() {focusInput('#data-input-table input[name=birthdaydetail]'); return false;});
//Mousetrap.bindGlobal('alt+shift+m', function() {focusInput('#data-input-table input[name=bloodtype]'); return false;});

Mousetrap.bindGlobal('alt+1', function() {$('#hotkey-individual-form input[name=name]').focus();submitForm(1, '#hotkey-individual-form'); return false;});
Mousetrap.bindGlobal('alt+2', function() {submitForm(2, '#hotkey-individual-form'); return false;});
Mousetrap.bindGlobal('alt+3', function() {submitForm(3, '#hotkey-individual-form'); return false;});
Mousetrap.bindGlobal('alt+4', function() {submitForm(4, '#hotkey-individual-form'); return false;});
Mousetrap.bindGlobal('alt+5', function() {submitForm(5, '#hotkey-individual-form'); return false;});
Mousetrap.bindGlobal('alt+6', function() {openCreateFont(); return false;});

/*Mousetrap.bind("alt+shift+a", function() {		
	focusInput('#data-input-table input[name=surname]');
	return false;
});
Mousetrap.bind("alt+shift+e", function() {	
	focusInput('#data-input-table input[name=nickname]');
	return false;
});*/
function bangDing(){
    Mousetrap.bindGlobal('alt+1', function() {$('#hotkey-individual-form input[name=name]').focus();submitForm(1, '#hotkey-individual-form'); return false;});
    Mousetrap.bindGlobal('alt+2', function() {submitForm(2, '#hotkey-individual-form'); return false;});
    Mousetrap.bindGlobal('alt+3', function() {submitForm(3, '#hotkey-individual-form'); return false;});
    Mousetrap.bindGlobal('alt+4', function() {submitForm(4, '#hotkey-individual-form'); return false;});
    Mousetrap.bindGlobal('alt+5', function() {submitForm(5, '#hotkey-individual-form'); return false;});
    Mousetrap.bindGlobal('alt+6', function() {openCreateFont(); return false;});

}
function hotkeyDown(s){
	var td = $("#data-input-table tr td input[name='"+s+"']").parent();	
	var tr = td.parent();
	var children = tr.children();
	var nexttr = tr.next();	
	if(nexttr.is('tr')){
		tr.html(nexttr.children());
		nexttr.html(children);
	}	
	updateHkOrder();
}
function hotkeyUp(s){
	var td = $("#data-input-table tr td input[name='"+s+"']").parent();	
	var tr = td.parent();
	var children = tr.children();
	var prevtr = tr.prev();	
	if(prevtr.is('tr')){
		tr.html(prevtr.children());
		prevtr.html(children);
	}
	updateHkOrder();	
}
function updateHkOrder(){
	var inputorder = "";
	$("#data-input-table tr").each(function (){
		var d = $(this).find("input").data("itemidx");
		if(d != undefined)		
			inputorder+=$(this).find("input").data("itemidx");//.find("input").attr("name");
	});	
	$("input[name=table-order]").val(inputorder);	
}
function saveHkOrder(){
	var inputorder = $("input[name=table-order]").val();
	$.post('${pageContext.request.contextPath}/userAction!saveInputOrder.action', 
				{inputOrder: inputorder, userId: userid}, 
				function(data){					
					var rObj = eval('(' + data + ')');
					if(rObj.success){						
						$.messager.show({
							title:'提示',
							msg:'录入顺序设置成功'
						});						
					}
					else{
						alert('录入顺序设置失败');
					}
		});
	//$("#data-input-table a[class='hk-order']").toggle();
}
function updateOrder() {
	var data = $("#data-input-table tr").map(function() {
		return $(this).data("itemidx");
	}).get();
	$("input[name=table-order]").val(data);
};
function Move()
{
	var rows=document.getElementById("data-input-table").getElementsByTagName("input");
	if(window.event) // IE8 以及更早版本
	{
	   x=event.keyCode;
	}
   else if(event.which) // IE9/Firefox/Chrome/Opera/Safari
	{
	  x=event.which;
	}
	
	for(i=0;i<rows.length-1;i++)   //获取当前焦点的位置
    {
		if(document.activeElement.isEqualNode(rows[i]))
		{
			break;
		}
	}
	 
	if(x==34)       //PgDn
	{
        if(i==rows.length-1)
	     rows[0].focus();
        else
         {
	        for(t=i+1;t<rows.length-1;t++)
		    {
		        if(rows[t].type!="radio")
			      break;
		    }
	       rows[t].focus();
          }
	}
	if(x==33)       //PgUp
	{
        if(i==0)
	     rows[rows.length-1].focus();
        else
         {
	        for(t=i-1;t>=0;t--)
		    {
		        if(rows[t].type!="radio")
			      break;
		    }
	       rows[t].focus();
          }
	}
	
}

</script>
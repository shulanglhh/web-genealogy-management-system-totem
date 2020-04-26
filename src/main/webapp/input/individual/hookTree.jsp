<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<style>
div .divTable .divTableInCol{
	width: 100%;
	heigth:100%;
	display: block;
	padding-top: 3px;
	padding-bottom: 3px;
	padding-right: 3px;
	padding-left: 3px;
}

div .divRow {
	width: 98%;
	display: block;
	padding: 5px;
	margin: 5px;
}

div .divColumn {
	float: left;
	display: block;
}

.divRowInCol {
	
}

.divColumn label {
	font-size: 1.5em;
	font-family: 微软雅黑;
}

</style>
<div style="width:98%;height:98%">

	<div class="divTable">
		<div class="divRow" style="height:20px;">
			<div class="divColumn" style="width:100%;">
				<p>
					<label>您选择了</label><label name="person1">&nbsp;&nbsp;</label> <label>，挂接为</label><label
						name="person2">&nbsp;&nbsp;</label> <label>的</label><label
						name="reltype"><strong>子女</strong></label>
				</p>
			</div>
		</div>

		<div class="divRow" style="height:20px;">
			<div class="divColumn" >
				<label name="person1">人物1</label>
			</div>			
		</div>
		<div class="divRow" style="height:80px;">			
			<table class="easyui-datagrid" id="hook-person"
						data-options="title:'挂接人物',fit:true,singleSelect: true">
				<thead>
					<tr class="datagrid-header">
					<th data-options="field:'name'">谱名</th>
						<th data-options="field:'pid',hidden:true">人物编号</th>									
						<th data-options="field:'sex'">性别</th>
						<th data-options="field:'ggen'">所属世代数</th>
						<th data-options="field:'arrangenum'">排行数</th>									
						<th data-options="field:'fullname'">姓名</th>
						<th data-options="field:'givenname'">名</th>
						<th data-options="field:'nickname'">字</th>
						<th data-options="field:'title'">号</th>
						</tr>
				</thead>
				<tbody>

				</tbody>
			</table>				
		</div>

		<div class="divRow" style="height:200px;">
			<div class="divColumn" style="width:96%;height:96%;">
				<div class="divTableInCol">
					<div class="divRowInCol">
						<label name="person2">人物</label>
					</div>
					<div class="divRowInCol">
						<input id="search-content" class="easyui-searchbox"
							data-options="prompt:'请输入人名',searcher:doSearch"
							style=""></input>
					</div>
					<div class="divRowInCol"
						style="height:160px;border:1px solid gray;">						
						<table class="easyui-datagrid" id="search-result"
							data-options="title:'搜索结果',rownumbers:true,fit:true,pagination:'true',singleSelect: true, checkOnSelect:true,selectOnCheck:true">
							<thead>
								<tr class="datagrid-header">
									<th data-options="field:'ck',checkbox:true"></th>
									<th data-options="field:'name',sortable:true,width:100">谱名</th>
									<th data-options="field:'pid',hidden:true,width:50">人物编号</th>									
									<th data-options="field:'sex',width:50">性别</th>
									<th data-options="field:'ggen',width:50">世代数</th>
									<th data-options="field:'arrangenum',width:50">排行数</th>
									<th data-options="field:'fathername',width:50">父亲谱名</th>									
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
				</div>

			</div>
		</div>

		<div class="divRow" style="height:40px;">
			<div class="divColumn" style="width:100%;">
				<%--<div class="divRowInCol">
					--%><input type="radio" name="hooktype" value="5" checked="checked"><span>挂接为子女</span>
					<input type="radio" name="hooktype" value="6"><span>挂接为嗣子（出继）</span>
					<input type="radio" name="hooktype" value="7"><span>挂接为祧子</span>
					<input type="radio" name="hooktype" value="8"><span>挂接为后代（需要添加虚拟人物节点）</span>
				</div>
			
		</div>
	</div>
</div>
<script>
	var searchAction = '${pageContext.request.contextPath}/tIndividualAction!searchPerson.action';

	function doSearch(value) {
		if(value == '' || value == undefined){
			$.messager.show({
                title:'提示',
                msg:'请输入搜索内容',
                timeout:1000,
                showType:'slide'
            });
			return;
		}
		$.post(searchAction, {
			searchName : value, 
			pediId : $('#peditree').combobox('getValue')
		}, function(data) {
			var rData = jQuery.parseJSON(data)	;
			if (rData.success) {					
				$('#search-result').datagrid('loadData',rData.obj);				
			} else {
				alert('未搜索到结果');
			}
		});
	}
	$(function() {
		$('#search-result').datagrid({
			onSelect:function(index, row){
				//alert(row.name);
				$('label[name="person2"]').html('<strong>'+row.name+'</strong>');
			}
		});
	});
	$('input[name="hooktype"]').change(function(){
		var hooktype = $('input[name="hooktype"]:checked').val();		
		var type = '子女';
		switch (hooktype){
			case '6':
				type = '子嗣';
				break;
			case '7':
				type = '祧子';
				break;
			default:
				break;
		}		
		$('label[name="reltype"]').html('<strong>'+type+'</strong>');
	});	
</script>
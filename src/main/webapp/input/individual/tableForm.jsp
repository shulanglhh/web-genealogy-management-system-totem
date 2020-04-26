<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<style>
div .div-row{
	margin-top:10px;
}

</style>

<table id="tableForm" class="easyui-datagrid" data-options="toolbar:'#tableForm-toolbar',	
	title:'人物详细信息',rownumbers:true,fit:true,singleSelect: true,fitColumns:true,
	idField:'name',
	onDblClickRow:onDblClickTableRow">
	<thead>
		<tr class="datagrid-header">
			<th data-options="field:'ggen',sortable:true,
			editor:{
				type:'numberbox',
				options:{
					disable:true
				}
			}">世序</th>
			
			<th data-options="field:'sex', editor:{type:'combobox',
			options:{valueFiled:'value',textField:'text',editable:false,required:true,  
			data:[{value:'男', text:'男'},{value:'女', text:'女'}]}}">性别</th>
			
			<th data-options="field:'name',			
			editor:{
			 	type:'validatebox',
			 	options:{
			 		required:true,
			 		validType:'length[1,20]'
			 	}
			 }">谱名</th>			
			<th data-options="field:'fullname', editor:'text'">姓名</th>			
			
			<th data-options="field:'fathername', editor:{type:'combobox',
			options:{valueFiled:'value',editable:false, textField:'text'}}">父亲谱名</th><%--父关系--%>	
					
			<th data-options="field:'birthdaydetail', 
			editor:{
				type:'datebox', 
				options:{
					formatter:function(date){
						var y = date.getFullYear();
						var m = date.getMonth()+1;
						var d = date.getDate();
						return y+'-'+m+'-'+d+' 00:00:00';
					}
				}
			}">出生日期</th>
			
			<th data-options="field:'borntime', editor:{type:'combobox', 
			options:{valueFiled:'value',textField:'text', editable:false, 
			data:time}}">出生时辰</th>
			
		    <th data-options="field:'islive', 		    
		    editor:{
		    	type:'combobox', 
				options:{
					valueFiled:'value',textField:'text', 
					editable:false, required:true,
					data:[{value:'true', text:'生'},{value:'false', text:'卒'}]					
				}
			},
			formatter:function(value,row,index){						
				if(row.islive == 'true')
					return '生';
				else if(row.islive == 'false')
					return '卒';
			}">生死状况</th>
			
		    <th data-options="field:'deathday', editor:{type:'datebox'}">去世日期</th>
		    
		    <th data-options="field:'deathtime', editor:{type:'combobox', 
			options:{valueFiled:'value',textField:'text', editable:false, 
			data:time}}">去世时辰</th>
			
		    <th data-options="field:'graveyard', editor:'text'">葬地及朝向</th>		    
		   	<th data-options="field:'education', editor:'text'">文化程度</th>		   	
		   	<th data-options="field:'duty', editor:'text'">职务</th>		   	
		   	<th data-options="field:'officialtitle', editor:'text'">职称</th>
		   	
		   	<th data-options="field:'spouse',  editor:{type:'combobox',
			options:{valueFiled:'value',editable:false, textField:'text'}}">配偶谱名</th> 
			          	
		   	<th data-options="field:'spousedsc', editor:'text'">配偶家描述</th>
		   	<th data-options="field:'remark', editor:'text'">备注</th>
		</tr>
	</thead>    	
	<tbody>
		<tr></tr>
   	</tbody>
</table>
<div id="tableForm-toolbar" style="padding:5px;height:auto">
	<div style="margin-bottom:5px">
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true"
			onclick="appendOne()">增加</a> <a class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="removeIt()">删除</a>
		<a class="easyui-linkbutton" iconCls="icon-save" plain="true"
			onclick="acceptIt()">保存</a> <a class="easyui-linkbutton"
			iconCls="icon-undo" plain="true" onclick="rejectIt()">撤销</a>
		<a class="easyui-linkbutton" id="submit-table"
			iconCls="icon-save" plain="true" onclick="saveAll()">提交</a>
	</div>
</div>
<script type="text/javascript">
	var t_editIndex = undefined;
	var newRow = {sex:'男',name:'新人物',islive:'true'};
	var time = [
	            {value:'子时', text:'子时'},{value:'丑时', text:'丑时'},
	            {value:'寅时', text:'寅时'},{value:'卯时', text:'卯时'},
	            {value:'辰时', text:'辰时'},{value:'巳时', text:'巳时'},
	            {value:'午时', text:'午时'},{value:'未时', text:'未时'},
	            {value:'申时', text:'申时'},{value:'酉时', text:'酉时'},
	            {value:'戌时', text:'戌时'},{value:'亥时', text:'亥时'}
	            ];
	function endEditing(){
	    if (t_editIndex == undefined){return true;}	 
	    
	    if ($('#tableForm').datagrid('validateRow', t_editIndex)){    	
	    	
	    	var ed = $('#tableForm').datagrid('getEditor', {index:t_editIndex, field:'fathername'});
	    	var edd = $('#tableForm').datagrid('getEditor', {index:t_editIndex, field:'spouse'});
	    	var eddd = $('#tableForm').datagrid('getEditor', {index:t_editIndex, field:'sex'});
	    	var father = $(ed.target).combobox('getValue');
	    	var spouse = $(edd.target).combobox('getValue');
	    	var sex = $(eddd.target).combobox('getValue');	
	    	
	    	var prevperson = father;
	    	if((spouse != null && spouse != '')){
	    		prevperson = spouse;
	    		if(((father != null && father != '') || sex != '女')){
	    			alert('父亲或者配偶只能添加一个，添加配偶时不能为男性');
		    		$(ed.target).combobox('setValue', '');
		    		$(edd.target).combobox('setValue', '');
		    		return false;//判断父亲和配偶的逻辑
	    		}
	    		
	    	}
	    	var prevggen;
	    	if(prevperson == null || prevperson == ''){
	    		prevggen = 0;
	    	}
	    	else{
	    		prevggen = getGgen(prevperson);
	    	}
	    	var curggen = parseInt(prevggen) + 1;
	    		//prevggen = getGgen(prevperson);
	    	//console.info(prevggen+1);
	    	var edggen = $('#tableForm').datagrid('getEditor', {index:t_editIndex, field:'ggen'});
	    	$(edggen.target).numberbox('setValue', curggen);
	    	
	        $('#tableForm').datagrid('endEdit', t_editIndex);
	        
	        var row = $('#tableForm').datagrid('selectRow', t_editIndex).datagrid('getSelected');
		    var name = row.name;		    
		    var rows = $('#tableForm').datagrid('getRows');		    
		    for(var i = 0; i < rows.length; i++){			    	
		    	if(i != t_editIndex){	    	
			    	if(name == rows[i].name){
			    		$.messager.alert('注意','名字不能重复');
			    		$('#tableForm').datagrid('beginEdit', t_editIndex);
			    		showComboboxContent(t_editIndex);
			    		return false;
			    	}		    	
			    }	    	
		    }
	        
	        t_editIndex = undefined;
	        return true;
	    } else {
	        return false;
	    }
	}
	function onDblClickTableRow(index){
	    if (t_editIndex != index){
	        if (endEditing()){
	            $('#tableForm').datagrid('selectRow', index)
	                    .datagrid('beginEdit', index);
	            t_editIndex = index;
	            
	            showComboboxContent(t_editIndex);
	        } else {
	            $('#tableForm').datagrid('selectRow', t_editIndex);
	        }
	    }
	}
	
	function showComboboxContent(index){
		var allPersons = new Array();
	    var rows = $('#tableForm').datagrid('getRows');		    
	    for(var i = 0; i < rows.length; i++){	    	
	    	if(i != index){	    	
		    	var name = rows[i].name;
		    	allPersons.push({value:name, text:name});
		    }	    	
	    }
	    var ed = $('#tableForm').datagrid('getEditor', {index : index,field : 'fathername'});	
	    var edd = $('#tableForm').datagrid('getEditor', {index : index,field : 'spouse'});	

	    if(allPersons.length > 0){
	    	$(ed.target).combobox('loadData', allPersons);
	    	$(edd.target).combobox('loadData', allPersons);
	    }
	}

	function appendOne(){
	    if (endEditing()){
	        $('#tableForm').datagrid('appendRow',{sex:'男',name:'新人物', islive:'true'});//important，解决重复问题
	        t_editIndex = $('#tableForm').datagrid('getRows').length-1;
	        $('#tableForm').datagrid('selectRow', t_editIndex)
	                .datagrid('beginEdit', t_editIndex);
	        
		 	showComboboxContent(t_editIndex);
	    }
	}
	function removeIt(){
		var selectIdx = $('#tableForm').datagrid('getRowIndex',$('#tableForm').datagrid('getSelected'));
		$('#tableForm').datagrid('cancelEdit', selectIdx).datagrid('deleteRow', selectIdx);
	    if (t_editIndex == undefined){		    	
			return;
		}
	    $('#tableForm').datagrid('cancelEdit', t_editIndex)
	            .datagrid('deleteRow', t_editIndex);
	    t_editIndex = undefined;
	}
	function acceptIt(){
	    if (endEditing()){
	        $('#tableForm').datagrid('acceptChanges');
	    }
	}
	function rejectIt(){
	    $('#tableForm').datagrid('rejectChanges');
	    t_editIndex = undefined;
	}
	
	/**将入谱登记表录入的所有人物保存到数据库，成功后清空数据。*/
	function saveAll(){
		if(!endEditing()){
			$.messager.show({
				title:'提示',
				msg:'请编辑完成后再提交'
			});
			return false;
		}
		var pediId = $('#peditree').combobox('getValue');
		if(pediId == null || typeof pediId == 'undefined' || pediId == ''){
			alert('请先选择族谱');
			return false;
		}
		var rows = $('#tableForm').datagrid('getRows');
		if(rows.length < 1 || rows[0].name == '' 
				|| rows[0].name == null || typeof rows[0].name == 'undefined'){			
			//alert(rows[0].name);
			return;
		}		
		//alert(rows[0].name);
		jsonRows = JSON.stringify(rows);		
		$('#submit-table').linkbutton('disable');		
		$.ajax({			
			type : 'post',
			data : 'rows=' + jsonRows + '&userId=' + userid + '&pediId=' + pediId,
			url : '${pageContext.request.contextPath}/tIndividualAction!saveTableRows.action',//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('请检查网络');
				$('#submit-table').linkbutton('enable');
			},
			success : function(j) { //请求成功后处理函数。  
				var rObj = eval('(' + j + ')');
				if(rObj.success){
					alert('保存成功');//PediStatistics						
					var record = {
							pid:$('#peditree').combobox('getValue'),
							text:$('#peditree').combobox('getText')
					};												
					initPediTree(record, null);
					$('#tableFormTab').panel('refresh','tableForm.jsp');
				}
				else{
					alert('保存失败');
					$('#submit-table').linkbutton('enable');
				}
			}
		});
	}
	
	function getGgen(pname){
		if(pname == '' || pname == null || typeof pname == 'undefined')
			return 0;
		var rows = $('#tableForm').datagrid('getRows');
		if(rows.length == 0)
			return 0;
		for(var i = 0; i < rows.length; i++){
			if(rows[i].name == pname){
				return rows[i].ggen;
			}			
		}
	}
	
</script>
<%-- <table id="dg" class="easyui-datagrid" title="Row Editing in DataGrid" style="width:700px;height:auto"
            data-options="
                iconCls: 'icon-edit',
                singleSelect: true,
                toolbar: '#tb',                
                onClickRow: onClickRow
            ">
        <thead>
            <tr>
               
                <th data-options="field:'listprice',width:80,align:'right',editor:{type:'numberbox',options:{precision:1}}">List Price</th>
                <th data-options="field:'unitcost',width:80,align:'right',editor:'numberbox'">Unit Cost</th>
                <th data-options="field:'attr1',width:250,editor:'text'">Attribute</th>
                <th data-options="field:'status',width:60,align:'center',editor:{type:'checkbox',options:{on:'P',off:''}}">Status</th>
            </tr>
        </thead>
    </table>
 
    <div id="tb" style="height:auto">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append()">Append</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">Remove</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">Accept</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="reject()">Reject</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">GetChanges</a>
    </div>
    
    <script type="text/javascript">
        var editIndex = undefined;
        function endEditing(){
            if (editIndex == undefined){return true}
            if ($('#dg').datagrid('validateRow', editIndex)){
               
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickRow(index){
            if (editIndex != index){
                if (endEditing()){
                    $('#dg').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#dg').datagrid('selectRow', editIndex);
                }
            }
        }
        function append(){
            if (endEditing()){
                $('#dg').datagrid('appendRow',{status:'P'});
                editIndex = $('#dg').datagrid('getRows').length-1;
                $('#dg').datagrid('selectRow', editIndex)
                        .datagrid('beginEdit', editIndex);
            }
        }
        function removeit(){
            if (editIndex == undefined){return}
            $('#dg').datagrid('cancelEdit', editIndex)
                    .datagrid('deleteRow', editIndex);
            editIndex = undefined;
        }
        function accept(){
            if (endEditing()){
                $('#dg').datagrid('acceptChanges');
            }
        }
        function reject(){
            $('#dg').datagrid('rejectChanges');
            editIndex = undefined;
        }
        function getChanges(){
            var rows = $('#dg').datagrid('getChanges');
            alert(rows.length+' rows are changed!');
        }
    </script>--%>
    
    
    <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<style>
div .div-row{
	margin-top:10px;
}
</style>

<table id="tableForm" class="easyui-datagrid" data-options="toolbar:'#tableForm-toolbar',	
	title:'人物详细信息',rownumbers:true,fit:true,singleSelect: true,
	onDblClickRow:onDblClickTableRow">
	<thead>
		<tr class="datagrid-header">
			<th data-options="field:'ggen',sortable:true">世序</th>
			

			
			<th data-options="field:'name',			
			editor:{
			 	type:'validatebox',
			 	options:{
			 		required:true,
			 		validType:'length[1,20]'
			 	}
			 }">谱名</th>			
				
			
			<th data-options="field:'fathername', editor:{type:'combobox',
			options:{valueFiled:'value',editable:false, textField:'text'}}">父亲谱名</th><%--父关系--%>	

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
	</div>
</div>
<script type="text/javascript">
	var t_editIndex = undefined;
	var newRow = {sex:'男',name:'新人物'};
	var fathers = {father : [{value:'生', text:'生'},{value:'卒', text:'卒'}]};	
	function endEditing(){
	    if (t_editIndex == undefined){return true;}
	    if ($('#tableForm').datagrid('validateRow', t_editIndex)){	       
	        $('#tableForm').datagrid('endEdit', t_editIndex);
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
	        } else {
	            $('#tableForm').datagrid('selectRow', t_editIndex);
	        }
	    }
	}

	function appendOne(){
	    if (endEditing()){
		 /*   var curFathers = new Array();
		    var rows = $('#tableForm').datagrid('getRows');
		    console.info(rows);
		    for(var i = 0; i < rows.length; i++){	    	
		    	if(i != t_editIndex){	    	
			    	var name = rows[i].name;
			    	console.info(rows[i]);
			    	curFathers.push({value:name, text:name});
			    }	    	
		    }*/
	        $('#tableForm').datagrid('appendRow',{name:'a'});
	        t_editIndex = $('#tableForm').datagrid('getRows').length-1;
	        $('#tableForm').datagrid('selectRow', t_editIndex)
	                .datagrid('beginEdit', t_editIndex);
		    //var ed = $('#tableForm').datagrid('getEditor', {index : t_editIndex,field : 'fathername'});	

		   /// if(curFathers.length > 0)
		    //	$(ed.target).combobox('loadData', curFathers);
	    }
	}
	function removeIt(){
	    if (t_editIndex == undefined){		
	    	var selectIdx = $('#tableForm').datagrid('getRowIndex',$('#tableForm').datagrid('getSelected'));
			$('#tableForm').datagrid('cancelEdit', selectIdx).datagrid('deleteRow', selectIdx);
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
	function getChanges(){
	    var rows = $('#tableForm').datagrid('getChanges');
	    alert(rows.length+' rows are changed!');
	}
	
</script>
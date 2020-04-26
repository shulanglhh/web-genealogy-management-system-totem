<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>隐藏管理(录入)</title>
<jsp:include page="../inc.jsp"></jsp:include>
</head>

<body class="easyui-layout" data-options="fit:true">
 <div data-options="region:'north'" style="height:50px;overflow:hidden;">
		<div align=right>
		<span>
			<jsp:include page="../header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'菜单',split:true"
		style="width:200px">
		<jsp:include page="../newnav.jsp"></jsp:include>
	</div>
    <div data-options="region:'center',title:'隐藏管理'" style="padding:5px;background:#eee;">
    	<div class="easyui-layout" data-options="fit:true">
    		<div data-options="region:'west',title:'选择族谱',split:false" style="width:250px">
    			<table width='100%'>
    				<tr><td>
    				<select name="rname" id="rname">
				    </select>
				    </td></tr>
				    </table>
				    <table width='100%'>
				    <tr><td width='60'>起始世代</td><td><input type="text" name="start" id="str" size="8" /></td></tr>
    				<tr><td width='60'>结束世代</td><td><input type="text" name="end" id="end" size="8" /></td></tr>
    				<tr><td><button id="confirm">确定</button></td></tr>
    			</table>
    	    </div>
    	    <div data-options="region:'center'" style="padding:5px;background:#eee;">
    	        <table id="cc">
            </table>
    	    </div>
    	</div>
    </div>
    
<div id="tb" style="height:auto">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
</div>
    <script type="text/javascript">
    $(function(){
  	  $('#navbar').accordion('select', '数据管理');
    });
    var editIndex = undefined;   //正在编辑的行
    function endEditing(){   //判断编辑状态是否结束，false表示正在编辑
    	if (editIndex == undefined){
    		return true;   //不在编辑状态
    		}
    	if ($('#cc').datagrid('validateRow', editIndex)){
    	$('#cc').datagrid('endEdit', editIndex);
    	editIndex = undefined;
    	return true;  //不在编辑状态
    	} else {
    		alert("aaaa");
    	return false;
    	}
    }
    function onClick(index){
    	//alert("editindex"+" "+editIndex+" "+"index"+index);
    	if (editIndex != index){  //换行编辑,
    	if (endEditing()){  
    	$('#cc').datagrid('selectRow', index).datagrid('beginEdit', index);
    	editIndex = index;
    	} else {
    	$('#cc').datagrid('selectRow', editIndex);
    	}
    	}
    }
    
    function accept(){
    	if (endEditing()){ //编辑结束
    	var rows = $('#cc').datagrid('getChanges');
        	for(var i=0;i<rows.length;i++){
        		$.post('${pageContext.request.contextPath}/tPhotoAction!savechange.action',{"pid":rows[i]["pid"],"hiddenchild":rows[i]["hiddenchild"],"inbiology":rows[i]["inbiology"],"inrelation":rows[i]["inrelation"]});
        	}
        	 $('#cc').datagrid('acceptChanges');
    	}
    	 var pid=$('#rname option:selected').val();
 		 var str=$("#str").val();
 		 var end=$("#end").val();
    	 $.post('${pageContext.request.contextPath}/tPhotoAction!showped.action',{"pid":pid,"start":str,"end":end},function(data){
    		 $("#cc").datagrid('reload');
    		 var r = eval('(' + data + ')');
    		 
    		 $("#cc").datagrid('loadData',r);
    	 });
    	
    	}
    
    </script>
    <script>
    function tool(value,row,index){
        if (value){
        	return '是';
        } else {
    	   return '否';
        }
      }
    
    $(document).ready(function(){
    	$.post('${pageContext.request.contextPath}/genealogyAction!showpname.action',function(data){
    		var rObj = eval('(' + data + ')');
    		var obj=rObj.obj;
    		for(var i=0;i<obj.length;i++){
    			$("#rname").append("<option value='"+obj[i][0]+"'>"+obj[i][1]+"</option>");
    		}
    	});
    	
    	$("#confirm").click(function(){
    		var pid=$('#rname option:selected').val();
    		var str=$("#str").val();
    		var end=$("#end").val();
    	     $("#cc").datagrid({
    	    	    method:'post',
    	        	url: '${pageContext.request.contextPath}/tPhotoAction!showped_input.action?pid='+pid+'&start='+str+'&end='+end,
    	       		singleSelect:true,
    	       		toolbar:'#tb',
    	       		onClickRow:onClick,
    	       		pagination:true,
    	       		idField:'pid',  
    	       		columns:[[
    	          	        { field: 'pid', title: '人物id' },
    	          	        { field: 'name', title: '谱名' },
    	          	        { field: 'sex', title: '性别' },
    	          	        { field: 'father', title: '父亲谱名' },
    	          	        { field: 'ggen', title: '世代'},
    	          	        { field:'hiddenchild',title:'隐藏子女',editor:{formatter:tool,type:'checkbox',options:{on:'是',off:'否'}}},
    	          	        { field: 'inbiology', title: '行传中显示',editor:{formatter:tool,type:'checkbox',options:{on:'是',off:'否'}}},
    	          	        { field:'inrelation',title: '吊线图中显示',editor:{formatter:tool,type:'checkbox',options:{on:'是',off:'否'}}}
    	          	    ]],
    	          	  title:'族谱成员列表'
    	     });
    			
    	});
    	
    });
    </script>
</body>
</html>
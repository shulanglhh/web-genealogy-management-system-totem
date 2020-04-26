<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>照片管理(录入)</title>
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
    <div data-options="region:'center',title:'照片管理'" style="padding:5px;background:#eee;">
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
    
    <!--  上传文件-->
           <div id="dlg1" class="easyui-dialog" title="照片文件上传" data-options="closed:true,buttons:[{
  					text:'上传',
  				iconCls:'icon-help',
  				handler:function(){
  				$('#uploadfile1').submit();
  				}
  			},{
  				text:'重置',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#uploadfile1')[0].reset();
  				}
  				}]" style="width:350px;height:110px">
          <form  method="post" id='uploadfile1' enctype="multipart/form-data">
			<table>
				<tr><td>请选择文件</td><td><input id='file1' type="file" name="myFile" class="easyui-validatebox" data-options="required:true" /><input type="hidden" name="uid" id='pid1' /></td></tr>
			</table>    	
    	</form>
    	</div>
       
       <!--  上传文件-->
           <div id="dlg2" class="easyui-dialog" title="照片文件上传" data-options="closed:true,buttons:[{
  					text:'上传',
  				iconCls:'icon-help',
  				handler:function(){
  				$('#uploadfile2').submit();
  				}
  			},{
  				text:'重置',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#uploadfile2')[0].reset();
  				}
  				}]" style="width:350px;height:110px">
          <form  method="post" id='uploadfile2' enctype="multipart/form-data">
			<table>
				<tr><td>请选择文件</td><td><input id='file2' type="file" name="myFile" class="easyui-validatebox" data-options="required:true" /><input type="hidden" name="uid" id="pid2" /></td></tr>
			</table>    	
    	</form>
       </div>
       
       <!--  裁切文件-->
      <div id="img-edit-window" class="easyui-window" title="编辑上传图片" data-options="modal:true,closed:true,iconCls:'icon-save',buttons:'#win-buttons'" style="width:960px;height:700px;padding:10px;">
	<jsp:include page="./imgEdit1.jsp"></jsp:include>
	<div id="win-buttons">			
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#img-edit-window').window('close');">关闭</a>
		</div>		
</div>
       
       
    <script>
    
    function openImgEditWindow(windowId){
    	$(windowId).window('open');

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
    	    	   toolbar: [{
    	    			iconCls: 'icon-edit',
    	    			text:'上传',
    	    			handler: function(){
    	    				var obj=$("#cc").datagrid("getSelected");
    	                	if(obj==null)
    	                	alert("必须选中一行记录");
    	                	else if(!obj.photourl)    //无照片的上传
    	                	{
    	                		$("#dlg1").dialog('open');
    	                		$("#pid1").val(obj.pid);
    	                	}else{       //有照片的上传
    	                		$("#dlg2").dialog('open');
    	                		$("#pid2").val(obj.pid);
    	                	}
    	    				}
    	    		},'-',{
    	    			iconCls: 'icon-remove',
    	    			text:'删除',
    	    			handler: function(){
    	    				var obj=$("#cc").datagrid("getSelected");
    	                	if(obj==null)
    	                	alert("必须选中一行记录");
    	                	else if(!obj.photourl)
    	                	{
    	                		alert("该用户没有照片！");
    	                	    return;
    	                	}else{
    	                		var pid=$('#rname option:selected').val();
    	                		$.post("${pageContext.request.contextPath}/tPhotoAction!deletephoto.action",{'pid':obj.pid},function(){
    	                			alert("删除成功！");
    	                			$("#cc").datagrid('reload');
    	                		});
    	                		}
    	    				}
    	    		},'-',{
    	    			iconCls: 'icon-cut',
    	    			text:'裁切',
    	    			handler: function(){
    	    				var obj=$("#cc").datagrid("getSelected");
    	                	if(obj==null)
    	                	alert("必须选中一行记录");
    	                	else if(!obj.photourl)
    	                	{
    	                		alert("该用户没有照片！");
    	                	    return;
    	                	}else{
    	                		var src='<%=path %>/photo/'+obj.photourl;
    	                		$("#treeid").attr("value",obj.pid);
    	                		//$('#img-edit').attr('src', src);
    	                		jcrop_api.setImage(src);
    	                		jcrop_api.release();
    	                		$("#img-small").attr('src', src);
    	                		openImgEditWindow('#img-edit-window');
    	                	}
    	    			}
    	    		}
    	    		],
    	    	    method:'post',
    	        	url: '${pageContext.request.contextPath}/tPhotoAction!showphoto_input.action',
    	       		singleSelect:true,
    	       		queryParams:{"pid":pid,"start":str,"end":end},
    	       		pagination:true,
    	       		idField:'pid',  
    	       		columns:[[
    	       		    { field: 'pid', title: '人物id',width:100},
   	          	        { field: 'name', title: '谱名',width:100 },
   	          	        { field: 'sex', title: '性别',width:100 },
   	          	        { field: 'father', title: '父亲谱名',width:100},
   	          	        { field: 'ggen', title: '世代',width:100},
   	          	        { field: 'photourl', title: '照片',width:51,
   	          	        	formatter: function(value,row,index){
   	          	        		if(value!=""&&value!=null)
   	 				       	 return "<img src='../photo/"+value+"' width='50' height='50'></img>";
   	 				       	 else
   	 				       		 return value;
   	 				         }
   	 			        },
    	          	    ]],
    	          	  title:'族谱成员照片列表'
    	     });
    			
    	});
    	
    	
    	$("#uploadfile1").form( {
       		url:'${pageContext.request.contextPath}/fUploadAction!uploadFile1.action',
       		onSubmit: function(){
       		if($("#file1").val()=="")
       			return false;
       		},
       		 success: function(data){
       			$("#dlg1").dialog('close');
       			var rObj = eval('(' + data + ')');
       			if(rObj.success==false)
       				alert("上传失败");
                 else {
                 alert("上传成功");
                 $("#cc").datagrid('reload');
                 }
       		}
       		});
    	
    	$("#uploadfile2").form( {
       		url:'${pageContext.request.contextPath}/fUploadAction!uploadFile2.action',
       		onSubmit: function(){
       		if($("#file2").val()=="")
       			return false;
       		},
       		 success: function(data){
       			$("#dlg2").dialog('close');
       			var rObj = eval('(' + data + ')');
       			if(rObj.success==false)
       				alert("上传失败");
                 else {
                 alert("上传成功");
                 $("#cc").datagrid('reload');
                 }
       		}
       		});
    });
    </script>
</body>
</html>
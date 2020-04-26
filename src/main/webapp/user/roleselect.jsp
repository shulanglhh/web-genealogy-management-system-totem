<%@ page language="java" contentType="text/html;" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>角色管理</title>
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
    <div data-options="region:'center',title:'角色管理'" style="padding:5px;background:#eee;">
    	<table id="cc" class="easyui-datagrid" data-options="method:'post',border:false,singleSelect:true,toolbar:toolbar,pagination:true">
                <thead>
                    <tr>
                        <th data-options="field:'roleid'" width="60">角色 ID</th>
                        <th data-options="field:'rolename'" width="120">角色名</th>
                        <th data-options="field:'preset'" width="60">是否预置</th>
                    </tr>
                </thead>
            </table>
    </div>
 <script type="text/javascript">
        var toolbar = [{
            text:'添加新角色',
            iconCls:'icon-add',
            handler:function(){alert('add')}
        },{
            text:'删除角色',
            iconCls:'icon-remove',
            handler:function(){
            	var obj=$("#cc").datagrid("getSelected");
            	if(obj==null)
            	alert("必须选中一行记录");
            	else 
            	if(obj.preset)
            	alert("不得删除预置角色");
            	}
        }];
        
        $(function() {
        	$.ajax({  
	        async :false,  
	        cache:false,  
	        type: 'post', 
        url:'${pageContext.request.contextPath}/userAction!showRoles.action',//请求的action路径  
	        error: function () {//请求失败处理函数  
	            alert('获取角色列表失败');  
	        },  
        success:function(j){ //请求成功后处理函数。  
        	var rObj = eval('(' + j + ')');
        	//var rObj = jQuery.parseJSON(j);
	            //alert(j);  
	           //alert(rObj.msg);
	        	if (rObj.success) {
	        		$("#cc").datagrid('loadData', rObj.obj);
					}
	        	else{alert(rObj.msg);}
	        }  
	    });
        });
    </script>
  </body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>团队修改</title>
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
<div title="编辑团队" data-options="region:'center',iconCls:'icon-ok'">
         <div style="padding:60px 60px 60px 60px">
          <form method="post" id='editteam'>
               <input type="hidden" name="tid" value="<%=request.getParameter("tid")%>">
			<table>
				<tr><td><b>团队名</b></td><td><input type="text" id="tname" name="teamname" class="easyui-validatebox" data-options="required:true" /></td></tr>
				<tr><td><b>可选团队人员</b></td>
				<td>
				   <ul id="member"></ul>
				</td>
				</tr>
				<tr><td><button type="submit">提交</button></td><td><button type="reset">重置</button></td></tr>
			</table>    	
    	</form>
    	</div>
    	</div>
  <script type="text/javascript">
  $(document).ready(function(){
  $("#editteam").form( {
 		url:'${pageContext.request.contextPath}/userAction!editteam.action',
 		onSubmit: function(){
 		if($(":checkbox").val()=="")
 			return false;
 		else if($("#tname").val()=="")
 			return false;
 		},   
 		 success: function(data){
           alert("修改成功");
           window.close();  
 		}
 		});
  
  $.post("${pageContext.request.contextPath}/userAction!getteamname.action","tid="+<%=request.getParameter("tid")%>,function(data){
	    var m = eval('(' + data + ')');
		var mem=m.obj;
		$("#tname").val(mem.teamname);
  });
  
  
  $.post("${pageContext.request.contextPath}/userAction!showMem.action","tid="+<%=request.getParameter("tid")%>,function(data){
	    var m = eval('(' + data + ')');
		var mem=m.obj;
		$("#member").find("*").remove();
		for(var i=0;i<mem.length;i++){
			if(mem[i].selected)
			$("#member").append("<li><label><input name='userlist' type='checkbox' checked='true' value='"+mem[i].username+"' />"+mem[i].username+"</label></li>");
			else
			$("#member").append("<li><label><input name='userlist' type='checkbox' value='"+mem[i].username+"' />"+mem[i].username+"</label></li>");
				
			
		}
  });
  
  /*
  $.post("${pageContext.request.contextPath}/userAction!teammem.action","tid="+<%=request.getParameter("tid")%>,function(data){
/*		var m = eval('(' + data + ')');
		var mem=m.obj;
		$("body").data("teamlist",mem);
	});
	
	
	$.post("${pageContext.request.contextPath}/userAction!accessUser.action",function(data){
		var teamlist=$("body").data("teamlist");
		var j = eval('(' + data + ')');
		var ob=j.obj;
		$("#member").find("*").remove();
		var flag=false;
		for(var j=0;j<ob.length;j++){
			var username=ob[j].username;
			for(var k=0;k<teamlist.length;k++)
			{   
				if(username==teamlist[k].mname)
				{	flag=true;
				   break;
				}
			}
			if(flag)
			{$("#member").append("<li><label><input name='userlist' type='checkbox' checked='true' value='"+username+"' />"+username+"</label></li>");
			  flag=false;
			}else
			$("#member").append("<li><label><input name='userlist' type='checkbox' value='"+username+"' />"+username+"</label></li>");
		}
	});  
	**/
  });  
  </script>
  </body>
</html>

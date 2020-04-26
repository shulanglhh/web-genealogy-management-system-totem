<%@page import="pedi.action.UserAction"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
%>
<html>
<head>
<title>谱志寻根数字化系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
#__01 tr td form table tr td {
	font-family: "Arial Black", Gadget, sans-serif;
}
</style>
<jsp:include page="inc.jsp"></jsp:include>
</head>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#login").click(function(){
		if($("#username").val()==null||$("#username").val()=="")
		{
			alert("用户名不能为空!");
			return false;
		}else if($("#pwd").val()==null||$("#pwd").val()=="")
		{
			alert("密码不能为空!");
			return false;
		}
		$('#index_loginForm').submit();
	});
	
	$("#reset").click(function(){
		$('#index_loginForm')[0].reset();
	});	
	$('#index_loginForm').form({
		url : '${pageContext.request.contextPath}/userAction!login.action',
		success : function(r) {
			var obj = jQuery.parseJSON(r);
			if (obj.success) {
				
				window.location.href="funcNavi.jsp";
			}
			$.messager.show({
				title : '提示',
				msg : obj.msg
			});
		}
});
	$('#index_loginForm input').bind('keyup', function(event) {/* 增加回车提交功能 */
		if (event.keyCode == '13') {
			$('#index_loginForm').submit();
		}
	});

	window.setTimeout(function() {
		$('#index_loginForm input[name=name]').focus();
	}, 0);
});
</script>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- Save for Web Slices (未标题-1) -->
<table width="1400" height="647" border="0" align="center" cellpadding="0" cellspacing="0" id="__01">
	<tr>
		<td colspan="3">
			<img src="images/test_01.jpg" width="1400" height="180" alt=""></td>
	</tr>
	<tr>
		<td rowspan="2">
			<img src="images/test_02.jpg" width="886" height="467" alt=""></td>
		<td background="images/test_03.jpg" width="240" height="329">
		<form id="index_loginForm" method="post">
		  <table width="100%" height="175" border="0">
		    <tr>
		      <td width="33%">&nbsp;</td>
		      <td width="67%">&nbsp;</td>
	        </tr>
		    <tr>
		      <td align="right">用户名：</td>
		      <td>
	        <input style="width:150px" name="username" id="username" /></td>
	        </tr>
		    <tr>
		      <td align="right">密&nbsp;&nbsp;码：</td>
		      <td>
	          <input style="width:150px" type="password" name="password" id="pwd" /></td>
	        </tr>
		     <tr>
		     <td colspan="2" style="font-size:14px">&nbsp;&nbsp;&nbsp;还没有账号？<a href="#" 
		     style='padding-left:20px;text-decoration:none' id='reg'>立即注册</a>
		     <!--<a href="#" 
		     style='padding-left:10px;text-decoration:none' id='reginput'>地方志录入员注册</a>  -->
		     </td>
		     </tr>
		    
		    <tr>
		      <td colspan="2"><table width="100%" border="0">
		        <tr>
		          <td align="center"><a href="#" id="login"><img src="images/loginbutton.jpg" width="64" height="26"></a></td>
		          <td align="center"><a href="#" id="reset"><img src="images/cancelbutton.jpg" width="64" height="26"></a></td>
	            </tr>
	            <tr>
	            <td align="center"></td>
	        		<td align="center"></td>
	        	</tr>
	          </table></td>
	        </tr>
	      </table>
		  </form>
		 <!-- <p style="padding-left:10px"><img src='./images/docplug.jpg'  style="vertical-align:middle;"/><a href="<%=path.substring(0,path.lastIndexOf("/"))%>/pedione/plugin/PedigreePlugins.msi" style="font-size:12px;">系统插件下载</a>
			<img src='./images/font.jpg'  style="vertical-align:middle;"/><a href="<%=path.substring(0,path.lastIndexOf("/"))%>/pedione/plugin/publishor.zip" style="font-size:12px;">生成工具下载</a></p> -->
			<!-- <p style="padding-left:10px"><img src='./images/docplug.jpg'  style="vertical-align:middle;"/><a href="<%=path.substring(0,path.lastIndexOf("/"))%>/pedione/plugin/vc2010_x86.exe" style="font-size:12px;">插件运行环境下载(XP操作系统需要下载)</a></p>-->
			</td> 
			
		<td rowspan="2">
			<img src="images/test_04.jpg" width="274" height="467" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="images/test_05.jpg" width="240" height="138" alt=""></td>
	</tr>
</table>
<!-- End Save for Web Slices -->
<!--<div><a href="#" id="test"><img src="images/loginbutton.jpg" width="64" height="26"></a></div> -->
<script>
$(document).ready(function(){
	 var safecode="123455";
	 var brow=$.browser;
	    var bInfo="";
	    if(brow.msie){
		if(brow.version<10){
			 $.messager.alert('警告','您的IE浏览器版本太低!','warning');
			}
	    }
	    else if(brow.mozilla){
		if(brow.version>2){
			if(brow.version<10){
				 $.messager.alert('警告','您的IE浏览器版本太低!','warning');
				}
		}
		else{
			 $.messager.alert('警告','建议使用IE浏览器，否则一些功能不能使用!','warning');
		}
	    }
	    else{
	    	$.messager.alert('警告','建议使用IE浏览器，否则一些功能不能使用!','warning');
	    }
	$("#contain").hide();
	$("#reg").click(function(){
		var x=$("#index_loginForm").offset().left;
		var y=$("#index_loginForm").offset().top;
		$("#regtab").css("left",x);
		$("#regtab").css("top",y);
		$("#regtab").show();
		$("#contain").show();
		$("#roleinput").val("谱志录入员");
	});
	
	$("#reginput").click(function(){
		var x=$("#index_loginForm").offset().left;
		var y=$("#index_loginForm").offset().top;
		$("#regtab").css("left",x);
		$("#regtab").css("top",y);
		$("#regtab").show();
		$("#contain").show();
		$("#roleinput").val("方志录入员");
	});
	$("#regtab").hide();
	$("#getsafecode").click(function(){
		var reg =  /^\w+((.\w+)|(-\w+))@[A-Za-z0-9]+((.|-)[A-Za-z0-9]+).[A-Za-z0-9]+$/;		
		if($("#username2").val()==null||$("#username2").val()=="")
		{
			alert("邮箱不能为空!");
			return false;
		}else if($("#realname").val()==null||$("#realname").val()=="")
		{
			alert("密码不能为空!");
			return false;
		}else if(!reg.test($("#username2").val())){
			alert("邮箱格式不正确");
			return false;
		}
		$.post('<%=path %>/userAction!getsafecode.action',{"username":$("#username2").val()},function(data){
			var rOb = eval('(' + data + ')');
			safecode = rOb.msg;
			alert("验证码已发送");
		});
						
	});
$("#regdaili").click(function(){
	if($("#username2").val()==null||$("#username2").val()=="")
	{
		alert("邮箱不能为空!");
		return false;
	}
    else if($("#realname").val()==null||$("#realname").val()=="")
	{
		alert("密码不能为空!");
		return false;
	}else if($("#userEmail").val()==null||$("#userEmail").val()=="")
	{
		alert("验证码不能为空!");
		return false;
	}else if($("#userEmail").val()!=safecode){
		alert("验证码错误!");
		return false;
	}
	$.post('<%=path %>/userAction!insertdaili.action',{"username":$("#username2").val(),"role":$("#roleinput").val(),"realname":$("#realname").val()},function(data){
		var rObj = eval('(' + data + ')');
			if(rObj.success==false)
				{alert("此用户已被注册！");}    
        else {
        		alert("注册成功!可以登录系统");
        		safecode="666666";
        		
        	$("#regtab").hide();
        	$("#contain").hide();
        }
	});
});

$("#close").click(function(){
	$("#regtab").hide();
	$("#contain").hide();
});

        
});
</script>
<div id="contain" style='background-color: transparent;opacity:0.7;position:absolute;width:100%;height:100%;top:0;left:0'></div>

 <div data-options="region:'center'" style="padding:2px;background:#eee;float:right;position:absolute;z-index:1;" id='regtab'>
 	 <form method="post" id='newuser' action='<%=path %>/userAction!insertdaili.action'>
			<table>			    
				<tr><th width='68px' >邮&nbsp;&nbsp;箱</th><td><input type="text" id="username2" name="username" /></td></tr>				
				<tr><th width='68px' >真实姓名</th><td><input type="text" id="realname3" name="realname3" /></td></tr>				
				<tr><th width='68px' >密&nbsp;&nbsp;码</th><td><input type="password" id="realname" name="realname" /></td></tr>
				<tr><th width='68px' >验证码</th><td><input type="text" id="userEmail" name="userEmail" size="6" maxlength="6"/><a href="#" id="getsafecode">获取验证码</a></td></tr>
				<tr><td colspan="2" style='font-size:12px,color:#333'><input type="hidden" name="role" id="roleinput" value="谱志录入员" /></td></tr>
			    <tr>
		      <td colspan="2"><table width="100%" border="0">
		        <tr>
		          <td align="center"><a href="#" id="regdaili"><img src="images/regbutton.jpg" width="64" height="26"></a></td>
		          <td align="center"><a href="#" id="close"><img src="images/closebutton.jpg" width="64" height="26"></a></td>
	            </tr>
	          </table></td>
	        </tr>
			</table>    	
    	</form>
 </div>
</body>
</html>
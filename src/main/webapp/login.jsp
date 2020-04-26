<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Pedigree Demo</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<script type="text/javascript"
	src="jslib/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="jslib/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="jslib/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="jslib/jquery-easyui-1.3.2/themes/icon.css"
	type="text/css"></link>
<link rel="stylesheet"
	href="jslib/jquery-easyui-1.3.2/themes/bootstrap/easyui.css"
	type="text/css"></link>
<script type="text/javascript">
	$(function() {
		var usercode;
		//$('body').layout('collapse','west');
		$('#index_loginForm').form({
			url : '${pageContext.request.contextPath}/userAction!login.action',
			success : function(r) {
				//console.info(r);

				var obj = jQuery.parseJSON(r);
				if (obj.success) {
					//usercode=$('#index_loginForm input[name=name]').attr('value');
					//console.info(usercode);
					$('#index-login-dialog').dialog('close');
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
	function hidethemenu() {
		$('body').layout('collapse', 'west');
	}
</script>
<style type="text/css">
a:link,a:visited {
	color: blue;
	text-decoration: none;
}
</style>
</head>
<body class="easyui-layout">
	<div data-options="region:'north'" style="height:80px"></div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'功能导航',split:true,"
		style="width:200px">
		<ul id="fuctionTree" class="easyui-tree">
			<li><span>族谱制作</span>
				<ul>
					<li><span><a
							href="creatNewPedigree.jsp" target="centerCon"
							onclick="hidethemenu()">新建族谱</a> </span></li>
												<li><span><a
							href="input/individual/assigntask.jsp" target="centerCon"
							onclick="hidethemenu()">录入任务分配</a> </span></li>
					<li><span><a href=".jsp" target="centerCon">文档录入</a> </span></li>
					<li><span><a
							href="input/individual/individualInput.jsp" target="centerCon"
							onclick="hidethemenu()">世系数据录入</a> </span></li>
					<li><span><a href="rankNumEdit.jsp" target="centerCon" onclick="hidethemenu()">行号编辑</a>
					</span></li>
					<li><span><a href="#">整理世系数据</a> </span></li>
					<li><span><a href="detailSearch.jsp" target="centerCon"
							onclick="hidethemenu()">搜索修改</a> </span></li>
				</ul>
			</li>
			<li><span>族谱发布</span>
				<ul>
					<li><span><a href="#">分组管理</a> </span></li>
					<li><span><a href="#">谱志编排</a> </span></li>
					<li><span><a href="#">发布PDF</a> </span></li>
					<li><span><a href="#">发布电子书</a> </span></li>
					<li><span><a href="checkManger.jsp" target="centerCon"
							onclick="hidethemenu()">校对管理</a> </span></li>
					<li><span><a href="#">发布姓氏网站</a> </span></li>
				</ul>
			</li>
			<li><span>数据管理</span>
				<ul>
					<li><span><a href="#">文档模板管理</a> </span></li>
					<li><span><a href="photoManagement.jsp">照片管理</a> </span></li>
					<li><span><a href="#">隐藏管理</a> </span></li>
					<li><span><a href="#">排辈字管理</a> </span></li>
					<li><span><a href="#">世代管理</a> </span></li>
					<li><span><a href="#">数据备份</a> </span></li>
					<li><span><a href="#">数据恢复</a> </span></li>
				</ul>
			</li>
			<li><span>系统管理</span>
				<ul>
					<li><span><a href="user/userselect.jsp" target="centerCon">用户管理</a>
					</span>
					</li>
					<li><span><a href="user/roleselect.jsp" target="centerCon">角色管理</a>
					</span>
					</li>
					<li><span><a href="user/pedman.jsp" target="centerCon">谱志管理员管理</a>
					</span>
					</li>
					<li><span><a href="user/dailiman.jsp" target="centerCon">代理商管理</a>
					</span>
					</li>
					<li><span><a href="user/editor_input.jsp" target="centerCon">谱志编辑及录入人员管理</a>
					</span>
					</li>
					<li><span><a href="user/teamman.jsp" target="centerCon">团队管理</a>
					</span>
					</li>
					<li><span><a href="user/changeinfo.jsp" target="centerCon">当前用户信息修改</a>
					</span>
					</li>
					<li><span><a href="user/pwd.jsp" target="centerCon">修改密码</a>
					</span>
					</li>
				</ul>
			</li>
		</ul>

	</div>
	<div data-options="region:'center'" id="centerLayout">
		<iframe name="centerCon" width="100%" height="100%" frameborder="0">

		</iframe>
	</div>

	<div id="index-login-dialog" class="easyui-dialog"
		data-options="title:'登陆',closable:false,modal:true, buttons:[{
  				text:'取消',
  				iconCls:'icon-edit',
  				handler:function(){
  					$('#index_loginForm')[0].reset();
  				}
  			},{
  				text:'登陆',
  				iconCls:'icon-help',
  				handler:function(){
  				
  				$('#index_loginForm').submit();
  				}
  				}]">
		<form id="index_loginForm" method="post">
			<table>
				<tr>
					<th>登录名</th>
					<td><input name="username" class="easyui-validatebox"
						data-options="required:true,missingMessage:'登陆名称必填'" /></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input type="password" name="password"
						class="easyui-validatebox"
						data-options="required:true,missingMessage:'密码必填'" /></td>
				</tr>
				<tr><td><a href="user/dailireg.jsp">代理商注册</a></td></tr>
			</table>
		</form>
	</div>

</body>
</html>

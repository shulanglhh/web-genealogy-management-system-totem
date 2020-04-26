<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 页面的元信息 -->
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="谱志在线管理系统">

<!-- 包含的easyui库 -->
<script type="text/javascript"
	src="<%=path%>/jslib/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/jslib/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>

<script type="text/javascript"
	src="<%=path%>/jslib/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>

<link rel="stylesheet" class="easyuiTheme"
	href="<%=path%>/jslib/jquery-easyui-1.3.2/themes/ui-cupertino/easyui.css"
	type="text/css"></link>
<link rel="stylesheet"
	href="<%=path%>/jslib/jquery-easyui-1.3.2/themes/icon.css"
	type="text/css"></link>
	<script type="text/javascript">
	serializeObject = function(form) {
		var o = {};
		$.each(form.serializeArray(), function(index) {
			if (o[this['name']]) {
				o[this['name']] = o[this['name']] + "," + this['value'];
			} else {
				o[this['name']] = this['value'];
			}
		});
		return o;
	};
	</script>

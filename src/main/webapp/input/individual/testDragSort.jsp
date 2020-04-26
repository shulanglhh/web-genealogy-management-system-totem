<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
<title>dragsort Demo</title>
 <jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript"
	src="../../jslib/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>

<script type="text/javascript" src="../../jslib/jquery.dragsort-0.5.1.min.js"></script>
<script type="text/javascript" src="../../jslib/mousetrap.min.js"></script>
<script type="text/javascript" src="../../jslib/mousetrap-global-bind.min.js"></script>
</head>
<body>

<div id='container'></div>
<div class="easyui-panel" id="table-container" style="width:600px;height:200px;padding:10px;">
<table id="tbl" style="width:550px;display:block;height:200px;">

<tr class="table-tr"><td>a1</td><td>b1</td>
<td><input name="hiddenchild" data-itemidx="1" type="checkbox"/><label>不统计子女</label></td>
<td><a href="#" class="easyui-linkbutton" onclick="hotkeyDown('hiddenchild')">d</a>
<a href="#" class="easyui-linkbutton" onclick="hotkeyUp('hiddenchild')">u</a></td></tr>

<tr class="table-tr"><td>a2</td><td>b2</td>
<td><input name="title2" data-itemidx="2" class="easyui-validatebox mousetrap input-text"></td>
<td><a href="#" class="easyui-linkbutton" onclick="hotkeyDown('title2')">d</a>
<a href="#" class="easyui-linkbutton" onclick="hotkeyUp('title2')">u</a></td></tr>

<tr class="table-tr"><td>a3</td><td>b3</td>
<td><input name="title3" data-itemidx="3" class="mousetrap input-text"></td>
<td><a href="#" class="easyui-linkbutton" onclick="hotkeyDown('title3')">d</a>
<a href="#" class="easyui-linkbutton" onclick="hotkeyUp('title3')">u</a></td></tr>

<tr class="table-tr"><td>a4</td><td>b4</td>
<td><input name="title4" data-itemidx="4" class="mousetrap input-text"></td>
<td><a href="#" class="easyui-linkbutton" onclick="hotkeyDown('title4')">d</a>
<a href="#" class="easyui-linkbutton" onclick="hotkeyUp('title4')">u</a></td></tr>

<tr class="table-tr"><td>a5</td><td>b5</td>
<td><input name="title5" data-itemidx="5" class="mousetrap input-text"></td>
<td><a href="#" class="easyui-linkbutton" onclick="hotkeyDown('title5')">d</a>
<a href="#" class="easyui-linkbutton" onclick="hotkeyUp('title5')">u</a></td></tr>
</table>
</div>
<div>
<a href="#" class="easyui-linkbutton" onclick="updateHkOrder()">更新顺序</a>
<input name="table-order" value="12345" display="hidden"></input>
</div>
<div>
<ul id="list1">
<li><div>1</div></li>
<li><div>2</div></li>
<li><div>3</div></li>
</ul>	
</div>
<script type="text/javascript">
function updateHkOrder(){
	var table = $('#tbl');
	var children = table.children();
	var s = "";
	$("#tbl tr").each(function (){
		s+=$(this).find("input").data("itemidx");//.find("input").attr("name");
	});
	//console.info(s);
	var data = $("#tbl tr").map(function() {
		return $(this).find("input").data("itemidx");
	}).get();
	$("input[name=table-order]").val(s);
	
}
function hotkeyDown(s){
	var td = $("#tbl tr td input[name='"+s+"']").parent();	
	var tr = td.parent();
	var children = tr.children();
	var nexttr = tr.next();	
	if(nexttr.is('tr')){
		tr.html(nexttr.children());
		nexttr.html(children);
	}	
}
function hotkeyUp(s){
	var td = $("#tbl tr td input[name='"+s+"']").parent();	
	var tr = td.parent();
	var children = tr.children();
	var prevtr = tr.prev();	
	if(prevtr.is('tr')){
		tr.html(prevtr.children());
		prevtr.html(children);
	}	
}
     $("#list1").dragsort({ dragSelector: "div", dragBetween: false, placeHolderTemplate: "<li   class='placeHolder'><div></div></li>" });
     
     //$("#tbl").dragsort({ dragSelector: "tr", dragBetween: false, dragEnd : updateOrder,placeHolderTemplate: "<tr><td></td></tr>" });
function updateOrder() {
	var data = $("#tbl tr").map(function() {
		return $(this).data("itemidx");
	}).get();
	//alert(data);
	//$("input[name=table-order]").val(data);
};
</script>
</body>
</html>
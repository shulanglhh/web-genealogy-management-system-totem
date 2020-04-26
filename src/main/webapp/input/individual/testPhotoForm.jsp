<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript"
	src="../../jslib/jquery.dragsort-0.5.1.min.js"></script>
<script type="text/javascript" src="../../jslib/mousetrap.min.js"></script>
<script type="text/javascript" src="../../jslib/keyboard.js"></script>
<style>
#data-input-table tr {
	height: 18px;
	font-family: 微软雅黑;
	font-size: 1em;
	border: 1px;
}

#data-input-table input {
	height: 16px;
	font-size: 12px;
}
</style>

<div class="easyui-tabs" data-options="tabWidth:100"
	style="width:560px; height:580px;">
	<div title="快捷键录入" style="width:520px;padding:10px">

		<form id="hotkey-photo-form" method="post"
			style="width:500px;">
			<div class="easyui-panel" style="width:480px;padding:10px;">
				<table id="data-input-table" style="width:450px">
					<tr data-itemidx="1">
						<td style="width:80px">Alt+Shift+A</td>
						<td style="width:60px">data.phname:</td>
						<td style="width:300px"><input name="phname" ></input>
						</td>
					</tr>
					<%--<tr data-itemidx="2">
						<td>Alt+Shift+B</td>
						<td>data.phname:</td>
						<td><input name="data.phname" ></input></td>
					</tr>
					--%><tr data-itemidx="3">
						<td>Alt+Shift+E</td>
						<td>data.phurl :</td>
						<td><input name="phurl" ></input></td>
					</tr>
				</table>
			</div>
			<br />
			<div>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a> <a href="#"
					class="easyui-linkbutton">重置</a> <a href="#"
					class="easyui-linkbutton">造字</a> <a href="#"
					class="easyui-linkbutton">添加子女</a> <a href="#"
					class="easyui-linkbutton">添加兄妹</a> <a href="#"
					class="easyui-linkbutton">添加配偶</a>
			</div>
			<input name="table-order" type="hidden" />
		</form>

	</div>
	<div title="常规录入" style="padding:10px">
		<p>常规录入</p>
	</div>
	<div title="对照录入" style="padding:10px">
		<p>对照录入</p>
	</div>
	<div title="苏式对照" style="padding:10px">
		<p>苏式对照</p>
	</div>
	<div title="入谱登记表录入" style="padding:10px">
		<p>入谱登记表录入</p>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('#hotkey-photo-form').form({//form中需要包括隐藏的关联人物信息{关联人物的id，父母id|关联人物的配偶id}
			url : '${pageContext.request.contextPath}/tPhotoAction!save.action',//保存
			onSubmit : function() {				
				$(this).serialize();
				console.info('onSubmit...');//提交时做验证，并在这里做进度条。验证：1.输入验证;2.验证添加配偶->添加配偶、添加配偶->添加兄妹(需要判断按钮的类型:添加配偶还是添加兄妹，还是添加子女)
			},
			success : function(r) {
				var rObj = jQuery.parseJSON(r);
				if (rObj.success) {//插入成功
					console.info('提交成功');//设置当前关联人物的信息，写回人物树
				}
				//关闭进度条代码
				$.messager.show({
					title : '提示',
					msg : rObj.msg
				//提示是否成功的信息
				});
			}
		});
	});
	
	function submitForm(){
		$('#hotkey-photo-form').submit();
	}

	$("#data-input-table").dragsort({
		dragSelector : "tr",
		dragBetween : false,
		dragEnd : updateOrder,
		placeHolderTemplate : "<tr></tr>"
	});
	function focusInput(el) {
		window.setTimeout(function() {
			$(el).focus();
		}, 0);
	};
	//var nameinpedigree="alt+shift+b";
	//var surname="alt+shift+a";
	Mousetrap.bind("alt+shift+b", function() {
		alert('b');
		focusInput('#data-input-table input[name=nameinpedigree]');
	});
	Mousetrap.bind("alt+shift+a", function() {
		alert('a');
		focusInput('#data-input-table input[name=surname]');
	});

	function updateOrder() {
		var data = $("#data-input-table tr").map(function() {
			return $(this).data("itemidx");
		}).get();
		$("input[name=table-order]").val(data);
	};
</script>
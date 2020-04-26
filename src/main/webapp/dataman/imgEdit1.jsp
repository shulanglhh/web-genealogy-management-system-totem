<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% String path = request.getContextPath(); %>
<script type="text/javascript"
	src="<%=path %>/jslib/jcrop/js/jquery.Jcrop.min.js"></script>	
<link rel="stylesheet" type="text/css"
	href="<%=path %>/jslib/jcrop/css/jquery.Jcrop.min.css" />
<input id='treeid'></input>
<div id="img-container" style="width:100%;height:90%;">
	<div  style="float: left; width: 50%;">
		<p style="font-size: 1em; font-weight: bold; padding-left: 0.1em;">
			图片编辑</p>
		<div id="img-div" style="width:400px;height:400px;margin:5px; border:1px solid gray; padding-right:1em;">			
			<img id="img-edit"   src="<%=path %>/images/qq.jpg">			
		</div>
	</div>

	<div style="float: right; width: 50%;">
		<p style="font-size: 1em; font-weight: bold; padding-left: 0.1em;">预览</p>	
		<div id="img-preview" style="margin:5px;width: 100px; height: 100px; overflow: hidden; border:1px solid gray;">
			<img id="img-small" style="width:400px;height:400px;" src="<%=path %>/images/qq.jpg" >
		</div>
		<div style="float:left; margin:5px;">
			<form id="coordinate-form">
				<label>X1 <input type="text" size="4" id="x1" name="x1"></label>
				<label>Y1 <input type="text" size="4" id="y1" name="y1"></label>
				<br/>
				<label>X2 <input type="text" size="4" id="x2" name="x2"></label>
				<label>Y2 <input type="text" size="4" id="y2" name="y2"></label>
				<br />
				<label>W&nbsp; <input type="text" size="4" id="w" name="w"></label>
				<label>H&nbsp; <input type="text" size="4" id="h" name="h"></label>
				<br />
				<a href="#" class="easyui-linkbutton" onclick="saveCutPhoto()">保存剪切</a> 
			</form>
		</div>	
		<div id="file-list"></div>
		<form  method="post" id='individual-photo-form' enctype="multipart/form-data">
			<div id="upload-area" style="clear:both;">
			<table>
				<tr><td><input id='photoFile' type="file" name="myFile" class="easyui-validatebox" data-options="required:true" /></td></tr>
				<tr><td><input type="hidden" name="uid" id="personid" /></td></tr>
			</table>  		
			</div>	
		</form>	
	</div>
	
</div>

<script>
$(function(){
	  $('#navbar').accordion('select', '数据管理');
});
var jcrop_api;
jQuery(function($){
	$("#img-edit").Jcrop({
		boxWidth:400,
		boxHeight:0,
		onChange:updatePreview,
		onSelect:updatePreview,
		aspectRatio:1
	}, function(){		
		jcrop_api = this;
	});
	
	function updatePreview(c){
		if(parseInt(c.w)>0){
		    var scaleX = 100 / c.w;//预览大小固定100*100
		    var scaleY = 100 / c.h;
		    var image=new Image();
		    image.src=$('#img-small').attr('src');
		    var boundx = image.width,boundy = image.height;	
		    //var boundx = $("#img-edit").width();
			//var boundy = $("#img-edit").height();
					
		    $('#img-preview img').css({
		        width: Math.round(scaleX * boundx),//$("#img-edit").width()
		        height: Math.round(scaleY * boundy),
		        marginLeft: -Math.round(scaleX * c.x),
		        marginTop: -Math.round(scaleY * c.y)
		    }); 
		    $('#x1').val(parseInt(c.x));
		    $('#y1').val(parseInt(c.y));
		    $('#x2').val(parseInt(c.x2));
		    $('#y2').val(parseInt(c.y2));
		    $('#w').val(parseInt(c.w));
		    $('#h').val(parseInt(c.h)); 
		};
	};
	//jcrop_api.disable();
	$('#individual-photo-form').form({
		url : '${pageContext.request.contextPath}/fUploadAction!uploadFile1.action',
		onSubmit : function(){
			if($('#photoFile').val()==''){
				return false;
			}
			var uid = $('#treeid').attr('value');
			//console.info('uid:'+uid);
			$('#personid').attr('value', uid);
		},		
		//error : alert('上传过程出错！'),
		success : function(r){
			var rObj = jQuery.parseJSON(r);			
			if (rObj.success) {		
				if($('#treeid').attr('value') == $('#personid').attr('value')){				
					var url = '${pageContext.request.contextPath}/photo/'+rObj.obj;				
					$('#person-photo').attr('src',url);				
					$('#img-small').attr('src', url);
					jcrop_api.setImage(url);//jcrop_api定义在imgEdit1.jsp中
					jcrop_api.release();
				}
			}
			else
				alert('上传失败');
		}
	});
	
});

function saveCutPhoto(){
	var pid = $('#treeid').attr('value');
	if(pid == null || typeof pid == 'undefined' ||pid == ''){
		$.messager.alert('提示','请选中一个人物再操作');
		return false;
	}
	$.ajax({
		async:false,
		url:'${pageContext.request.contextPath}/tPhotoAction!saveCutPhoto.action',
		type:'POST',
		//dataType:'text/json',
		data:{
			'x':$('#x1').attr('value'),
			'y':$('#y1').attr('value'),
			'w':$('#w').attr('value'),
			'h':$('#h').attr('value'),
			'pid':pid
		},
		success:function(r){
			var rObj = jQuery.parseJSON(r);			
			if (rObj.success) {		
				if($('#treeid').attr('value') == pid){	
					var url = '${pageContext.request.contextPath}/photo/'+rObj.obj;				
					$('#person-photo').attr('src',url);				
					$('#img-small').attr('src', url);
					jcrop_api.setImage(url);//jcrop_api定义在imgEdit1.jsp中
					jcrop_api.release();
				}
			}
			else
				alert('裁剪保存失败');
		},
	});
}
 
</script>

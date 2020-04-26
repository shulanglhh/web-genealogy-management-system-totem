<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="../../jslib/jquery.imgareaselect-0.9.10/scripts/jquery.imgareaselect.pack.js"></script>
<link rel="stylesheet" type="text/css"
	href="../../jslib/jquery.imgareaselect-0.9.10/css/imgareaselect-default.css" />

<div id="img-container" style="width:100%;height:90%;">
	<div  style="float: left; width: 50%;">
		<div class="frame" id="img-div"
			style="width: 300px; height: 300px;">
			<img id="img-edit" style="width:100%;height:100%;" src="../../images/cover.jpg">
		</div>
	</div>

	<div style="float: left; width: 50%;">
		<p style="font-size: 110%; font-weight: bold; padding-left: 0.1em;">
			Selection Preview</p>

		<div class="frame" style="margin: 0 1em; width: 100px; height: 100px;">
			<div id="img-preview"
				style="width: 100px; height: 100px; overflow: hidden;">
				<img src="../../images/cover.jpg">
			</div>
		</div>

		<table style="margin-top: 1em;">
			<thead>
				<tr>
					<th colspan="2"
						style="font-size: 110%; font-weight: bold; text-align: left; padding-left: 0.1em;">
						Coordinates</th>
					<th colspan="2"
						style="font-size: 110%; font-weight: bold; text-align: left; padding-left: 0.1em;">
						Dimensions</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 10%;"><b>X<sub>1</sub>:</b>
					</td>
					<td style="width: 30%;"><input type="text" style="width:4em;" id="x1" value="-">
					</td>
					<td style="width: 20%;"><b>Width:</b>
					</td>
					<td><input type="text" style="width:4em;"  value="-" id="w">
					</td>
				</tr>
				<tr>
					<td><b>Y<sub>1</sub>:</b>
					</td>
					<td><input type="text" style="width:4em;" id="y1" value="-">
					</td>
					<td><b>Height:</b>
					</td>
					<td><input type="text" style="width:4em;" id="h" value="-">
					</td>
				</tr>
				<tr>
					<td><b>X<sub>2</sub>:</b>
					</td>
					<td><input type="text" style="width:4em;" id="x2" value="-">
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><b>Y<sub>2</sub>:</b>
					</td>
					<td><input type="text" style="width:4em;" id="y2" value="-">
					</td>
					<td></td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div id="upload_area">
	<form name="uploadImgForm" enctype='multipart/form-data' method='POST'>
		<input type="file" id="picpath" name="atvatar_image" /> <a
			href="javascript:void(0);" class="button"> 上传照片</a> <input
			type='text' name="path" readonly />
	</form>
	<div id="submit_button">
		<a href="javascript:void(0);" class='button'>确认</a>
	</div>
</div>

<script>
function imgPreview(img, selection) {
    if (!selection.width || !selection.height)
        return;
    
    var scaleX = 100 / selection.width;
    var scaleY = 100 / selection.height;

    $('#img-preview img').css({
        width: Math.round(scaleX * 300),
        height: Math.round(scaleY * 300),
        marginLeft: -Math.round(scaleX * selection.x1),
        marginTop: -Math.round(scaleY * selection.y1)
    });  
    
    $('#x1').val(selection.x1);
    $('#y1').val(selection.y1);
    $('#x2').val(selection.x2);
    $('#y2').val(selection.y2);
    $('#w').val(selection.width);
    $('#h').val(selection.height); 
}

$(function () {
    $('img#img-edit').imgAreaSelect({ aspectRatio: '1:1',parent:'#img-edit-window', handles: true,
        fadeSpeed: 200, onSelectChange: imgPreview });
});
</script>
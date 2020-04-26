<script type="text/javascript" src="../../jslib/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
<script type="text/javascript" 
	src="../../jslib/plupload.full.min.js"></script>
 
<script type="text/javascript">
// Custom example logic
$(function() {
    var uploader = new plupload.Uploader({
        runtimes : 'flash',
        browse_button : 'pickfiles',
        container : 'plcontainer',
        max_file_size : '10mb',
        url : '${pageContext.request.contextPath}/tRelationAction!getPersonTree.action',
        flash_swf_url : '../../jslib/Moxie.swf',
       
//        filters : [
//            {title : "Image files", extensions : "jpg,gif,png"},
//            {title : "Zip files", extensions : "zip"}
//        ],
//        resize : {width : 320, height : 240, quality : 90}
    });
 
    uploader.bind('Init', function(up, params) {
        $('#filelist').html("<div>Current runtime: " + params.runtime + "</div>");
    });
 
    $('#uploadfiles').click(function(e) {
        uploader.start();
        e.preventDefault();
    });
 
    uploader.init();
 
    uploader.bind('FilesAdded', function(up, files) {
        $.each(files, function(i, file) {
            $('#filelist').append(
                '<div id="' + file.id + '">' +
                file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
            '</div>');
        });
 
        up.refresh(); // Reposition Flash/Silverlight
    });
 
    uploader.bind('UploadProgress', function(up, file) {
        $('#' + file.id + " b").html(file.percent + "%");
    });
 
    uploader.bind('Error', function(up, err) {
        $('#filelist').append("<div>Error: " + err.code +
            ", Message: " + err.message +
            (err.file ? ", File: " + err.file.name : "") +
            "</div>"
        );
 
        up.refresh(); // Reposition Flash/Silverlight
    });
 
    uploader.bind('FileUploaded', function(up, file) {
        $('#' + file.id + " b").html("100%");
    });
});
</script>
<h3>Custom example</h3>
<div id="plcontainer">
    <div id="filelist">No runtime found.</div>
    <br />
    <a id="pickfiles" href="#">[Select files]</a>
    <a id="uploadfiles" href="#">[Upload files]</a>
</div>

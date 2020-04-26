<%@ page language="java" import="java.util.*, com.zhuozhengsoft.pageoffice.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>文档管理</title>
<style type="text/css">
.datagrid-group-title {
    font-size:12px;
    font-weight:bold;
    margin:0;
    margin-bottom:15px;
}
</style>

<jsp:include page="inc.jsp"></jsp:include>
  <%
	ResourceBundle resourceBundle = ResourceBundle.getBundle("doc");
	String ServerIP = resourceBundle.getString("ServerIP");
	String FTPDocHome = resourceBundle.getString("FTPDocHome");
	String FTPPort = resourceBundle.getString("FTPPort");
	String FTPUserName = resourceBundle.getString("FTPUserName");
	String FTPPassword = resourceBundle.getString("FTPPassword"); 
	String HttpAddr = resourceBundle.getString("HttpAddr"); 
	
	PageOfficeCtrl poCtrl1 = new PageOfficeCtrl(request);
	poCtrl1.setServerPage("poserver.zz"); //此行必须
	//设置PageOfficeCtrl控件的标题栏名称
	poCtrl1.setCaption("文档编辑");
	//隐藏菜单栏
	//poCtrl1.setMenubar(false);
	//添加自定义按钮
	//poCtrl1.addCustomToolButton("保存","save()",1);
	//poCtrl1.addCustomToolButton("打开","open()",0);
	poCtrl1.setSaveFilePage(path + "/saveFile.jsp");
	//打开文件
	//poCtrl1.webOpen("http://localhost:8083/doc/test.doc", OpenModeType.docNormalEdit, "张三");
	poCtrl1.setTagId("PageOfficeCtrl"); //此行必须	
  %>
  <script type="text/javascript" src="<%=path %>/jslib/docOperation.js"></script>
  <script type="text/javascript" src="<%=path %>/jslib/datagrid-groupview.js"></script>
  <script type="text/javascript" src="<%=path %>/jslib/jquery-easyui-1.3.2/datagrid-detailview.js"></script>
  
  <script type="text/javascript">
  var isuseflag=0;
/*   		 $(function(){
		     var dg = $('#lib_datagrid').datagrid();
		     dg.datagrid('enableFilter', [{
		         field:'dcname',
		         type:'combobox',
		         options:{
		             panelHeight:'auto',
		             data:[{value:'',text:'全部'},{value:'谱名',text:'谱名'},{value:'目录',text:'目录'},
		             {value:'谱序',text:'谱序'},{value:'凡例',text:'凡例'},
		             {value:'国家谱牒文件选录',text:'国家谱牒文件选录'},{value:'谱论',text:'谱论'},
		             {value:'源流',text:'源流'},{value:'先祖像赞',text:'先祖像赞'},
		             {value:'恩荣录',text:'恩荣录'},{value:'字辈派行',text:'字辈派行'},
		             {value:'族规家训',text:'族规家训'},{value:'祠堂',text:'祠堂'},
		             {value:'族产',text:'族产'},{value:'契约',text:'契约'},
		             {value:'坟茔',text:'坟茔'},{value:'阳基图',text:'阳基图'},
		             {value:'传记',text:'传记'},{value:'礼仪',text:'礼仪'},
		             {value:'领谱字号',text:'领谱字号'},{value:'修谱名目',text:'修谱名目'},
		             {value:'后记',text:'后记'},{value:'捐输名录',text:'捐输名录'},
		             {value:'待设计',text:'待设计'},{value:'图腾',text:'图腾'},
		             {value:'族旗旗徽',text:'族旗旗徽'},{value:'题词',text:'题词'},
		             {value:'村房概述',text:'村房概述'},{value:'仕官录、名贤录',text:'仕官录、名贤录'},
		             {value:'郡望堂号',text:'郡望堂号'},{value:'郡望堂号',text:'郡望堂号'},
		             {value:'大事记',text:'大事记'},{value:'迁徙分布',text:'迁徙分布'},
		             {value:'资料存录',text:'资料存录'},{value:'余庆录',text:'余庆录'},
		             {value:'文物古迹照',text:'文物古迹照'},{value:'村貌照',text:'村貌照'},
		             {value:'捐款人照',text:'捐款人照'},{value:'人才照',text:'人才照'},
		             {value:'寿星照',text:'寿星照'},{value:'理事会、顾委会、编委会照',text:'理事会、顾委会、编委会照'},
		             {value:'入谱人口统计表',text:'入谱人口统计表'},{value:'修谱要文',text:'修谱要文'},
		             {value:'无',text:'无'},{value:'附录',text:'附录'},{value:'村房地理位置图',text:'村房地理位置图'}],
		             onChange:function(value){
		                 if (value == ''){
		               	  dg.datagrid('removeFilterRule', 'dcname');
		                 } else {
		               	  dg.datagrid('addFilterRule', {
		                         field: 'dcname',
		                         op: 'equal',
		                         value: value
		                     });
		                 }
		                 dg.datagrid('doFilter');
		             }
		         }
		     }]);
	    }); */
  
  		var LocalTempFolder = "";
  		//暂存模板url
  		var dturlValue = "";
  		//暂存当前编辑的文档的url
  		var current_doc_title = "";
  		//当前选择的文档的标题
  		var current_doc_url = "";
  		//按文件描述来删除文档？不是按照文件ID或者文件url？
  		var delete_doc_descri = "";
  		//要删除文档的url
  		var delete_doc_url = "";
  		//临时文件url
  		var temp_doc_url = "";
  		//存放文档模板初始数据
  		var originalTemplateData;
  		//datagrid是否是第一次载入，第一次载入是会记录初始数据，便于检索
  		var isFirstLoad = true;
	
  		
  		//新建文件文件名输入框的验证方法
  		$.extend($.fn.validatebox.defaults.rules, {
  			englishCheck:{
  				validator:function(value){
  					return /^[a-zA-z0-9]+$/.test(value); 
  				},
  				message:"不能包含中文。"
  			}
  		});
  		
  		$(function(){
  			$('#navbar').accordion('select', '数据管理');
  			$('#usersdoc_datagrid').datagrid({loadFilter:pagerFilter});
  			//$('#globaltemplate_datagrid').datagrid({loadFilter:pagerFilter});
  			//$('#pagetemplate_datagrid').datagrid({loadFilter:pagerFilter});
  			document.getElementById("PageOfficeCtrl").JsFunction_AfterDocumentOpened = "checktheversion()"; 
  		});
  		function checktheversion(){
  	  		var obj = document.getElementById("PageOfficeCtrl").Document; 
  	    	var ss =obj.Application.Version ;
  			if(ss<=11.0){
  				$.messager.show({
  					title : '提示',
  					msg : "您的word版本太低，请升级！",
  					timeout:10000
  				});
  				document.getElementById("PageOfficeCtrl").Close();
  			}
  	  	}
  		function initCombobox() {
	    	var val = $('#combo_pedi').combobox('getData')[0];
	    	$('#combo_pedi').combobox('setText',val.text);
	    	$('#combo_pedi').combobox('setValue',val.pid);
	    	
	    	var val = $('#combo_contenttype_doc').combobox('getData')[0];
	    	$('#combo_contenttype_doc').combobox('setText',val.dcname);
	    	$('#combo_contenttype_doc').combobox('setValue',val.dcid);
	    	
	    	var val = $('#combo_pedi_pdf').combobox('getData')[0];
	    	$('#combo_pedi_pdf').combobox('setText',val.text);
	    	$('#combo_pedi_pdf').combobox('setValue',val.pid);
	    	
	    	var val = $('#combo_contenttype_pdf').combobox('getData')[0];
	    	$('#combo_contenttype_pdf').combobox('setText',val.dcname);
	    	$('#combo_contenttype_pdf').combobox('setValue',val.dcid);
	    }
  		
  		//BEGIN:pageoffice function
  		//function open(fileName) {
  			//document.getElementById("PageOfficeCtrl").WebOpen("http://localhost:8083/pedigree/getFile.jsp?docName='test.doc'", "docNormalEdit", "张三"); 
  		//}
  		
  		function save() {
  			document.getElementById("PageOfficeCtrl").WebSave();
  		}
  		//END
  		
  		function setLocalTempFolder() {
  			//LocalTempFolder = document.getElementById('fileUploader').getPedigreeTempFolderPath();
  		}

  		function onDblClickRowUD(rowIndex, rowData) {
  			var selectedRow = $("#usersdoc_datagrid").datagrid('getRows');
  			dturlValue = selectedRow[rowIndex].docurl;
  			current_doc_title = selectedRow[rowIndex].docname;
  			//表示文档编辑器中正在编辑的文档的url，打开操作会影响这个值
		    current_doc_url = selectedRow[rowIndex].docurl;
		    $(this).datagrid('selectRecord', dturlValue);  //通过获取到的id的值做参数选中一行
		    OpenDocOnServer(dturlValue,false);
  		}
  
  		function onRowContextMenuUD(e, rowIndex, rowData){
		    e.preventDefault();
		    var selected=$("#usersdoc_datagrid").datagrid('getRows'); //获取所有行集合对象
		     dturlValue = selected[rowIndex].docurl;
		     current_doc_title = selected[rowIndex].docname;
		     //表示文档编辑器中正在编辑的文档的url，打开操作会影响这个值
		     current_doc_url = selected[rowIndex].docurl;
		     delete_doc_descri = selected[rowIndex].docname;
		     //在右键点击时同样记录一个url，这个url仅仅用在删除操作中
		     delete_doc_url = selected[rowIndex].docurl;
		     $(this).datagrid('selectRecord', dturlValue);  //通过获取到的id的值做参数选中一行
		    $('#ud_menu').menu('show', {
		        left:e.pageX,
		        top:e.pageY
		    });       
		}
  		
/* 	    function onRowContextMenuGT(e, rowIndex, rowData){
		    e.preventDefault();
		    var selected=$("#globaltemplate_datagrid").datagrid('getRows'); //获取所有行集合对象
		     dturlValue = selected[rowIndex].dturl;
		     $(this).datagrid('selectRecord', dturlValue);  //通过获取到的id的值做参数选中一行
		    $('#gt_menu').menu('show', {
		        left:e.pageX,
		        top:e.pageY
		    });       
		}
	    
	    function onRowContextMenuPT(e, rowIndex, rowData){
		    e.preventDefault();
		    var selected=$("#pagetemplate_datagrid").datagrid('getRows'); //获取所有行集合对象
		     dturlValue = selected[rowIndex].dturl;
		     $(this).datagrid('selectRecord', dturlValue);  //通过获取到的id的值做参数选中一行
		    $('#pt_menu').menu('show', {
		        left:e.pageX,
		        top:e.pageY
		    });       
		} */
		
		function onRowContextMenuLib(e, rowIndex, rowData){
		     e.preventDefault();
		     var selected=$(this).datagrid('getRows'); //获取所有行集合对象
		     dturlValue = selected[rowIndex].dturl;
		     current_doc_title = selected[rowIndex].docname;
		     $(this).datagrid('selectRecord', dturlValue);  //通过获取到的id的值做参数选中一行
		     if(selected[rowIndex].dttype == 'pt'){
		     	$('#pt_menu').menu('show', {
			        left:e.pageX,
			        top:e.pageY
			    }); 
		     } else if(selected[rowIndex].dttype == 'gt'){//gt全文模板,model是范文，pt是单页模板，intro说明
		     	$('#gt_menu').menu('show', {
			        left:e.pageX,
			        top:e.pageY
			    }); 
		     } else {
		     	$('#intro_menu').menu('show', {
			        left:e.pageX,
			        top:e.pageY
			    });
		     }
		}
	
	    function uploadToServer() {
	    	var uploader = document.getElementById('fileUploader');
	    	$('#dialog_info').dialog('open');
	    	var flag = uploader.FtpUpload(LocalTempFolder + current_doc_url, current_doc_url, '<%=ServerIP%>', '/document/', '<%=FTPUserName%>', '<%=FTPPassword%>','<%=FTPPort%>');
			if(flag == '0') {
				alert("文档上传成功。");
				$('#dialog_info').dialog('close');
			} else if(flag == '-2') {
				alert("文档上传失败，请检查网络连接或FTP相关设置。");
				$('#dialog_info').dialog('close');
			}
			return flag;
	    }
	    
	    function createNewDoc() {
	    	if(document.getElementById('id_descri').value == ''){
	    		alert("请填写文件描述。");
	    	} else {
	    		$.ajax({
					async : false,
					cache : false,
					type : 'post',
					dataType:'text',
					data : 'docname='+document.getElementById('id_descri').value+'&docpedi='+$('#combo_pedi').combobox('getValue'),
					url : '${pageContext.request.contextPath}/docAction!docnameCheck.action',//请求的action路径  
					error : function() {//请求失败处理函数  
					},
					success : function(result) { //请求成功后处理函数。  
						if(result == 'notexist') {
	    					//为了保证文件名的唯一性，使用当前的时间（毫秒数）作为文件名，从而也避免用户自己命名
	    					var myDate = new Date();
	    					var fileCurrentTime = myDate.getTime(); 
							$.ajax({
					       		type:"POST",
					       		url:"docAction!createNewDoc.action",
					       		dataType:'text',
					       		data:{doc_descri:document.getElementById('id_descri').value, doc_filename:fileCurrentTime, doc_pedi:$('#combo_pedi').combobox('getValue'), doc_contenttype:$('#combo_contenttype_doc').combobox('getValue')},
					       		success:function(result) {
					       					if(result != null){
							    	    		$('#dlg').dialog('close');
							    	    		current_doc_title=document.getElementById('id_descri').value;
								    	    	OpenDocOnServer("user/" + result + ".docx", false);
								    	    	reloadTable();
								    	    		checkDocument();
					       					} else {
					       						alert("无法创建文档记录，可能是数据库连接问题，请检查。");
					       					}
					       		},
					       		error:function(){
					       			alert("无法成功发送请求，请检查网络连接是否有效。");
					       		}
					       	});	
	    				} else if(result == 'exist') {
	    					alert("当前谱志中该描述的文档已经存在，无法新建！");
	    				}
					}
				});
	    	}
	    }
	    
	    //删除服务器端文档
	    function deleteDoc() {
	    	$.ajax({
				async : false,
				cache : false,
				type : 'post',
				dataType:'text',
				data : 'delete_descri='+delete_doc_descri+'&delete_url='+delete_doc_url,
				url : '${pageContext.request.contextPath}/docAction!deleteDoc.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					//alert('删除文件失败，请检查网络');
				},
				success : function(result) { //请求成功后处理函数。  
					if(result=="true") {
					document.getElementById("PageOfficeCtrl").Close();
						alert(delete_doc_descri + '已经删除。');
	    		    	reloadTable();
					}
					else{
						alert(delete_doc_descri + '删除失败，请刷新页面。');
					}
				}
			});
	    }
	    
	    //重命名文档
	    function renameDoc() {
	    	var new_descri = document.getElementById('id_newdescri').value;
	    	if(new_descri == "") {
	    		alert("请填写新的文档描述。");
	    	} else {
	    		$.ajax({
					async : false,
					cache : false,
					type : 'post',
					dataType:'text',
					data : 'rename_newdescri='+new_descri+'&rename_url='+current_doc_url,
					url : '${pageContext.request.contextPath}/docAction!modifyDocDescri.action',//请求的action路径  
					error : function() {//请求失败处理函数  
						alert('重命名失败，请检查网络');
					},
					success : function(result) { //请求成功后处理函数。  
						if(result=="renamesuccessfully") {
    						alert("重命名成功。");
    						var selectedrow=$('#usersdoc_datagrid').datagrid('getSelected');
    						var index=$('#usersdoc_datagrid').datagrid('getRowIndex',selectedrow);
    						$('#usersdoc_datagrid').datagrid('updateRow',{
    							index: index,
    							row:{dcname:selectedrow.dcname,docmodifydate:selectedrow.docmodifydate,docname:new_descri,docurl:selectedrow.docurl,gid:selectedrow.gid,gname:selectedrow.gname,username:selectedrow.username}
    						});
    						document.getElementById("PageOfficeCtrl").Caption = new_descri;
    						$('#dlg2').dialog('close');
    					}
					}
				});
	    	}
	    }
	    
	    //删除本地临时文件
	    function deleteTempDoc(filepath) {
	    	DeleteLocalFile(LocalTempFolder + filepath);
	    }
	    
	    //刷新datagrid
	    function reloadTable() {
	    	//$('#usersdoc_datagrid').datagrid('reload');
	    	var gidtmp=$('#combo_pedizwj').combobox('getValue');
	    	if(combo_pedizwj!=null){
	    	$.ajax({
				async : false,
				cache : false,
				type : 'post',
				data : 'gid='+gidtmp,
				url : '<%=path%>/docAction!finddocsbygid.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					alert('选择规则出错，请检查网络！');
				},
				success : function(j) { //请求成功后处理函数。  
					var rObj = eval('(' + j + ')');
					if (rObj!=null) {
						if(rObj!="session"){
						$('#usersdoc_datagrid').datagrid('loadData', rObj);
						}
						else{
							 $.messager.confirm('提示', '您的登陆信息已经失效，是否重新登录？', function (data) {  
							        if (data) { 
							        	window.location.href="<%=path %>/index.jsp"; 
							        }  
							        else {  
							        	
							        }  
							    });  
						}
					} else {
						
					}
				}
			});
	    	}else{
				$.messager.alert("提示","请先选择族谱！","warning");
		}
	    }
	    

	    
	    function pagerFilter(data){
            if (typeof data.length == 'number' && typeof data.splice == 'function'){    // 判断数据是否是数组
                data = {
                    total: data.length,
                    rows: data
                }
            }
            var dg = $(this);
            var opts = dg.datagrid('options');
            var pager = dg.datagrid('getPager');
            pager.pagination({
                onSelectPage:function(pageNum, pageSize){
                    opts.pageNumber = pageNum;
                    opts.pageSize = pageSize;
                    pager.pagination('refresh',{
                        pageNumber:pageNum,
                        pageSize:pageSize
                    });
                    dg.datagrid('loadData',data);
                }
            });
            if (!data.originalRows){
                data.originalRows = (data.rows);
            }
            var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
            var end = start + parseInt(opts.pageSize);
            data.rows = (data.originalRows.slice(start, end));
            return data;
        }
        
/*         function loadDataByContentType(item) {
 			$('#lib_datagrid').datagrid({'loadFilter': function(data) {
	 			var currentData = $('#lib_datagrid').datagrid('getData');
				alert(currentData.total);
				for(var i=0; i<currentData.total; i++) {
					if(currentData.rows[i].dcname == item.dcname) {
						var array = new Array();
						array[0] = currentData.rows[i];
						//$('#lib_datagrid').datagrid('loadData', {"total":"1", "rows":array});
						//array = null;
						//$('#lib_datagrid').datagrid('loadData',currentData.rows[i]);
					}
				}
				
				return {"total":"1", "rows":array};
 			}});
        } */
        
  /*       function loadDataByContentType(item) {
			for(var i=0; i<originalTemplateData.total; i++) {
				if(originalTemplateData.rows[i].dcname == item.dcname) {
					var array = new Array();
					array[0] = originalTemplateData.rows[i];
					$('#lib_datagrid').datagrid('loadData', {total:"1", rows:array});
					array = null;
					//$('#lib_datagrid').datagrid('loadData',currentData.rows[i]);
				}
			}
        } */
        
	    function loadDataByContentType(item) {
	    	var array = new Array();
			for(var i=0; i<originalTemplateData.total; i++) {
				if(originalTemplateData.rows[i].dcname == item.dcname) {
					array.push(originalTemplateData.rows[i]);
				}
			}
			$('#lib_datagrid').datagrid('loadData', {total:array.length, rows:array});
			array = null;
	    }
	    
	    function previewTemplate() {
	    	window.open ('<%=path %>/previewTemplate.jsp?picUrl=' + dturlValue, "预览", "height=600, width=800, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
	    }
	    
	    //只有当PageOffice控件中打开了文档时才可以进行样式设置
	    function checkDocument() {
	    		var gidtmp=$('#combo_pedi').combobox('getValue');
	    		if(gidtmp==undefined){
	    			var row=$('#usersdoc_datagrid').datagrid('getSelected');
	    			if(row!=undefined){
	    				gidtmp=row.gid;
	    			}
	    		}
	    		$.ajax({
					async : false,
					cache : false,
					type : 'post',
					data : 'gid=' + gidtmp,
					url : '${pageContext.request.contextPath}/userAction!showthefontsizebugid.action',
					error : function() {//请求失败处理函数  
						$.messager.alert('警告','加载字体设置规则失败，请重试！','warning');
					},
					success : function(j) {
						var rObj = jQuery.parseJSON(j);
						if (rObj.success) {
							$('#selectfontsize').combobox('loadData', rObj.obj);
						}
					}
			});	
	    	var obj = document.getElementById("PageOfficeCtrl").Document; 
	    	if (true) {
	    		$('#dlg_style').dialog('open');$('#dlg_style').panel('move',{top:150,left:$(document.body).width()-280});
	    	} else {
	    		alert("当前没有打开的文档！");
	    	}
	    }
	    
	    //设置文档字体字号
	    function applyStyleSetting() {
	    	//标题1字体及字号
	    	var title1Font = $('#slct_type_title1').combobox('getValue');
	    	var title1Size = $('#slct_size_title1').combobox('getValue');
	    	
	    	var title2Font = $('#slct_type_title2').combobox('getValue');
	    	var title2Size = $('#slct_size_title2').combobox('getValue');
	    	
	    	var title3Font = $('#slct_type_title3').combobox('getValue');
	    	var title3Size = $('#slct_size_title3').combobox('getValue');
	    	
	    	var title4Font = $('#slct_type_title4').combobox('getValue');
	    	var title4Size = $('#slct_size_title4').combobox('getValue');
	    	
	    	var title5Font = $('#slct_type_title5').combobox('getValue');
	    	var title5Size = $('#slct_size_title5').combobox('getValue');
	    	
	    	var contentFont = $('#slct_type_content').combobox('getValue');
	    	var contentSize = $('#slct_size_content').combobox('getValue');
	    
	    	//获取JS文档对象
	    	var obj = document.getElementById("PageOfficeCtrl").Document; 

	    	obj.Styles("标题 1").Font.Name = title1Font;
	    	obj.Styles("标题 1").Font.Size = title1Size;
	    	
	    	obj.Styles("标题 2").Font.Name = title2Font;
	    	obj.Styles("标题 2").Font.Size = title2Size;
	    	
	    	obj.Styles("标题 3").Font.Name = title3Font;
	    	obj.Styles("标题 3").Font.Size = title3Size;
	    	
	    	obj.Styles("标题 4").Font.Name = title4Font;
	    	obj.Styles("标题 4").Font.Size = title4Size;
	    	
	    	obj.Styles("标题 5").Font.Name = title5Font;
	    	obj.Styles("标题 5").Font.Size = title5Size;
	    	
	    	obj.Styles("正文").Font.Name = contentFont;
	    	obj.Styles("正文").Font.Size = contentSize;
	    	$('#dlg_style').dialog('close');
	    	isuseflag=1;
	    }
	    
	    function uploadPdf() {
			if(document.getElementById('id_descri_pdf').value == "" || document.getElementById('input_file').value == "" || document.getElementById('input_file').value == "ERROR") {
	  			alert("请填写文件描述或选择要上传的PDF文件。");
	  		} else {
	  	  		var isExist = false;
	  	    	$.post("docAction!docnameCheck.action", {docname:document.getElementById('id_descri_pdf').value, docpedi:$('#combo_pedi_pdf').combobox('getValue')},
	  	    			function(result) {
	  	    				if(result == 'notexist') {
	  	    					
	  	    					var myDate = new Date();
			    				var fileCurrentTime = myDate.getTime(); 
			    				var modifiedFileName = fileCurrentTime + document.getElementById('input_file').value.substring(document.getElementById('input_file').value.lastIndexOf("."));
	  	    				
	  	    				    $.ajax({
	  	    			    		type:"POST",
	  	    			    		url:"docAction!createNewPdf.action",
	  	    			    		data:{pdf_descri:document.getElementById('id_descri_pdf').value, pdf_filename:fileCurrentTime, pdf_pedi:$('#combo_pedi_pdf').combobox('getValue'), pdf_contenttype:$('#combo_contenttype_pdf').combobox('getValue')},
	  	    			    		success:function(result) {
	  	    			    					if(result == 'insertsuccessfully'){
	  	  	    		   			    	    	//current_doc_url = modifiedFileName;
	  	  	    		   			    	    	$('#dlg_pdf').dialog('close');
	  	  	    		   			    	    	//$('#new_template_window').window('close');
	  	  	    		   			    	    	var isUploaded = uploadPdfToServer(modifiedFileName);
										    	    if(isUploaded == '0') {
										    	    	//上传成功do nothing
										    	    } else if(isUploaded == '-2') {
										    	    	$.post("docAction!deleteDocRecordOnly.action", {delete_descri:document.getElementById('id_descri_pdf').value, pdf_pedi:$('#combo_pedi_pdf').combobox('getValue'), pdf_contenttype:$('#combo_contenttype_pdf').combobox('getValue')});
										    	    }
										    	    reloadTable();
	  	    			    					}
	  	    			    					else{
	  	    			    						alert("无法创建文档记录，可能是数据库连接问题，请检查。");
	  	    			    					}
	  	    			    		},
	  	    			    		error:function(){
	  	    			    			alert("无法成功发送请求，请检查网络连接是否有效。");
	  	    			    		}
	  	    			    	});
	  	    				} else if(result == 'exist') {
	  	    					alert("该名称的文档已经存在，无法新建！");
	  	    				}
	  	    			});
	  		}
	  	}
	  	
	  	function getUploadFilePath() {
	  		var uploadFile = document.getElementById('fileUploader').getUploadPath();
	  		document.getElementById('input_file').value = uploadFile;
	    }
  	
	    function uploadPdfToServer(modifiedFileName) {
	    	var uploader = document.getElementById('fileUploader');
	    	var path = document.getElementById("input_file").value;
	    	$('#dialog_info').dialog('open');
	    	var flag = uploader.FtpUpload(path.replace(/\\/g,"/"), modifiedFileName, '<%=ServerIP%>', '/user/', '<%=FTPUserName%>', '<%=FTPPassword%>', '<%=FTPPort%>');
	    	if(flag == '0') {
				alert("文档上传成功。");
				$('#dialog_info').dialog('close');
			} else if(flag == '-2') {
				alert("文档上传失败，请检查网络连接或FTP相关设置。");
				$('#dialog_info').dialog('close');
			}
			return flag;
	    }

  </script>
  

</head>
  <body class="easyui-layout" onload="setLocalTempFolder()" data-options="fit:true">
	<div data-options="region:'north'" style="height:50px;overflow:hidden;">
		<div align=right>
		<span>
			<jsp:include page="./header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'功能导航',split:true"
		style="width:200px">
		<jsp:include page="newnav.jsp"></jsp:include>

	</div>
	<div data-options="region:'center'" id="centerLayout">
	<div class="easyui-layout" data-options="fit:true">
	<div id="doc_editor" data-options="region:'center',split:false" title="文档编辑工作区"> 
    	<!-- dsoframer version
    	<object classid="clsid:00460182-9E5E-11d5-B7C8-B8269041DD57" id="oframe" width="100%" height="99%">
			<param name="BorderStyle" value="0">
			<param name="Titlebar" value="0">
    	</object> 
    	
    	<object id="fileUploader" classid="clsid:A8F4FF40-E558-4209-9324-D2F92A357756" style="display: none;"></object>
    	 -->
    	 
    	<object id="fileUploader" classid="clsid:A8F4FF40-E558-4209-9324-D2F92A357756" codebase="PedigreePlugins.CAB#version=1,0,0" style="display: none;"></object>
		
		<po:PageOfficeCtrl id="PageOfficeCtrl" />
		
    </div>
    
    <div data-options="region:'east'" title="文档列表" style="width:300px;">
    	<div class="easyui-tabs">
    	<div title="我的文档" fit="true">
    	 	<div style="margin-top:5px">
    	<label for="combo_pedizwj">选择族谱：&nbsp;&nbsp;</label> 
    	<input id="combo_pedizwj" class="easyui-combobox" name="doc_pedizwj" data-options="
					url:'userAction!showthegnamebyrole.action',
					valueField:'pid',
					textField:'text',
					editable:false,
					onSelect:function(rec){
					finddocsbygid(rec.pid);
					}">
    	</div>
    	<div style="margin-top:5px;margin-bottom:5px">
		<label for="search-doc">输入文件名:</label> 
		<input id="search-doc" class="easyui-searchbox" 
		data-options="prompt:'输入文件名搜索',width:'30px',searcher:searchdoc"></input>	
		</div>
          <table id="usersdoc_datagrid" class="easyui-datagrid" style="height:700px"
              data-options="
              		singleSelect:true,
              		pagination:true,
              		pageList:[10,20,30],
              		collapsible:true,
              		method:'POST',
              		onDblClickRow:onDblClickRowUD,
              		onRowContextMenu:onRowContextMenuUD,
              		view:groupview,
              		loadFilter:pagerFilter,
              		groupField:'gname',
              		pagePosition:'top',
              		groupFormatter:function(value,rows){
              			return value + ' - ' 
              		}">
              <thead>
                  <tr>
                      <th data-options="field:'docname',width:150">文件描述</th>
                      <th data-options="field:'docmodifydate',width:65">修改时间</th>
                      <th data-options="field:'dcname',width:70,align:'right'">类型</th>
                  </tr>
              </thead>
          </table>
          
          <div id="ud_menu" class="easyui-menu" style="width:120px;">
		      <div onClick="OpenDocOnServer(dturlValue,false)">打开</div>
		      <div onClick="$('#dlg2').dialog('open');$('#dlg2').panel('move',{top:150,left:$(document.body).width()-280})">重命名</div>
		      <div onClick="deleteDoc()">删除</div>
		  </div>
  
        </div>
    	
<%--         <div title="全文模板" fit="true">
          <table id="globaltemplate_datagrid" class="easyui-datagrid" style="height:700px"
              data-options="
              singleSelect:true,
              pagination:true,
              collapsible:true,
              url:'docAction!displayGlobalTemplateInfo.action',
              method:'POST',
              loadFilter:pagerFilter,
              columns:[[
              	{field:'dtname',title:'文件名',width:150},
              	{field:'dtcreatedate',title:'创建时间',width:65},
              	{field:'username',title:'创建者',width:55}
              	//{field:'dturl',title:'url',width:50}
              ]],
              onRowContextMenu:onRowContextMenuGT">
          </table>
          
		  <div id="gt_menu" class="easyui-menu" style="width:120px;">
		      <div onClick="javascript:window.open('docPreviewer.jsp?docURL=' + encodeURI(encodeURI(dturlValue)))" data-options="iconCls:'icon-search'">预览</div>
		      <div class="menu-sep"></div>
		      <div onClick="deleteTempDoc(current_doc_url);SaveDocAs(LocalTempFolder + current_doc_url);OpenDocOnServer('<%=HttpAddr%>' + dturlValue,false);InsertFile(LocalTempFolder+current_doc_url);" data-options="iconCls:'icon-add'">载入</div>
		  </div>
        </div> --%>

<%--         <div title="单页模板" fit="true">
          <table id="pagetemplate_datagrid" class="easyui-datagrid" style="height:700px"
              data-options="
              singleSelect:true,
              pagination:true,
              collapsible:true,
              url:'docAction!displayPageTemplateInfo.action',
              method:'POST',
              loadFilter:pagerFilter,
              onRowContextMenu:onRowContextMenuPT">
              <thead>
                  <tr>
                      <th data-options="field:'dtname',width:150">文件名</th>
                      <th data-options="field:'dtcreatedate',width:65">创建时间</th>
                      <th data-options="field:'username',width:55,align:'right'">创建者</th>
                  </tr>
              </thead>
          </table>
          
          <div id="pt_menu" class="easyui-menu" style="width:120px;">
		      <div onClick="javascript:window.open('docPreviewer.jsp?docURL='+dturlValue)" data-options="iconCls:'icon-search'">预览</div>
		      <div class="menu-sep"></div>
		      <div onClick="InsertFile('<%=HttpAddr%>'+dturlValue)" data-options="iconCls:'icon-add'">载入</div>
		  </div>
        </div> --%>
        
        <div title="资料库" fit="true" >
          <div style="margin:5px 5px">
                                 分类：
             <input id="combo_contenttype_dt" class="easyui-combobox" data-options="
				url:'docAction!getContentTypeList.action',
				valueField:'dcid',
				textField:'dcname',
				editable:true,
				onSelect: function(item) {
					loadDataByContentType(item);
				}">
			 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#lib_datagrid').datagrid('loadData', originalTemplateData)">显示全部</a>
		  </div>

          <table id="lib_datagrid" class="easyui-datagrid" style="height:700px"
              data-options="
              singleSelect:true,
              collapsible:true,
              url:'docAction!getContentTypeList.action',
              onLoadSuccess: function() {
              		if(isFirstLoad) {
						originalTemplateData = $('#lib_datagrid').datagrid('getData');
						isFirstLoad = false;
					}
              },
              method:'POST'">
              <thead>
                  <tr>
                      <th data-options="field:'dcname',width:250">名称</th>
                  </tr>
              </thead>
          </table>
          
          <div id="gt_menu" class="easyui-menu" style="width:120px;">
		      <div id="gt_preview" onClick="javascript:window.open('docPreviewer.jsp?docURL=' + encodeURI(encodeURI(dturlValue)))" data-options="iconCls:'icon-search'">预览</div>
		      <div class="menu-sep"></div>
		      <div id="gt_load" onClick="LoadTemplate(current_doc_url,dturlValue);" data-options="iconCls:'icon-add'">载入</div>
		  </div>
          
          <div id="pt_menu" class="easyui-menu" style="width:120px;">
		      <div id="pt_preview" onClick="javascript:window.open('docPreviewer.jsp?docURL='+dturlValue)" data-options="iconCls:'icon-search'">预览</div>
		      <div class="menu-sep"></div>
		      <div id="pt_load" onClick="InsertFile(dturlValue)" data-options="iconCls:'icon-add'">载入</div>
		  </div>
		  
		  <div id="intro_menu" class="easyui-menu" style="width:120px;">
		      <div id="pt_preview" onClick="previewTemplate()" data-options="iconCls:'icon-search'">预览</div>
		  </div>
        </div>
        
      </div>
	    <div style="margin:10px 0;"></div>
	    <div style="margin-left:auto;margin-right:auto;padding:5px;background:#fafafa;width:276px;border:1px solid #ccc">
		  <a href="#" class="easyui-linkbutton" onClick="$('#dlg').dialog('open');$('#dlg').panel('move',{top:150,left:$(document.body).width()-280});initCombobox()">新建</a>
		  <a href="#" class="easyui-linkbutton" onClick="document.getElementById('PageOfficeCtrl').WebSave();">保存</a>
		  <a href="#" class="easyui-linkbutton" onClick="$('#dialog_font').dialog('open');openCreateFont()">造字</a>
		  <a href="#" class="easyui-linkbutton" onClick="$('#dlg_pdf').dialog('open');$('#dlg_pdf').panel('move',{top:150,left:$(document.body).width()-290});initCombobox()">上传</a>
		  <a href="#" class="easyui-linkbutton" onClick="checkDocument()">设置</a>
		  <!--<a href="<%=path.substring(0,path.lastIndexOf("/"))%>/Dazupu/plugin/PedigreePlugins.msi" class="easyui-linkbutton" iconCls="icon-tip">插件下载</a>-->
		</div>
      </div>
    </div>
 </div>
    	<div id="dlg" class="easyui-dialog" title="新建文档" style="width:280px;height:400px;padding:10px;"
			data-options="iconCls:'icon-add',
			closed:true,
			resizable:false,
			modal:true">
			<div style="padding:10px 60px 20px 30px">
				<form id="newdoc_form">
					文件描述:
					<p></p>
					<input id="id_descri" class="easyui-validatebox textbox" type="text" name="doc_descri" data-options="
					required:true,
					missingMessage:'此项必填。'">
					<p></p>
					<!-- 文件名（不能包含汉字）:
					<p></p>
					<tr><input id="id_filename" class="easyui-validatebox textbox" type="text" name="doc_filename" data-options="
					required:true,
					missingMessage:'此项必填。',
					validType:'englishCheck'
					"></input></tr>
					<p></p> -->
					所属谱志 :
					<p></p>
					<input id="combo_pedi" class="easyui-combobox" name="doc_pedi" data-options="
					url:'userAction!showthegnamebyrole.action',
					valueField:'pid',
					textField:'text',				
					editable:false">
					<p></p>
					文档内容类型 :
					<p></p>
					<input id="combo_contenttype_doc" class="easyui-combobox" data-options="
					url:'docAction!getContentTypeList.action',
					valueField:'dcid',
					textField:'dcname',				
					editable:false ">
					<p></p>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="createNewDoc(temp_doc_url)">确定</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg').dialog('close')">取消</a>
				</form>
	        </div>
        </div>
        
        <div id="dialog_info" class="easyui-dialog" title="提示" style="width:400px;height:200px;padding:20px" data-options="iconCls:'icon-save',closed:true,closable:false,resizable:false,modal:true">
			<iframe src="<%=path %>/coverDSO.jsp">
			</iframe>		
		</div>
		
		<div id="dialog_font" class="easyui-dialog" title="造字" style="width:900px;height:500px;margin:auto;padding:20px" data-options="iconCls:'icon-save',closed:true,closable:false,resizable:false,modal:false">
			<iframe id="frame_font" src="<%=path %>/docFont.jsp" style="width:1000px;height:500px">
		    	<%--点击造字出现造字模块浮层start--%>
				<!-- 
					<div style="width:100%;height:100%;z-index:1;position:absolute;display:none;" align="center" id="chareditor">
					<div align="center" style="margin-top:120px;width:850px;height:360px;background-color:RGB(240,240,240);border-style:solid;border-width:1px;border-color:black;">
				 	<div><a onclick="closethechw();"><img src='./title.jpg' align="right"></a></div>
				 -->
			</iframe>
		</div>
	
		<div id="dlg2" class="easyui-dialog" title="重命名文档" style="width:260px;height:200px;padding:10px;"
			data-options="iconCls:'icon-add',
			closed:true,
			resizable:false,
			modal:true">
		
			<div style="padding:10px 60px 20px 30px">
				<form id="newdoc_form">
					新的文件描述:
					<p></p>
					<input id="id_newdescri" class="easyui-validatebox textbox" type="text" name="doc_newdescri" data-options="
					required:true,
					missingMessage:'此项必填。'">
					<p></p>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="renameDoc()">确定</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg2').dialog('close')">取消</a>
				</form>
	        </div>
		</div>
		
		<div id="dlg_pdf" class="easyui-dialog" title="上传PDF文档" style="width:290px;height:430px;padding:10px;"
			data-options="iconCls:'icon-add',
			closed:true,
			resizable:false,
			modal:true">
			<div style="padding:0px 0px 0px 0px">
				<form id="newpdf_form">
					文件描述:
					<p></p>
					<input id="id_descri_pdf" class="easyui-validatebox textbox" type="text" name="pdf_descri" data-options="
					required:true,
					missingMessage:'此项必填。'">
					<p></p>
					<!-- 文件名（不能包含汉字）:
					<p></p>
					<tr><input id="id_filename" class="easyui-validatebox textbox" type="text" name="doc_filename" data-options="
					required:true,
					missingMessage:'此项必填。',
					validType:'englishCheck'
					"></input></tr>
					<p></p> -->
					所属谱志 :
					<p></p>
					<input id="combo_pedi_pdf" class="easyui-combobox" name="pdf_pedi" data-options="
					url:'userAction!showthegnamebyrole.action',
					valueField:'pid',
					textField:'text',				
					editable:false">
					<p></p>
					文档内容类型 :
					<p></p>
					<input id="combo_contenttype_pdf" class="easyui-combobox" data-options="
					url:'docAction!getContentTypeList.action',
					valueField:'dcid',
					textField:'dcname',				
					editable:false ">
					<p></p>
					请选择文件 :
					<p></p>
					<input id="input_file" class="easyui-validatebox" type="text" readonly="true" name="file">  
	                <a href="javascript:void(0)" class="easyui-linkbutton" onClick="getUploadFilePath()">浏览</a>
					<p></p>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="uploadPdf()">确定</a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#dlg_pdf').dialog('close')">取消</a>
				</form>
	        </div>
        </div>
		
		<div id="dlg_style" class="easyui-dialog" title="样式设置" style="width:260px;height:450px;padding:10px;"
			data-options="closed:true,
			resizable:false,
			modal:true">
				<div style="padding:10px 10px 10px 10px">
		        <form id="style_form" method="post">
		        <input id="fontruleid" name="fontruleid" type="hidden" />
		         <input id="rulename" name="rulename" type="hidden" />
		        <input id="selectpedigree" name="selectpedigree" type="hidden" />
		            <table cellpadding="5">
		            <tr>
		            <td><label style="width:70px">
		            		            选择已有的方案:
		            </label>
		            </td>
		            <td>
		            <select id="selectfontsize" name="selectfontsize" style="width:100px">
		            </td>
		            </tr>
						<tr>
							<td>标题一:</td>
							<td><select id='slct_type_title1' name='slct_type_title1' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title1' name='slct_size_title1' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题二:</td>
							<td><select id='slct_type_title2' name='slct_type_title2' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title2' name='slct_size_title2' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题三:</td>
							<td><select id='slct_type_title3' name='slct_type_title3' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title3' name='slct_size_title3' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题四:</td>
							<td><select id='slct_type_title4' name='slct_type_title4' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title4' name='slct_size_title4' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>标题五:</td>
							<td><select id='slct_type_title5' name='slct_type_title5' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋 体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_title5' name='slct_size_title5' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
						<tr>
							<td>正文:</td>
							<td><select id='slct_type_content' name='slct_type_content' class="easyui-combobox"
								name="fonttype" data-options="editable:false"><option
										value="宋体">宋体</option>
									<option value="黑体">黑体</option>
									<option value="楷体">楷体</option>
									<option value="隶书">隶书</option>
							</select> <select id='slct_size_content' name='slct_size_content' class="easyui-combobox"
								name="fontsize" data-options="editable:false"><option
										value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="14">14</option>
									<option value="16">16</option>
									<option value="18">18</option>
									<option value="20">20</option>
									<option value="24">24</option>
									<option value="28">28</option>
									<option value="32">32</option>
									<option value="36">36</option>
									<option value="40">40</option>
									<option value="44">44</option>
									<option value="48">48</option>
									<option value="54">54</option>
									<option value="60">60</option>
									<option value="66">66</option>
									<option value="72">72</option>
									<option value="80">80</option>
									<option value="88">88</option>
									<option value="96">96</option>
							</select></td>
						</tr>
					</table>
		        </form>
		        <div style="text-align:center;padding:5px">
		            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="applyStyleSetting()">应用</a>
		            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="savethenewfontsize()">另存为</a>
		        </div>
		        </div>

		</div>
	<div id="newruledialog" class="easyui-dialog" title="保存新的字体设置方案" style="width:280px;height:180px;padding:10px;"
			data-options="iconCls:'icon-save',
			closed:true,
			resizable:false,
			modal:true">
			<form id="addnewrule" method="post">
			<table cellpadding="5">
					<tr>
					<td>
					<label style="width:100px">
					方案名称:
					</label></td>
					<td><input id="rulenamenew" name="rulenamenew" class="easyui-validatebox" required="true" style="width:130px"></input></td>
					</tr>
					<tr>
					<td>
					<label style="width:100px">
					所属族谱:
					</label>
					</td>
					<td><input id="selectnewpedi" name="selectnewpedi" class="easyui-combobox" name="doc_pedi" data-options="
					url:'userAction!showthegnamebyrole.action',
					valueField:'obj.pid',
					textField:'obj.text',				
					editable:false,required:true" style="width:130px"/>
					</td>
					</tr>
			</table>
			<div style="text-align:center;padding:5px">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="savethefontsize()">保存</a>
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="$('#newruledialog').dialog('close')">取消</a>
			</div>
			</form>
			</div>
			<div>
			<input id="uchidden" name="uchidden" style="hidden" />
			</div>
	<script type="text/javascript">
	$('#selectfontsize').combobox({
		valueField : 'pid',
		textField : 'text',
		onselect:loadthefontsize
	});
	$('#style_form').form({
		url : '<%=path%>/userAction!savethefontrule.action',//保存
		onSubmit : function() {
			},
		success : function(r) {
			var rObj = jQuery.parseJSON(r);
			if (rObj.success) {//插入成功
				$.messager.show({
					title : '提示',
					msg : '字体设置保存成功'
				//提示是否成功的信息
				});
			$('#newruledialog').dialog('close');
				$('#dlg_style').dialog('close');
			}
			else{
				$.messager.show({
					title : '提示',
					msg : '字体设置保存失败，请重试！'
				//提示是否成功的信息
				});
			}
		}
	});
		$(function(){
            $('#lib_datagrid').datagrid({
                view: detailview,
                detailFormatter:function(index,row){
                    return '<div style="padding:2px"><table class="ddv"></table></div>';
                },
                onExpandRow: function(index,row){
                    var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
                    ddv.datagrid({
                        url:'docAction!getTemplateListByContentType.action?contentid='+row.dcid,
                        fitColumns:true,
                        singleSelect:true,
                        view:groupview,
	              		groupField:'dttype',
	              		groupFormatter:function(value,rows){
	              			if(value == 'pt'){
	              				return '单页模板 — 共' + rows.length + '篇。';
	              			} else if(value == 'gt') {
	              				return '全文模板 — 共' + rows.length + '篇。';
	              			} else if(value == 'intro') {
	              				return '说明 — 共' + rows.length + '篇。';
	              			} else if(value == 'model') {
	              				return '范文 — 共' + rows.length + '篇。';
	              			}
	              		},
                        rownumbers:false,
                        loadMsg:'正在加载...',
                        columns:[[
                            {field:'dtname',title:'文档名',width:190},
                            {field:'dtcreatedate',title:'创建时间',width:90,align:'right'},
                            //{field:'dttype',title:'文档类型',width:55,align:'right'}
                        ]],
                        onRowContextMenu:onRowContextMenuLib,
                        onResize:function(){
                            $('#lib_datagrid').datagrid('fixDetailRowHeight',index);
                        },
                        onLoadSuccess:function(){
                            setTimeout(function(){
                                $('#lib_datagrid').datagrid('fixDetailRowHeight',index);
                            },0);
                        }
                    });
                    $('#lib_datagrid').datagrid('fixDetailRowHeight',index);
                }
            });
        });
		function openCreateFont(){
			$("#dialog_font").css("display","block");
		}
		function loadthefontsize(record){
			var fontsizeid=record.pid;
			$.ajax({
				async : false,
				cache : false,
				type : 'post',
				data : 'fontruleid=' + fontsizeid,
				url : '${pageContext.request.contextPath}/userAction!showthefontdetail.action',
				error : function() {//请求失败处理函数  
					$.messager.alert('警告','获取字体设置详细信息失败，请重试！','warning');
				},
				success : function(j) {
					var rObj = jQuery.parseJSON(j);
					if (rObj.success) {
						$('#slct_type_title1').combobox('select', rObj.obj.slct_type_title1);
						$('#slct_type_title2').combobox('select', rObj.obj.slct_type_title2);
						$('#slct_type_title3').combobox('select', rObj.obj.slct_type_title3);
						$('#slct_type_title4').combobox('select', rObj.obj.slct_type_title4);
						$('#slct_type_title5').combobox('select', rObj.obj.slct_type_title5);
						$('#slct_type_content').combobox('select', rObj.obj.slct_type_content);
						$('#slct_size_title1').combobox('select', rObj.obj.slct_size_title1);
						$('#slct_size_title2').combobox('select', rObj.obj.slct_size_title2);
						$('#slct_size_title3').combobox('select', rObj.obj.slct_size_title3);
						$('#slct_size_title4').combobox('select', rObj.obj.slct_size_title4);
						$('#slct_size_title5').combobox('select', rObj.obj.slct_size_title5);
						$('#slct_size_content').combobox('select', rObj.obj.slct_size_content);
					}
					else{
						$.messager.alert('警告','获取字体设置详细信息失败，请重试！','warning');
					}
				}
		});
		}
		function savethenewfontsize(){
			$('#newruledialog').dialog('open');
			$('#newruledialog').panel('move',{top:150,left:$(document.body).width()-280})
		}
		function savethefontsize(){
			var rulename=$('#rulenamenew').val();
			var selectnewpedi=$('#selectnewpedi').combobox('getValue');
			if(!$("#addnewrule").form('validate')){
				$.messager.alert('警告','请输入方案名称并选择相应族谱！','warning');
				return false;
			}
			else{
				$('#rulename').val(rulename);
				$('#selectpedigree').val(selectnewpedi);
			}
			$("#style_form").submit();	
		}
		function searchdoc(value){
			var combo_pedizwj=$("#combo_pedizwj").combobox('getValue');
			if(combo_pedizwj!=null){
				$.ajax({
					async : false,
					cache : false,
					type : 'post',
					data : 'docname='+value+'&gid='+combo_pedizwj,
					url : '<%=path%>/docAction!displayUsersDocbyname.action',//请求的action路径  
					error : function() {//请求失败处理函数  
						alert('选择规则出错，请检查网络！');
					},
					success : function(j) { //请求成功后处理函数。  
						var rObj = eval('(' + j + ')');
						if (rObj!=null) {
							if(rObj!="session"){
							$.messager.show({
								title : '提示',
								msg : '搜索成功！'		
							});
							$('#usersdoc_datagrid').datagrid('loadData', rObj);
							}
							else{
								 $.messager.confirm('提示', '您的登陆信息已经失效，是否重新登录？', function (data) {  
								        if (data) { 
								        	//$('#index-login-dialog').dialog('open');
								        	window.location.href="<%=path %>/index.jsp"; 
								        }  
								        else {  
								        	
								        }  
								    });  
							}
						} else {
								$.messager.show({
									title : '提示',
									msg : '没有搜索到结果，请重新输入文件名！'		
								});
						}
					}
				});
			}
		else{
			$.ajax({
				async : false,
				cache : false,
				type : 'post',
				data : 'docname='+value,
				url : '<%=path%>/docAction!displayUsersDocbyname.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					alert('选择规则出错，请检查网络！');
				},
				success : function(j) { //请求成功后处理函数。  
					var rObj = eval('(' + j + ')');
					if (rObj!=null) {
						$.messager.show({
							title : '提示',
							msg : '搜索成功！'		
						});
						$('#usersdoc_datagrid').datagrid('loadData', rObj);
					} else {
						$.messager.show({
							title : '提示',
							msg : '搜索失败！'		
						});

					}
				}
			});
		}
		}
		function finddocsbygid(gid){
			$.ajax({
				async : false,
				cache : false,
				type : 'post',
				data : 'gid='+gid,
				url : '<%=path%>/docAction!finddocsbygid.action',//请求的action路径  
				error : function() {//请求失败处理函数  
					alert('选择规则出错，请检查网络！');
				},
				success : function(j) { //请求成功后处理函数。  
					var rObj = eval('(' + j + ')');
					if (rObj!=null) {
						if(rObj!="session"){
						$('#usersdoc_datagrid').datagrid('loadData', rObj);
						}
						else{
							 $.messager.confirm('提示', '您的登陆信息已经失效，是否重新登录？', function (data) {  
							        if (data) { 
							        	window.location.href="<%=path %>/index.jsp"; 
							        }  
							        else {  
							        	
							        }  
							    });  
						}
					} else {
						
					}
				}
			});
		}
	</script>
	
	</body>
</html>

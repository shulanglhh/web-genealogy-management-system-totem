var tmpFolder = "D:/pedigree_tmp/";
var isapplyingtemplate=false;
var newurl_applyingtemplate="";
/* Basic Operation */

/*
BOOL SetMenuDisplay(long lMenuFlag)
lMenuFlag为以下数值的组合
#define MNU_NEW                         0x01
#define MNU_OPEN                        0x02
#define MNU_CLOSE                       0x04
#define MNU_SAVE                        0x08
#define MNU_SAVEAS                      0x16
#define MNU_PGSETUP                     0x64
#define MNU_PRINT                       0x256
#define MNU_PROPS                       0x32
#define MNU_PRINTPV                     0x126
*/
function initMenuList(conponentName, optionNum) {
	document.getElementById(conponentName).SetMenuDisplay(optionNum);
}

function hideMenuBar(conponentName) {
	document.getElementById(conponentName).MenuBar = false;
}

function CreateDoc () {
	document.getElementById("oframe").CreateNew("Word.Document");
}

function SaveDocAs(docURL) {
	document.getElementById("oframe").SaveAs(docURL,0);
}

function SaveToServer(fileName) {
	try{	
		document.getElementById("oframe").HttpInit();
		document.getElementById('oframe').HttpAddPostString("FileName",fileName);
		document.getElementById("oframe").HttpAddPostCurrFile("FileData",fileName);
		returnValue = document.getElementById("oframe").HttpPost("http://localhost:8080/cp_pedigree/docAction!uploadDoc.action");
		if("succeed" == returnValue){
			alert("保存到服务器成功");	
		}else if("failed" == returnValue){
			alert("保存到服务器失败");
		}
	}catch(e){
		alert("异常Error:"+e);
	}

}

function OpenLocalDoc(localPath) {
	document.getElementById("oframe").Open(localPath);
}

function OpenDocOnServer(remotePath, isReadOnly) {
	var obj = document.getElementById("PageOfficeCtrl");
	
		if(obj!=null&&obj!=undefined&&obj!=""){
			//document.getElementById("oframe").Open(remotePath, isReadOnly, "Word.Document");
		if (document.getElementById("PageOfficeCtrl").IsDirty == true){
			document.getElementById("PageOfficeCtrl").WebSave();		
		}
			document.getElementById("PageOfficeCtrl").Close();
		}
		
		
		if(isReadOnly){
			document.getElementById("PageOfficeCtrl").WebOpen("document/" + remotePath, "docReadOnly", "TestUser");
		}
		else
		{
			document.getElementById("PageOfficeCtrl").WebOpen("document/" + remotePath, "docNormalEdit", "TestUser");
		}
		document.getElementById("PageOfficeCtrl").Caption = current_doc_title;
		document.getElementById("PageOfficeCtrl").SaveFilePage = "saveFile.jsp?filename=" + remotePath;
}

function OpenTemplateForPreview(remotePath, isReadOnly) {
	document.getElementById("oframe_preview").Open(remotePath, isReadOnly, "Word.Document");
}

function InsertFile(filePath /*可以为远程地址*/) {
	document.getElementById("PageOfficeCtrl").InsertDocumentFromURL("document/"+filePath);
}

function InsertLocalFile(filePath) {
	document.getElementById("oframe").InSertFile(filePath,2);
}

function InsertImg(filePath /*可以为远程地址*/) {
	document.getElementById("oframe").InSertFile(filePath,8/*8表示在光标处插入图片，参考DSOFramer API*/);
}

/* Preview Template */
function PrintView() {
	/*
	VIEW TYPE:
	wdNormalView = 1
	wdOutlineView = 2
	wdPrintView = 3
	wdPrintPreview = 4 
	wdMasterView = 5
	wdWebView = 6
	*/
	document.getElementById("oframe").ShowView(4);
}

function DeleteLocalFile(localPath) {
	document.getElementById("oframe").DeleteLocalFile(localPath);
}

/* Download documents to client */
function DownloadDoc(remotePath, localPath) {
	document.getElementById("oframe").DownloadFile(remotePath,localPath);
}
function LoadTemplate(current_doc_url,dturlValue){
	//alert(current_doc_url);
	//alert(dturlValue);
	newurl_applyingtemplate=current_doc_url.replace("user\/","");
	document.getElementById("PageOfficeCtrl").SaveFilePage = "saveFile.jsp?filename=tmp/tmp_" + newurl_applyingtemplate;
	document.getElementById("PageOfficeCtrl").WebSave();
	document.getElementById("PageOfficeCtrl").Close();
	isapplyingtemplate=true;
	document.getElementById("PageOfficeCtrl").JsFunction_AfterDocumentOpened = "templateloaded()"; 
	document.getElementById("PageOfficeCtrl").WebOpen("document/" + dturlValue, "docNormalEdit", "TestUser");
	//document.getElementById("PageOfficeCtrl").InsertDocumentFromURL("document/tmp/tmp_" + newurl);
}
function templateloaded(){
	var current_doc_url="user/"+newurl_applyingtemplate;
	if(isapplyingtemplate){
		document.getElementById("PageOfficeCtrl").InsertDocumentFromURL("document/tmp/tmp_" + newurl_applyingtemplate);
		
		document.getElementById("PageOfficeCtrl").SaveFilePage="saveFile.jsp?filename=" + current_doc_url;
		document.getElementById("PageOfficeCtrl").WebSave();
		isapplyingtemplate=false;
	}
}






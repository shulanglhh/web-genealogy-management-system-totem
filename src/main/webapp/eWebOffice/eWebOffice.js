/*
  使用方法
  -----------------------------------------------
  1. 在<head></head>中，引用此js文件
     <script type="text/javascript" src="/eWebOffice/eWebOffice.js"></script>

  2. 在要显示eWebOffice控件的地方，写如下代码，则创建了ID为eWebOffice1的控件
	<script type="text/javascript">
	eWebOfficeJS.Create("eWebOffice1", "100%", "100%");
	</script>
  -----------------------------------------------
*/





var eWebOfficeJS = (function(){

	//eWebOffice程序文件夹所在路径，用于指向安装包文件及安装时的提示图片
	var _BasePath = "eWebOffice/"

	//安装包文件路径，用于自动在线安装，请修改为实际部署路径
	var _Codebase = _BasePath + "eWebOfficeActiveX.CAB";

	//clsid,version
	var _Clsid = "3288A274-3E61-4DA5-AC58-FD260D2B5F2B";
	var _Version = "2,5,0,12";


	var _IsIE = (/*@cc_on!@*/false) || document.documentMode>=11;

	var _CheckInstallBegin = function(){
		var s_Flag = _CheckInstall();
		if (s_Flag!=""){
			document.write('<table _name="eWebOffice_InstallingMsg" border=0 cellpadding=2 cellspacing=3 style="border:1px solid gray">'
				+'<tr>'
				+'<td><img border="0" src="'+_BasePath+'loading.gif"></td>'
				+'<td style="color:#ff0000;font-size:12px;font-weight:bold;">使用此功能，您需要'+s_Flag+'eWebOffice控件，当前正在尝试在线安装！请等待...<br>如长时间没有弹出在线安装信息，您可以【<a href="'+_BasePath+'eWebOfficeActiveXInstall.exe">下载安装包</a>】安装。</td>'
				+'</tr>'
				+'</table>');
			window.setTimeout(_CheckInstallEnd, 1000);
		}
	};

	var _CheckInstallEnd = function(){
		var s_Flag = _CheckInstall();
		if (s_Flag!=""){
			window.setTimeout(_CheckInstallEnd, 1000);
		}else{
			var els = document.getElementsByTagName("TABLE");
			for (var i=0; i<els.length; i++){
				if (els[i].getAttribute("_name")=="eWebOffice_InstallingMsg"){
					els[i].style.display = "none";
				}
			}
		}
	};

	var _CheckInstall = function(){
		var s_Flag = "";
		try{
			var eWebOfficeV = new ActiveXObject("eWebSoft.eWebOfficeVersion");
			if (eWebOfficeV.IsNewVersion(_Version)){
				s_Flag = "升级";
			}
			eWebOfficeV = null;
			delete eWebOfficeV;
		}catch(e){
			s_Flag = "安装";
		}
		return s_Flag;
	};

	var _AddEventListener = function( o_SourceObject, s_EventName, v_Listener ){
		if (window.attachEvent){
			o_SourceObject.attachEvent( "on" + s_EventName, v_Listener ) ;
		}else{
			o_SourceObject.addEventListener( s_EventName, v_Listener, false ) ;
		}
	};

	var _RemoveEventListener = function( o_SourceObject, s_EventName, v_Listener ){
		if (window.detachEvent){
			o_SourceObject.detachEvent( "on" + s_EventName, v_Listener ) ;
		}else{
			o_SourceObject.removeEventListener( s_EventName, v_Listener, false ) ;
		}
	};
	
	
	var _FixUnload = function() {
		if (document.readyState == 'interactive') {
			function stop() {
				_RemoveEventListener( document, "stop", stop );
				_Unload();
			};
			_AddEventListener( document, "stop", stop );
			window.setTimeout(function() {
				_RemoveEventListener( document, "stop", stop );
			}, 0);
		}
	};

	var _Unload = function() {
		try{
			var els = document.getElementsByTagName("OBJECT");
			for (var i=0; i<els.length; i++){
				var s_ClassID = els[i].getAttribute("classid");
				if (s_ClassID){
					if (s_ClassID.toUpperCase()=="CLSID:" + _Clsid.toUpperCase()){
						els[i].Quit();
					}
				}
			}
		}catch(e){};
	};

	try{
		_AddEventListener( window, "unload", _Unload );
		_AddEventListener( window, "beforeunload", _FixUnload );
	}catch(e){};


	return {

		//参数分别为：控件ID、宽度、高度
		Create : function(s_ID, s_Width, s_Height){
			var s_Html = '';
			if (_IsIE){
				_CheckInstallBegin();
				s_Html = '<object id="'+s_ID+'" codebase="'+_Codebase+'#version='+_Version+'" classid="clsid:'+_Clsid+'" width="'+s_Width+'" height="'+s_Height+'">'+
						 '<param name="v" value="v">'+
						 '</object>';
			}else{
				s_Html = '<table border=0 cellpadding=0 cellspacing=0 width="'+s_Width+'" height="'+s_Height+'">'+
						 '<tr><td style="background-color:#666666;text-align:center;color:#ffffff;vertical-align:middle;font-size:12px;">请使用IE浏览器浏览此网页！</td></tr>'+
						 '</table>';
			}
			document.write(s_Html);
		},

		//设置基路径,用于此类中用到的相关文件路径指向
		SetBasePath : function(s_Path){
			_BasePath = s_Path;
		},

		//设置常用工作模式:初始化事件
		SetWorkModeOnInit : function(s_ID, s_WorkModeFlag){
			var WO = document.getElementById(s_ID);		//WO=WebOffice
			if (!WO){return;}

			//为了使不同类型的文档，可以最平滑的显示工具栏，先隐藏工具栏，在后面再根据实际打开的文件类型来显示工具栏
			WO.QuickBarVisible = false;

			//兼容文件保存模式
			//WO.CompatibleSaveFormat = false;

			switch(s_WorkModeFlag){
			case "new":
				//隐藏快捷工具栏上的批注相关按钮，新建文档时一般不需要手写批注功能
				WO.QuickBarCommentVisible = false;

				//只允许新建或打开指定类型的文件，当此项设为true时，如filetype="doc"，则新建或打开时只能是doc类型文档；如为false(默认)，会有文档类型选择提示对话框显示。
				//WO.LocalOpenTypeLimit = true;
				break;

			case "read":
				//隐藏快捷工具栏上的文件相关按钮，批注相关按钮
				WO.QuickBarFileVisible = false;
				WO.QuickBarCommentVisible = false;
				//只读模式时，把快捷工具栏上自带的“全屏编辑”改为“全屏显示”
				WO.SetQuickBarItemCaption("SYS_QB_FullScreen", "全屏显示|退出全屏");
				//增加只读模式时的工具栏按钮
				WO.AddQuickBarButton("缩略图", "QB_ViewThumbnails", false, "ViewThumbnails", true, "ReadView", "显示缩略图", 1);
				WO.AddQuickBarButton("文档结构图", "QB_ViewDocumentMap", false, "ViewDocumentMap", true, "ReadView", "显示文档结构图", 2);
				WO.AddQuickBarButton("页面视图", "QB_ViewPage", true, "ViewPage", true, "ReadView", "页面视图", 3);
				WO.AddQuickBarLine("QB_Line1", 4);
				WO.AddQuickBarButton("打印", "QB_Print", false, "Print", true, "", "打印", 5);
				WO.AddQuickBarLine("QB_Line2", 6);
				WO.RefreshQuickBar();
				break;

			case "norevision":
				WO.QuickBarCommentVisible = false;
				//由于加了一个远程保存，为区别开保存，把系统自带的“保存”改为“本地保存”
				WO.SetQuickBarItemCaption("SYS_QB_LocalSave", "保存本地");
				//在第4个按钮之前插入一个按钮
				WO.AddQuickBarButton("保存远程", "QB_WebSave", false, "Save", true, "", "保存到远程服务器", 4);
				WO.RefreshQuickBar();
				break;

			case "yesrevision":
				WO.QuickBarCommentVisible = false;
				//当启用强制痕迹保留时，不能新建或打开文档，只能修改
				WO.SetQuickBarItemVisible("SYS_QB_New", false);
				WO.SetQuickBarItemVisible("SYS_QB_Open", false);
				//由于加了一个远程保存，为区别开保存，把系统自带的“保存”改为“本地保存”
				WO.SetQuickBarItemCaption("SYS_QB_LocalSave", "保存本地");
				//在第4个按钮之前插入一个按钮
				WO.AddQuickBarButton("保存远程", "QB_WebSave", false, "Save", true, "", "保存到远程服务器", 4);
				WO.RefreshQuickBar();
				break;

			case "comment":
				//领导手写批注状态，不需要本地新建、打开
				WO.SetQuickBarItemVisible("SYS_QB_New", false);
				WO.SetQuickBarItemVisible("SYS_QB_Open", false);
				//WO.SetQuickBarItemVisible("SYS_QB_LocalSave", false);
				//由于加了一个远程保存，为区别开保存，把系统自带的“保存”改为“本地保存”
				WO.SetQuickBarItemCaption("SYS_QB_LocalSave", "保存本地");
				//在第4个按钮之前插入一个按钮,此远程保存是含批注的
				WO.AddQuickBarButton("保存远程", "QB_WebSave", false, "Save", true, "", "保存到远程服务器", 4);
				WO.RefreshQuickBar();

				//手写批注模式，保存时要包含批注
				WO.WebSaveOptionComment = true;
				break;

			case "verify":
				//核稿状态，不需要本地新建、打开
				WO.SetQuickBarItemVisible("SYS_QB_New", false);
				WO.SetQuickBarItemVisible("SYS_QB_Open", false);
				//WO.SetQuickBarItemVisible("SYS_QB_LocalSave", false);
				//由于加了一个远程保存，为区别开保存，把系统自带的“保存”改为“本地保存”
				WO.SetQuickBarItemCaption("SYS_QB_LocalSave", "保存本地");
				//在第4个按钮之前插入一个按钮,此远程保存是含批注的
				WO.AddQuickBarButton("保存远程", "QB_WebSave", false, "Save", true, "", "保存到远程服务器", 4);
				WO.RefreshQuickBar();

				WO.WebSaveOptionComment = true;
				break;

			case "embed":
				WO.QuickBarFileVisible = false;
				WO.QuickBarCommentVisible = false;
				WO.AddQuickBarButton("一键套红", "QB_EmbedTemplate", false, "AutoTemplate", true, "", "一键套红", 1);
				WO.AddQuickBarLine("QB_Line1", 2);
				WO.RefreshQuickBar();

				WO.WebSaveOptionComment = true;
				break;

			case "seal":
				WO.QuickBarFileVisible = false;
				WO.QuickBarCommentVisible = false;
				WO.AddQuickBarButton("签名印章", "QB_OpenSeal", false, "Seal", true, "", "签名印章", 1);
				WO.AddQuickBarButton("验证签章", "QB_VerifySeal", false, "VerifySeal", true, "", "验证签章", 2);
				WO.AddQuickBarLine("QB_Line1", 3);
				WO.RefreshQuickBar();

				WO.WebSaveOptionComment = true;
				break;
			}

		},


		//设置常用工作模式:文档打开事件。一般在此事件中，处理Office菜单、工具栏和相关权限保护。
		SetWorkModeOnOpen : function(s_ID, s_WorkModeFlag){
			var WO = document.getElementById(s_ID);		//WO=WebOffice
			if (!WO){return;}

			var s_FileType = WO.CurFileType;

			switch(s_WorkModeFlag){
			case "new":
				//快捷工具栏
				WO.QuickBarVisible = true;

				//隐藏文件菜单
				//WO.SetFileMenuVisible("SYS_FM_New", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalOpen", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalSave", false);
				WO.SetFileMenuVisible("SYS_FM_WebSave", false);
				WO.SetFileMenuVisible("SYS_FM_OpenSeal", false);
				WO.SetFileMenuVisible("SYS_FM_VerifySeal", false);
				WO.SetFileMenuVisible("SYS_FM_OpenVersion", false);
				WO.SetFileMenuVisible("SYS_FM_SaveVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_PrintPreview", false);
				//WO.SetFileMenuVisible("SYS_FM_Print", false);
				
				//权限
				//WO.SetProtect(0);
				WO.ShowRevisions = false;
				WO.TrackRevisions = false;
				//WO.PrintRevisions = true;
				//WO.ShowReviewBar = true;
				//WO.AllowCopy  = true;
				//WO.AllowComment = true;
				//WO.AllowPrint = true;
				break;
			case "read":
				//快捷工具栏
				//只有doc有缩略图模式
				var b_IsDoc = false;
				if (s_FileType=="DOC"){
					WO.WebObject.Application.ActiveWindow.Thumbnails = false;
					WO.WebObject.Application.ActiveWindow.DocumentMap = false;
					b_IsDoc = true;
				}
				if (WO.GetQuickBarItemVisible("QB_ViewThumbnails")!=b_IsDoc){
					WO.SetQuickBarItemVisible("QB_ViewThumbnails", b_IsDoc);
					WO.SetQuickBarItemVisible("QB_ViewDocumentMap", b_IsDoc);
					WO.SetQuickBarItemVisible("QB_ViewPage", b_IsDoc);
					WO.SetQuickBarItemVisible("QB_Line1", b_IsDoc);
					WO.RefreshQuickBar();
				}
				WO.QuickBarVisible = true;
				
				//隐藏菜单栏，工具栏
				WO.HideMenuBar();
				WO.HideToolBar();
			
				//权限
				WO.SetProtect(3);
				//WO.ShowRevisions = false;
				//WO.TrackRevisions = false;
				//WO.PrintRevisions = true;
				WO.ShowReviewBar = false;
				WO.AllowCopy  = false;
				WO.AllowComment = false;
				//WO.AllowPrint = true;


				//WO.WebObject.Application.ActiveWindow.View.FullScreen = true;
				//WO.WebObject.Application.ActiveWindow.DisplayRulers = false;		//隐藏标尺
				//WO.WebObject.Application.DisplayStatusBar = false;				//隐藏状态栏
				break;

			case "norevision":
				//快捷工具栏
				WO.QuickBarVisible = true;
				
				//隐藏文件菜单
				//WO.SetFileMenuVisible("SYS_FM_New", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalOpen", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalSave", false);
				//WO.SetFileMenuVisible("SYS_FM_WebSave", false);
				WO.SetFileMenuVisible("SYS_FM_OpenSeal", false);
				WO.SetFileMenuVisible("SYS_FM_VerifySeal", false);
				//WO.SetFileMenuVisible("SYS_FM_OpenVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_SaveVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_PrintPreview", false);
				//WO.SetFileMenuVisible("SYS_FM_Print", false);
				
				//权限
				//WO.SetProtect(0);
				WO.ShowRevisions = false;
				WO.TrackRevisions = false;
				//WO.PrintRevisions = true;
				//WO.ShowReviewBar = true;
				//WO.AllowCopy  = true;
				//WO.AllowComment = true;
				//WO.AllowPrint = true;
				break;

			case "yesrevision":
				//快捷工具栏
				WO.QuickBarVisible = true;
				
				//隐藏文件菜单
				WO.SetFileMenuVisible("SYS_FM_New", false);
				WO.SetFileMenuVisible("SYS_FM_LocalOpen", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalSave", false);
				//WO.SetFileMenuVisible("SYS_FM_WebSave", false);
				WO.SetFileMenuVisible("SYS_FM_OpenSeal", false);
				WO.SetFileMenuVisible("SYS_FM_VerifySeal", false);
				WO.SetFileMenuVisible("SYS_FM_OpenVersion", false);
				WO.SetFileMenuVisible("SYS_FM_SaveVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_PrintPreview", false);
				//WO.SetFileMenuVisible("SYS_FM_Print", false);
				
				//权限
				//WO.SetProtect(0);
				WO.ShowRevisions = true;
				WO.TrackRevisions = true;
				//WO.PrintRevisions = true;
				WO.ShowReviewBar = false;
				//WO.AllowCopy  = true;
				//WO.AllowComment = true;
				//WO.AllowPrint = true;
				break;

			case "comment":
				//快捷工具栏
				WO.QuickBarVisible = true;
				
				//隐藏文件菜单
				WO.SetFileMenuVisible("SYS_FM_New", false);
				WO.SetFileMenuVisible("SYS_FM_LocalOpen", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalSave", false);
				//WO.SetFileMenuVisible("SYS_FM_WebSave", false);
				//WO.SetFileMenuVisible("SYS_FM_OpenSeal", false);
				//WO.SetFileMenuVisible("SYS_FM_VerifySeal", false);
				//WO.SetFileMenuVisible("SYS_FM_OpenVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_SaveVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_PrintPreview", false);
				//WO.SetFileMenuVisible("SYS_FM_Print", false);
				
				//权限
				//WO.SetProtect(0);
				WO.ShowRevisions = true;
				WO.TrackRevisions = true;
				//WO.PrintRevisions = true;
				WO.ShowReviewBar = true;
				//WO.AllowCopy  = true;
				WO.AllowComment = true;
				//WO.AllowPrint = true;
				
				//转到批注模式
				WO.ChangeViewMode(1);
				break;

			case "verify":
				//快捷工具栏
				WO.QuickBarVisible = true;
				
				//隐藏文件菜单
				WO.SetFileMenuVisible("SYS_FM_New", false);
				WO.SetFileMenuVisible("SYS_FM_LocalOpen", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalSave", false);
				//WO.SetFileMenuVisible("SYS_FM_WebSave", false);
				//WO.SetFileMenuVisible("SYS_FM_OpenSeal", false);
				//WO.SetFileMenuVisible("SYS_FM_VerifySeal", false);
				//WO.SetFileMenuVisible("SYS_FM_OpenVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_SaveVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_PrintPreview", false);
				//WO.SetFileMenuVisible("SYS_FM_Print", false);
				
				//权限
				//WO.SetProtect(0);
				WO.ShowRevisions = true;
				WO.TrackRevisions = true;
				//WO.PrintRevisions = true;
				WO.ShowReviewBar = true;
				//WO.AllowCopy  = true;
				WO.AllowComment = true;
				//WO.AllowPrint = true;
				
				//转到核稿模式
				WO.ChangeViewMode(2);
				break;

			case "embed":
				//快捷工具栏
				WO.QuickBarVisible = true;
				
				//隐藏文件菜单
				WO.SetFileMenuVisible("SYS_FM_New", false);
				WO.SetFileMenuVisible("SYS_FM_LocalOpen", false);
				//WO.SetFileMenuVisible("SYS_FM_LocalSave", false);
				//WO.SetFileMenuVisible("SYS_FM_WebSave", false);
				WO.SetFileMenuVisible("SYS_FM_OpenSeal", false);
				WO.SetFileMenuVisible("SYS_FM_VerifySeal", false);
				WO.SetFileMenuVisible("SYS_FM_OpenVersion", false);
				WO.SetFileMenuVisible("SYS_FM_SaveVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_PrintPreview", false);
				//WO.SetFileMenuVisible("SYS_FM_Print", false);
				
				//权限
				//WO.SetProtect(0);
				//WO.ShowRevisions = true;
				//WO.TrackRevisions = true;
				//WO.PrintRevisions = true;
				//WO.ShowReviewBar = true;
				//WO.AllowCopy  = true;
				//WO.AllowComment = true;
				//WO.AllowPrint = true;
				break;

			case "seal":
				//快捷工具栏
				WO.QuickBarVisible = true;
				
				//隐藏文件菜单
				WO.SetFileMenuVisible("SYS_FM_New", false);
				WO.SetFileMenuVisible("SYS_FM_LocalOpen", false);
				WO.SetFileMenuVisible("SYS_FM_LocalSave", false);
				WO.SetFileMenuVisible("SYS_FM_WebSave", false);
				//WO.SetFileMenuVisible("SYS_FM_OpenSeal", false);
				//WO.SetFileMenuVisible("SYS_FM_VerifySeal", false);
				WO.SetFileMenuVisible("SYS_FM_OpenVersion", false);
				WO.SetFileMenuVisible("SYS_FM_SaveVersion", false);
				//WO.SetFileMenuVisible("SYS_FM_PrintPreview", false);
				//WO.SetFileMenuVisible("SYS_FM_Print", false);
				
				//权限
				//WO.SetProtect(0);
				//WO.ShowRevisions = true;
				//WO.TrackRevisions = true;
				//WO.PrintRevisions = true;
				//WO.ShowReviewBar = true;
				//WO.AllowCopy  = true;
				//WO.AllowComment = true;
				//WO.AllowPrint = true;
				break;

			}

		}

	};

})();
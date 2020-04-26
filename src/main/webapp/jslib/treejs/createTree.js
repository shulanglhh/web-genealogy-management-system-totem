			//声明引入的函数。
			function beforeRemove(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			return confirm("确认删除 人物 -- " + treeNode.name + " 吗？");
		};		
		function beforeRename(treeId, treeNode, newName) {
			if (newName.length == 0) {
				alert("人名不能为空.");
				return false;
			}
			return true;
		};
		var newCount = 1;
	  		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='添加儿女' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				zTree.addNodes(treeNode, {id:(101 + newCount), pId:treeNode.id, name:"new node" + (newCount++)});
                // 这里是增加儿子结点的语句可以和newCout一起来修改
				return false;
			});
		};
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		};	
		//定义zTree的具体参数。
	var setting = {  
            view: {  
                selectedMulti: false,       //禁止多点选中  
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
            },  
            data: {  
                simpleData: {  
                    enable:true,
                    idKey: "id",  
                    pIdKey: "pId",  
                    rootPId: 0  
                }  
            },  
			edit:{
				enable:true,
                editNameSelectAll: true,  
				removeTitle:"删除人物",
				renameTitle:"人物重命名"
				},
            callback: {  
                onClick: function(treeId, treeNode) { //捕捉被点击后的事件回调函数，以后要加上系统后台的录入界面的跳转。 
                    var treeObj = $.fn.zTree.getZTreeObj(treeNode);  
                    var selectedNode = treeObj.getSelectedNodes()[0];  
                    $("#txtId").val(selectedNode.id);  
                    $("#txtAddress").val(selectedNode.name);  
                },
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRightClick: function(event, treeId, treeNode) {
        // 判断点击了tree的“空白”部分，即没有点击到tree节点上
        if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
         zTree.cancelSelectedNode();
         // 只显示添加菜单项，这个只是外观上的控制，不能控制到点击事件！菜单项的点击事件还要额外判断！
         $('#addspouse').attr('disabled', true);
         $('#addbrother').attr('disabled', true);
         $('#hook').attr('disabled', true);
         $('#Timport').attr('disabled', true);
         $('#Texport').attr('disabled', true);
        } else if (treeNode && !treeNode.noR) { // 判断点击的是tree节点，treeNode.noR为true为禁止右键菜单。
         zTree.selectNode(treeNode); // 选中tree节点
         $('#addspouse').attr('disabled', '');
         $('#addbrother').attr('disabled', '');
         $('#hook').attr('disabled', '');
         $('#Timport').attr('disabled', '');
         $('#Texport').attr('disabled', '');
        }
        // 在ztree右击事件中注册easyui菜单的显示和点击事件，让这两个框架实现共用event，这个是整合的关键点
     $('#mm').menu({
            onClick: function(item) {
                if (item.name == 'addsp'&& !$('#addspouse').attr('disabled')) {//这里是增加配偶的接口
                 zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"new node" + (newCount++),icon:"woman.png",sex:"0"});
                 
                 // alert("增加配偶");
                } else if (item.name == 'addbro' && !$('#addbrother').attr('disabled')) {
                    var parNode=treeNode.getParentNode();
                zTree.addNodes(parNode, {id:(100 + newCount), pId:parNode.id, name:"new node" + (newCount++),icon:"man.png"});
                
                 // alert("增加兄弟姐妹");
                } else if (item.name == 'hook' && !$('#hook').attr('disabled')) {
                    
                 alert("挂接");
                } else if (item.name == 'Timport' && !$('#Timport').attr('disabled')){
                	alert("导入");
                }else if (item.name == 'Texport' && !$('#Texport').attr('disabled')){
                	alert("导出");
         }
     }
        });  
           $('#mm').menu('show', {  
               left: event.pageX,  
               top: event.pageY
           });
       } 			
        }
        };  
        var zNodes =[  
            {id:1, pId:0, name:"刘东明", open:true,icon:"man.png",sex:"1"},  
            {id:101, pId:1, name:"姜洋",icon:"man.png",sex:"1"},  
            {id:102, pId:1, name:"王深湛",icon:"man.png",sex:"1"},  
            {id:103, pId:1, name:"谢淼",icon:"man.png",sex:"1"},
			{id:104, pId:101, name:"冯岭",icon:"man.png",sex:"1"}
        ];

        $(document).ready(function(){  
            zTree=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
            // zTree=$.fn.zTree.init($("#treeDemo1"), setting, zNodes);
        });  
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="java.sql.*"%>
<!doctype html>
<html>
  <head>
    <title>造字程序</title>
  <link href="css/flick/jquery-ui-1.10.4.custom.css" rel="stylesheet">
  <style>
  .ui-selecting { filter:alpha(opacity=100); border: solid red 1px;}
  .ui-selected { filter:alpha(opacity=100); border: solid green 1px;}
  #selectable,#selectable2 { list-style-type: none; margin: 0; padding: 0; width:320px;height:320px;background:white}
  li {   float: left; width: 3px; height: 3px; text-align: center;border: solid #555 1px;}
   body
   {
	font: 62.5% "Trebuchet MS", sans-serif;
   }
   label { display:block; }
   input.text { margin-bottom:12px; width:95%; padding: .4em; }
   fieldset { padding:0; border:0; margin-top:25px; }
   h2{font-size:2em;}
    #container{
	width:700px;
	height:350px;
	margin:auto;
	}
	#edit{
	width:320px;
	height:320px;
	float:left;
	}
	#refer{
	width:320px;
	height:320px;
	float:right;
	}
   .turnblack{
	background:black;
  	}
  	 #toolbar{
  	  width:100%;
  	  float:left;
  	  align:center;
  	  margin-left: 30%;
  	 }
  	 #title{
  	 width:700px;
  	 height:50px;
  	 margin: auto;
  	 }
  	 #title1{
  	 float:left;
  	 height:100%;
  	 }
  	 #title2{
  	 float:right;
  	 height:100%;
  	 }
  	 .dragdiv{
  	 border: solid yellow 1px;
  	 filter:alpha(opacity=100);
  	 padding: 0px;
  	 margin: 0px;
  	 float:left;
  	 position:absolute;
  	 }
  	 #myfont{
  	 width:700px;
  	 margin:auto;
  	 height:350px;
  	 overflow: auto;
  	 }
  	 div.img
  {
  margin:7px;
  border:1px solid #bebebe;
  height:auto;
  width:auto;
  float:left;
  text-align:center;
  }
div.img img
  {
  display:inline;
  margin:2px;
  border:1px solid #bebebe;
  }
div.img a:hover img
  {
  border:1px solid #333333;
  }
div.desc
  {
  text-align:center;
  font-weight:normal;
  width:64px;
  font-size:12px;
  margin-top:-5px;
  }
  </style>
  <script src="js/jquery-1.10.2.js"></script>
  <script src="js/jquery-ui-1.10.4.custom.js"></script>
  <script type="text/javascript">
     $(document).ready(function(){
		$("#save,#sl,#clrsl,#copyall,#copyselector,#loadfont").button();    
		$( "#brush" ).buttonset(); 
		
		$("#save").button().click(function() {
			var font="";
            for(var a=0;a<4096;a++){
            	if($("li").eq(a).hasClass("turnblack"))
            	 font=font+"1";
            	 else
            	 font=font+"0";
            }  
            $.post( '${pageContext.request.contextPath}/userAction!savefont.action',
                     {fontinfo:font},
                    function(data) {
                    	 var obj = eval('(' + data + ')');
                    	 var name=obj.obj.name;
                    	 var id=obj.obj.id;//汉字的id
                    	 if(obj.obj!=null)
                         {
                    		 alert("成功保存,汉字名称为#"+name+"汉字id为"+id);
                    		 location.reload();
                         }else
                         alert("保存失败");
                    });
        });
        
         
         $("#loadfont").click(function(){
         $("#selectable2 li").removeClass("turnblack");
		$.post('${pageContext.request.contextPath}/userAction!loadfont.action',{fontname:$("#cc").val().charCodeAt(0)},function(data){
			 var obj = eval('(' + data + ')');
			 var fontinfo=obj.obj.fontinfo;
			if(obj.obj.success==false){
			alert("字库不存在");
			}
			//写入方格
			for(var a=0;a<fontinfo.length;a++){
				if(fontinfo[a]==1)
				$("#selectable2 li").eq(a).addClass("turnblack");
			}
			
		});
	
	});
      });
  </script>
  <script>
   
   /////
   
   
   $(document).ready(function(){
    $(":radio").click(function(){
			$("#mydiv").remove();    
            $("li").removeClass("ui-selected");
    });
    
    $("#save").click(function(){
		$("#mydiv").remove();    
        $("li").removeClass("ui-selected");
      });
    
   }); 
  
  $(document).ready(function(){
               $("li").mousedown(function(){
	  			if($(":radio").get(0).checked)
	  			{
	  			    document.ondragstart=function(){return false;};
	  				$(this).addClass("turnblack");
	  				$("li").bind({mouseover:function(){$(this).addClass("turnblack");}});
	  				$("li").removeClass("ui-selected");  //退出选区模式
	  				$("#mydiv").remove(); //清除已有DIV
	  				$( "#selectable" ).selectable( "destroy" );
   	                $( "#selectable2" ).selectable( "destroy" );
	  			}else if($(":radio").get(1).checked){
	  			    document.ondragstart=function(){return false;};
	  				$(this).removeClass("turnblack");
	  				$("li").bind({mouseover:function(){$(this).removeClass("turnblack");}});
	  				$("li").removeClass("ui-selected");   //退出选区模式
	  				$("#mydiv").remove(); //清除已有DIV
	  				$( "#selectable" ).selectable( "destroy" );
   	                $( "#selectable2" ).selectable( "destroy" );
	  				 }
	  		    		});
	  		    
	  		 $("li").mouseup(function(){
	  		    	$("li").unbind("mouseover");
	  		}); 
    
    $("#sl").click(function(){
     $(":radio").get(0).checked=false;
     $(":radio").get(1).checked=false;
     $( "#selectable" ).selectable({
      stop: function( event, ui ) {
        showborder();
        },
      start: function( event, ui ) {
        $("#mydiv").remove(); //清除已有DIV
      }  
        
        }); 
   	 $( "#selectable2" ).selectable(); 
     });
     
     $("#clrsl").click(function(){                 //清空选区
     	$("#selectable li.ui-selected").removeClass("turnblack");
     });
     
     $("#copyall").click(function(){
         for(var a=0;a<64;a++)
              for(var b=0;b<64;b++)
         {
             if($("#selectable2 li").eq(64*a+b).hasClass("turnblack"))
             {
              $("#selectable li").eq(64*a+b).addClass("turnblack");
             }
         }
     });
     
     
     $("#copyselector").click(function(){
         var num=$("#selectable2 li.ui-selected").size();
         for(var i=0;i<num;i++)
         {
          if($("#selectable2 li.ui-selected").eq(i).hasClass("turnblack"))
             {
              var strnum=$("#selectable2 li.ui-selected").eq(i).data("number");
              $("#selectable li").eq(strnum).addClass("turnblack");
             }
         }
     });
  });
  
  </script>
<script type="text/javascript" src="js/tool.js"></script></head>
<body>
<div id="title">
	<div id="title1"><h2>编辑区</h2></div>
	<div id="title2"><h2>参考区</h2></div>
</div>
<div id="container">
<div id="edit">
<ol id="selectable">
<script>
  for(var j=0;j<4096;j++)
  {
      var node=$("<li></li>").data("number",j);  //给每个格子存储数据
      $("#selectable").append(node);
  }
  </script>
  </ol>
</div>
<div id="refer">
<ol id="selectable2">
<script>
  for(var j=0;j<4096;j++)
  {
      var node=$("<li></li>").data("number",j);  //给每个格子存储数据
      $("#selectable2").append(node);
  }
  </script>
  </ol>
</div>
<div style="clear:both"></div>
</div>
 <div id="toolbar">
 		<button id="save">保存</button>
 		<span id="brush">
        <input type="radio" name="mode" value="pen" id="pen" checked="checked"/><label for="pen">画笔</label>
        <input type="radio" name="mode" value="eraser" id="eraser" /><label for="eraser">橡皮</label>
        </span>
        <button id="sl">选区</button>
        <button id="clrsl">清空选区</button>
        <button id="copyall">拷贝所有</button>
        <button id="copyselector">拷贝选区</button>
        <input type="text" name="fontname" size="1" id="cc" /><button id="loadfont">载入</button>
</div>
<div id="myfont">
	<h2>已造字列表</h2>
	
</div>
<script type="text/javascript">
$(document).ready(function(){
	$.post("${pageContext.request.contextPath}/userAction!allfont.action",function(data){
		   var obj = eval('(' + data + ')');
		   var fontobj=obj.obj;
		   for(var a=0;a<fontobj.length;a++){
			   $("#myfont").append("<div class='img'><a target='_blank' href='../myfont/"+fontobj[a].name+".bmp'><img src='../myfont/"+fontobj[a].name+".bmp'  width='64' height='64'></a><div class='desc'>#"+fontobj[a].name+"</div><a href='javascript:void(0)' class='deletefont'>删除</a></div>");
		   }
		   $(".deletefont").click(function(){
				var fontname=$(this).siblings(".desc").text(); 
				$.post('${pageContext.request.contextPath}/userAction!delfont.action',{"fontname":fontname},function(){
					alert("删除成功");
					location.reload();
				});
			});
	});
	
});
	</script>
  </body>
</html>

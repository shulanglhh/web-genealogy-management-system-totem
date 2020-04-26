function verse(array){   //转置矩阵用的函数
         	var hang=array.length;
         	var lie=array[0].length;
         	var newArray = new Array();   
           for(var k=0;k<lie;k++){        
           newArray[k]=new Array();    
            for(var j=0;j<hang;j++){      
              newArray[k][j]=array[j][k];       
             }
           }
            return newArray;
         }
         
     function resizeArray(array,newlength){   //对一位数组进行放缩的函数,array为原始数组,newlength为新数组长度
           var oldlength=array.length;
           var newarray = new Array(newlength);   
           for(var i=0;i<newlength;i++)
               newarray[i]=0;
           var rate=newlength/oldlength;
           for(var t=0;t<oldlength;t++)
           {
               if(array[t]==0)
               continue;
               else
               {
                    var long=1; 
               		for(var k=t+1;k<oldlength;k++)
                    {
                       if(array[k]==1)
                       long++;
                       else 
                       break;
                    }  //找到一个起始下标为t,连续长度为long的子串1，把它按比例写进新的数组
                    var startpoint=Math.floor(rate*t);
                    var changdu=Math.ceil(rate*long);
                    
                    for(var i=0;i<changdu;i++){
                      newarray[startpoint+i]=1;
                    }
               }
           }
              return newarray;
         }
     
     function resizediv(){   //对超出编辑区的部分重修
         var divx=$("#mydiv").offset().left;  //层的坐标
         var divy=$("#mydiv").offset().top;
         
         var maxwidth=805-divx+5;
         var maxheight=373-divy+5;
         //如果是放大
         if(maxwidth<$("#mydiv").width())
         $("#mydiv").css("width",maxwidth);
         if(maxheight<$("#mydiv").height())
         $("#mydiv").css("height",maxheight);
     };
     
      function refontinfo(){
          //生成原始二维数组oldinfo
      	var wnum1=$("#mydiv").data("widthnum");
      	var hnum1=$("#mydiv").data("heightnum");
      	var image=$("#mydiv").data("oldinfo");
      	var oldinfo= new Array();   
           for(var k=0;k<hnum1;k++){        
             oldinfo[k]=new Array();    //声明hnum行，wnum列的二维数组
              for(var j=0;j<wnum1;j++){  
                 var temp=k*wnum1+j;   
                oldinfo[k][j]=image[temp];       //这里将变量初始化
               }
             }
             
          //更新div的宽高值,初始化新二维数组
         var wnum2=$("#mydiv").width()/5;
         var hnum2=$("#mydiv").height()/5;
         var newinfo = new Array();   
           for(var m=0;m<wnum2;m++){        
             newinfo[m]=new Array();    //声明二维数组newinfo
              for(var n=0;n<hnum2;n++){      
                newinfo[m][n]=0;       //这里将变量初始化，我这边统一初始化为0，后面在用所需的值覆盖里面的值
               }
             }
             
             var tempinfo = new Array();   //声明二维数组tempinfo
           for(var m=0;m<hnum1;m++){        
             tempinfo[m]=new Array();    
              for(var n=0;n<wnum2;n++){      
                tempinfo[m][n]=0;       //这里将变量初始化，我这边统一初始化为0，后面在用所需的值覆盖里面的值
               }
             }
             //下面做矩阵变换oldinfo[hnum1][wnum1]-->tempinfo[hnum1][wnum2]-->转置-->tempinfo2[wnum2][hnum1]-->newinfo[wnum2][hnum2]-->转置-->newinfo2[hnum2][wnum2]
             for(var a=0;a<hnum1;a++){
                tempinfo[a]=resizeArray(oldinfo[a],wnum2);
             }
             var tempinfo2=verse(tempinfo);
             
             for(var a=0;a<tempinfo2.length;a++){
                 newinfo[a]=resizeArray(tempinfo2[a],hnum2);
              }
             
             var newinfo2=verse(newinfo);  //放缩完毕的二维数组
              
              var image = new Array();
             //下面把二维数组转化成一维，再写进选区就可以了
             for(var a=0;a<newinfo2.length;a++){
             		for(var b=0;b<newinfo2[0].length;b++){
             		 image[a*newinfo2[0].length+b]=newinfo2[a][b];
             		}
             }
             for(var j=0;j<image.length;j++){
  	         if(image[j]==1)
  	    	 $("#selectable li.ui-selected").eq(j).addClass("turnblack");
  	    	 else
  	    	 $("#selectable li.ui-selected").eq(j).removeClass("turnblack");
  	    }
             
             $("#mydiv").data("newinfo",image);
      }
      
      function reselect(){  //根据新的div画选区,画完要把mydiv中的一维数组更新
          $("#selectable li").removeClass("ui-selected");  //先清空，再画
          var left1=$("#mydiv").offset().left;
   	   var top1=$("#mydiv").offset().top;
   	   var left2=$("#selectable li:first").offset().left;
   	   var top2=$("#selectable li:first").offset().top;
   	   var fli=(top1-top2)/5*64+(left1-left2)/5;  //fli是拖拽后的新地点的左上角的li编号
   	   var widthnum=$("#mydiv").width()/5;
   	   var heightnum=$("#mydiv").height()/5;
   	       for(var n=0;n<heightnum;n++)
   	       {
   	          for(var m=0;m<widthnum;m++)
   	         {
   	           $("#selectable li").eq(fli).addClass("ui-selected");  //做选择
   	           fli++;
   	         }
   	          fli=fli+64-widthnum;
   	       }
       };
       
       function showborder(){   //显示选区的边框,将选区信息载入这个层并初始化拖动功能,根据选区画边框
    	      var num=$("#selectable li.ui-selected").size();
    	      var firx=$("#selectable li.ui-selected").eq(0).offset().left;
    	      var firy=$("#selectable li.ui-selected").eq(0).offset().top;
    	      var lasx=$("#selectable li.ui-selected").eq(num-1).offset().left;
    	      var lasy=$("#selectable li.ui-selected").eq(num-1).offset().top;
    	      var divx=lasx-firx+5;
    	      var divy=lasy-firy+5;
    	      var divnode=$("<div id='mydiv'></div>");   //绘制可拖拽的DIV
    	      divnode.addClass("dragdiv");
    	      divnode.css("height",divy);
    	      divnode.css("width",divx);
    	      $("#selectable").append(divnode);
    	      divnode.offset({left:firx,top:firy});
    	      
    	      
    	      //生成选区内信息的一维数组
    	      var image=new Array(num);
    	      for(var i=0;i<num;i++)
    	      {
    	        if($("#selectable li.ui-selected").eq(i).hasClass("turnblack"))
    	        image[i]=1;
    	        else
    	        image[i]=0;
    	      }
    	      $(divnode).data("newinfo",image);
    	      document.ondragstart=function(){return true;};  //启用拖拽 				
    	      $(divnode).draggable({     //对DIV拖拽初始化
    						containment : "#selectable",
    						scroll : false,
    						cursor : "move",
    						grid: [ 5, 5 ],
    						stop: function( event, ui ) {
    						downinfo();
    						}
    					});
    					
    		 $(divnode).resizable({
    		 				 grid: [ 5, 5 ],
    		 				 create: function( event, ui ) {
    		 				      var h=$(this).height()/5;
    		 				      var w=$(this).width()/5;
    		 				      $(this).data("widthnum",w);    //把放缩前的宽、高单元格数目和黑白信息的一维数组写入mydiv的data
    	                          $(this).data("heightnum",h);
    		 				      var data=$(this).data("newinfo");    //oldinfo存放缩放之前的数组信息，newinfo存放最新的数组信息
    		 				      $(this).data("oldinfo",data);               //把newinfo数组备份为oldinfo
    		 				 },
    		 				 stop: function( event, ui ) {
    		 				 $("#selectable li.ui-selected").removeClass("turnblack");
    						 resizediv();  //根据放缩实际大小重画DIV
    						 reselect(); //把新区域DIV内部的li设置为选中
    						 refontinfo();//把区域内的文字进行缩放
    						}
    		 });		
    	   }
    	   
    	   function downinfo(){   //拖拽结束时调用的函数，先清空原有层，再把拖动后的层信息下方到对应网格中
    	   	   $("#selectable li.ui-selected").removeClass("turnblack");   //取消原有黑色信息
    		   $("#selectable li").removeClass("ui-selected");  //拖动时取消原来选区
    		   //下面把携带的信息写到格子上,先画绿色选区，再写入黑色
    		   //计算DIV左上角第一个单元格的编号
    		   var left1=$("#mydiv").offset().left;
    		   var top1=$("#mydiv").offset().top;
    		   var left2=$("#selectable li:first").offset().left;
    		   var top2=$("#selectable li:first").offset().top;
    		   var fli=(top1-top2)/5*64+(left1-left2)/5;  //fli是拖拽后的新地点的左上角的li编号
    		   var widthnum=$("#mydiv").width()/5;
    		   var heightnum=$("#mydiv").height()/5;
    		   
    		       for(var n=0;n<heightnum;n++)
    		       {
    		          for(var m=0;m<widthnum;m++)
    		         {
    		           $("#selectable li").eq(fli).addClass("ui-selected");  //做选择
    		           fli++;
    		         }
    		          fli=fli+64-widthnum;
    		       }
    		    //下面把黑白信息写进去
    		    var image=$("#mydiv").data("newinfo");
    		    for(var j=0;j<widthnum*heightnum;j++){
    		         if(image[j]==1)
    		    	 $("#selectable li.ui-selected").eq(j).addClass("turnblack");
    		    	 else
    		    	 $("#selectable li.ui-selected").eq(j).removeClass("turnblack");
    		    }
    	   }
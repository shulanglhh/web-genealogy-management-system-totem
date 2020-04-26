<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="pragma" content="no-cache" />
<title>功能导航</title>

<jsp:include page="./inc.jsp"></jsp:include>
<script type="text/javascript" src="<%=path %>/jslib/layer.min.js"></script>
<style>
    .step-button {
	   	float:left; 
	   	width:140px;height:140px;
		background-color:#0;		
		color: #663399;
		position:relative;
		font-family: 'Open Sans', sans-serif;
		font-size:12px;
		text-decoration:none;			
		
		margin: 12px 0px 12px 10px;
		padding: 12px 0px 12px 10px;
		background-image: linear-gradient(bottom, rgb(171,27,27) 0%, rgb(212,51,51) 100%);
		border-radius: 5px;
	}
	.step-intro {
		font-color:#336699;
		position: relative;
		left: 20%;
	}
	.step-arrow {
	   	float:left; 
	   	width:140px;height:140px;		
		text-decoration:none;
		color:#fff;
		
		margin: 12px 0px 12px 10px;
		padding: 12px 0px 12px 10px;
		background-image: linear-gradient(bottom, rgb(171,27,27) 0%, rgb(212,51,51) 100%);
		border-radius: 5px;
	}
	.step-arrow img{
		position: relative;
		top: 25%;
		left: 25%;		
	}
	
	.sstep-arrow {
	   	float:left; 
	   	width:140px;height:50px;		
		text-decoration:none;
		color:#fff;
		
		margin: 12px 0px 12px 10px;
		padding: 12px 0px 12px 10px;
		background-image: linear-gradient(bottom, rgb(171,27,27) 0%, rgb(212,51,51) 100%);
		border-radius: 5px;
	}
	
</style>
</head>

<body class="easyui-layout" data-options="fit:true">
	<div data-options="region:'north'" style="height:50px;overflow:hidden;" data-options="fit:true">
		<div align=right>
		<span>
			<jsp:include page="./header.jsp"></jsp:include>
		</span>
		</div>
	</div>
	<div data-options="region:'south'" style="height:20px"></div>
	<div data-options="region:'west',title:'菜单',split:true"
		style="width:200px">
		<jsp:include page="./newnav.jsp"></jsp:include>
	</div>
	<div data-options="region:'center'" id="centerLayout">		
	<div id="step" class="easyui-panel"  style="position: absolute;
		top: 8%;left: 5%;width: 850px;height: 550px;padding: 20px 0px;
		border-bottom: 1px solid #CCC;">	
		
		<%-- <div id="step1" class="step-button" style="">
			<img src="./images/icons/user_group_01.png" style="width:128px;height:128px"></img>
			<div class="step-intro"><span><strong>组建团队</strong></span></div>
		</div>
		<div class="step-arrow" style="">
			<img src="./images/icons/forward.png" style="width:64px;height:64px"></img>			
		</div>	--%>	
		<div id="step2" class="step-button" style="">
			<img src="./images/icons/input_keyboard.png" style="width:128px;height:128px"></img>
			<div class="step-intro"><span><strong>数据录入</strong></span></div>
		</div>
		<div class="step-arrow" style="">
			<img src="./images/icons/backward.png" style="width:64px;height:64px"></img>
		</div>
		<div id="step3" class="step-button" style="">
			<img src="./images/icons/scratch_new.png" style="width:128px;height:128px"></img>
			<div class="step-intro"><span><strong>创建族谱</strong></span></div>
		</div>
		
		<div class="sstep-arrow" style="">
			
		</div>
		<div class="sstep-arrow" style="">
			
		</div>		
		<div class="sstep-arrow" style="">
			
		</div>
		<div class="sstep-arrow" style="">
			
		</div>
		<div class="sstep-arrow" style="">
			<img src="./images/icons/down.png" style="position:relative;top:8px;left:38px;width:64px;height:64px"></img>
		</div>
		
		<%-- <div id="step6" class="step-button" style="">
			<img src="./images/icons/editcopy.png" style="width:128px;height:128px"></img>
			<div class="step-intro"><span><strong>校对管理</strong></span></div>
		</div>
		<div class="step-arrow" style="">
			<img src="./images/icons/backward.png" style="width:64px;height:64px"></img>
		</div> --%>
		<div id="step5" class="step-button" style="">
			<img src="./images/icons/session_manager.png" style="width:128px;height:128px"></img>
			<div class="step-intro"><span><strong>数据管理</strong></span></div>
		</div>
		<div class="step-arrow" style="">
			<img src="./images/icons/forward.png" style="width:64px;height:64px"></img>
		</div>
		<div id="step4" class="step-button" style="">
			<img src="./images/icons/pdf.png" style="width:128px;height:128px"></img>
			<div class="step-intro"><span><strong>生成pdf</strong></span></div>
		</div>
		

    </div>
    </div>
<script><%--
	var layer1,layer2,layer3,layer4,layer5,layer6,layer7,layer8,layer9,laye10,layer11,layer12;
	$('#step1').click(function(){
		layer.closeAll();
		layer1 = $.layer({
		    type : 1,
		    title : '组建团队',		    
		    shade : [0.6, '#eeeeee'],
		    //offset:['100px' , '190px'],
		    border : false,
		    area : ['900px','600px'],
		    page : {dom : '#pp',url:'b_template.jsp'}
		});
	});
	$('#step2').click(function(){
		layer.closeAll();
		layer2 = $.layer({
		    type : 1,
		    shade : [0],
		    title : '创建谱志',
		    shade : [0.6, '#eeeeee'],
		    border : false,
		    area : ['900px','600px'],		    
		    page : {dom : '#pp',url:'b_template.jsp'}
		});
	});
	$('#step3').click(function(){
		layer.closeAll();
		layer3 = $.layer({
		    type : 1,
		    shade : [0.6, '#eeeeee'],
		    title : '数据录入',		   
		    border : false,
		    area : ['1000px','600px'],
		    page : {dom : '#pp',url:'b_template.jsp'}
		});
	});
	$('#step4').click(function(){
		layer.closeAll();
		layer4 = $.layer({
		    type : 1,		   
		    shade : [0.6, '#eeeeee'],
		    title : '生成排版',		    
		    border : false,
		    area : ['900px','600px'],
		    offset:['',''],
		    page : {dom : '#pp',url:'b_template.jsp'}
		});
	});
	
	$('#step5').click(function(){
		layer.closeAll();
		layer5 = layer.tips('tips的样式并非是固定的，您可自定义外观。', this, {
		    style: ['background-color:#78BA32; color:#fff', '#78BA32'],
		    maxWidth:185,
		    guide: 2,
		    time: 3,
		    closeBtn:[0, true]
		});
	});
	$('#step6').click(function(){
		layer.closeAll();
		layer6 = layer.tips('tips的样式并非是固定的，您可自定义外观。', this, {
		    style: ['background-color:#aaa; color:#333333', '#aaa'],
		    maxWidth:185,
		    guide: 2,
		    time: 3,
		    closeBtn:[0, true]
		});
	});
--%>
<%-- <% String ur=(String)session.getAttribute("userrole");  --%>
//    if(("方志录入员").equals(ur))
<%--    {%> $('#step').html(""); --%>
<%--    location.href='<%=path%>'+'/localChronicles.jsp'; --%>
//    //$('#navbar a:first-child').trigger('click');
<%--    <%}%> --%>
<!-- </script> -->
</body>
</html>
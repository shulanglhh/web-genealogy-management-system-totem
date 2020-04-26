<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
div.top-line p {
	margin: 0px;
	margin-left: 20px;
	font-size: 14px;
}

div.rt_div p {
	margin: 0px;
	margin-left: 20px;
	font-size: 14px;
}

div.bottom-line p {
	margin: 0px;
	margin-left: 20px;
	font-size: 14px;
}

p.intro {
	width: 11em;
	margin-left: 20px;
	word-wrap: break-word;
}

p strong {
	font-size: 16px;
}

div.rt_container {
	margin: 20px;
	width: 15em;
	position: relative;
}

div.rt_div {	
	background-image: url("v-line.png");
	background-repeat: repeat-y;
	position: relative;
	float: center;
}

div.top-line {
	width: 100%;
	float: top;
	background-image: url('top-line.png');
	background-repeat: no-repeat;
}

div.bottom-line {	
	bottom: 0;
	background-image: url("bottom-line.png");
	background-repeat: no-repeat;
}
</style>
<%--<div class="rt_container">
	<div class="top-line">
		<p>
			<strong>瑄公</strong><img src="h-line.png" style="float:right;"></img>
		</p>
	</div>
	<div class="rt_div">
		<p class="intro">名金， 字世祥， 生卒年不详。官翰林侍讲，黄巢僭称假诏，聘公相。公忠耿不事伪主，僭肆退隐</p>
		<p>
			妻<strong>许氏</strong>
		</p>
		<p class="intro">生卒年不详。</p>
		<p>子二 令远 令宜</p>
		<p>
			继妻<strong>张氏</strong>
		</p>
		<p class="intro">生卒年不详。</p>
		<p>子二 令先 令后</p>
	</div>
	<div class="bottom-line">
		<p>&nbsp;</p>
	</div>	
</div>
--%><div class="rt_container">
	<span id="mother-name" style="display:inline-block;margin-top:5px;color:red;overflow:hidden;">		
	</span>
	<span id="arrange-num" style="display:inline-block;margin-top:5px;color:red;overflow:hidden;">		
	</span>
	<span id="special-rel-desc" style="display:inline-block;margin-top:5px;color:red;overflow:hidden;">		
	</span>
	<span  style="display:inline-block;margin-top:5px;overflow:hidden;">	
	<div id="rt_content"></div>	
	</span>


</div>
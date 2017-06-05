<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" name="viewport" id="viewport">
    <meta name="format-detection"content="telephone=no" />   	
	<meta http-equiv="x-ua-compatible" content="ie=7" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	<!--<meta name="renderer" content="webkit">-->
    <title>太平洋出国|直播首页</title>

	<link rel="stylesheet" type="text/css" href="/resource/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="/resource/css/common.css" type="text/css" />
	<link rel="stylesheet" href="/resource/css/live.css" type="text/css" />
	<link href="/resource/css/nep.min.css" rel="stylesheet">
	</head>
	<body class="bg-grey">
		<!-- 页头 开始 -->		
		<%@include file="/views/common/header.jsp" %>
		<!-- 页头 结束 -->

		<div class="live-banner">
			<div class="container tpy-container">
				<div class="row">
					<div class="col-xs-8">
						<p class="live-ztitle">${live.live_title }</p>
						<p class="live-time">时间：<span class="pl-5"><fmt:formatDate value="${live.live_start_time }" pattern="yyyy.MM.dd"/></span>
						<span class="pl-15"><fmt:formatDate value="${live.live_start_time }" pattern="HH:mm"/></span><span class="pl-35">主讲人：${live.presenter }</span></p>
					</div>
					
					<c:if test="${live.live_status == '直播中' && (verified == true || live.live_type == '公开')}">
					<div class="col-xs-3 col-xs-offset-1 flex" style="justify-content: center;">
						<div <c:if test="${likeInfo.like == 0 }">class="live-zan js-live-vote on"</c:if><c:if test="${likeInfo.like != 0 }">class="live-zan js-live-vote"</c:if> >
							<p class="pt-10"><img src="/resource/images/live-zan.png" alt=""/></p>
							<p>点赞</p>
						</div>
						<div <c:if test="${likeInfo.like == 1 }">class="live-zhuan js-live-vote on"</c:if><c:if test="${likeInfo.like != 1 }">class="live-zhuan js-live-vote"</c:if> >
							<p class="pt-10"><img src="/resource/images/live-zhuan.png" alt=""/></p>
							<p>拍砖</p>
						</div>
					</div>
					</c:if>
					
					<!-- 非直播中 -->
					<c:if test="${live.live_status != '直播中' }">
					<div class="col-xs-12 clearfix live-video">
						<div class="live-video-left">
							<div class="live-left-boxs"><img src="${live.live_poster }" alt="" /></div>
							<div class="live-notice">
								<div class="live-notice-btitle"><c:if test="${live.live_status == '已发布' }">课程预告</c:if><c:if test="${live.live_status == '已结束' }">已结束</c:if></div>
								
								<p class="live-ztitle">${live.live_title }</p>
								<p>时间：<fmt:formatDate value="${live.live_start_time }" pattern="yyyy.MM.dd    HH:mm"/></p>
								<div class="live-speaker clearfix alignItem">
									<div>主讲人：</div>
									<div class="live-speaker-header"><img src="${live.headimg }" alt="" onerror="javascript:this.src='/resource/images/gj-headico.jpg';"/></div>
									<div class="col-xs-7">
										<p>${live.presenter }</p>
										<p>资深移民顾问</p>
									</div>
								</div>
								<!-- 私密直播 -->
								<c:if test="${live.live_type == '私密' }">
									<p>报名时间：
										<c:if test="${start != 1}"><!-- 报名中、未开始 -->
											<fmt:formatDate value="${live.signup_start_time }" pattern="yyyy.MM.dd"/>至<fmt:formatDate value="${live.signup_end_time }" pattern="yyyy.MM.dd"/>
										</c:if>
										<c:if test="${start == 1 }"><!-- 已结束 -->
											已截止
										</c:if>
									</p>
									<c:if test="${empty live.live_status }">
										<p class="mt-20"><a class="live-btn" href="javascript:;" onclick="apply();">申请报名</a></p>
									</c:if> 
									<c:if test="${apply == false && limit == false && start == 0}"><!-- 未报名、未申请 且报名人数未满 -->
										<p class="mt-20"><a class="live-btn" href="javascript:;" onclick="apply();">申请报名</a></p>
									</c:if>
									<c:if test="${apply == true}"><!-- 已报名或已申请 -->
										<p class="mt-20">${apply_status }</p>
									</c:if>
									<c:if test="${can_temp == true}">
										<p class="mt-20"><a class="live-btn" href="javascript:;" onclick="applyCode();">申请临时听课码</a></p>
									</c:if>
									<c:if test="${start == 1 || limit == true}"><!-- 报名结束 或 报名人数已满 -->
										<c:if test="${apply != true }">
											<p class="mt-20"><a class="live-btn" href="javascript:;" onclick="applyCode();">申请临时听课码</a></p>
										</c:if>
									</c:if>
									
								</c:if>
								<!-- 私密直播 -->
							</div>
						</div>
						<div class="live-video-right">
							<h2 class="live-video-title">课程简介</h2>
							<div class="live-video-text">
								 <p>${live.live_introduce }</p>
							</div>
						</div>
					</div>
					</c:if>
					<!-- 非直播中 -->
					
					<!-- 直播中 -->
					<c:if test="${live.live_status == '直播中' }">
						
						<c:if test="${live.live_type == '公开' || verified == true}"> <!-- 对于公开直播或已认证的私密直播，直接进入 -->
							<c:if test="${not empty custinfo }">
								<div class="col-xs-12 clearfix live-video">
									<div class="live-video-left">
										<div class="live-left-boxs">
											<div id="neplayer">
						       				 	<video id="my-video" class="video-js" controls poster="//nos.netease.com/vod163/poster.png" preload="auto" width="840" height="500" data-setup={}>
						       				 	<source src="${channel.httpPullUrl }" type="video/mp4"></video>
						       				 </div>
										</div>
									</div>
									<div class="live-video-right">
										<h2 class="live-video-title">留言</h2>
										<div class="live-video-text">
											<ul class="live-message-ul" id="messages">
												
											</ul>
										</div>
										<div class="live-message-enter">
											<p class="live-message-header alignItem"><span><img src="${custinfo.headImg }" onerror="javascript:this.src='/resource/images/gj-headico.jpg';" alt="" /></span><c:if test="${empty custinfo.wxName }">匿名用户</c:if><c:if test="${not empty custinfo.wxName }"> <script type="text/javascript">document.write(decodeURI("${custinfo.wxName }"));</script> </c:if></p>
											<p><input class="live-message-input" maxlength="100" type="text" id="contents"/><input class="live-message-btn" type="submit" value="发布" /></p>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${empty custinfo }">
								<div class="col-xs-12 clearfix live-video">
									<div class="live-video-left">
										<div class="live-left-boxs"><img src="${live.live_poster }" alt="" /></div>
										<div class="live-notice">
											<div class="live-notice-btitle text-orange">课程进行中...</div>
											
											<p class="live-ztitle">${live.live_title }</p>
											<p>时间：<fmt:formatDate value="${live.live_start_time }" pattern="yyyy.MM.dd    HH:mm"/></p>
											<div class="live-speaker clearfix alignItem">
												<div>主讲人：</div>
												<div class="live-speaker-header"><img src="${live.headimg }" alt="" onerror="javascript:this.src='/resource/images/gj-headico.jpg';"/></div>
												<div class="col-xs-7">
													<p>${live.presenter }</p>
													<p>资深移民顾问</p>
												</div>
											</div>
											
											<a class="live-btn ml-50" href="javascript:;" onclick="user_login();">登录观看直播</a>
										</div>
									</div>
									<div class="live-video-right">
										<h2 class="live-video-title">课程简介</h2>
										<div class="live-video-text">
											 <p>${live.live_introduce }</p>
										</div>
									</div>
								</div>
							</c:if>
						</c:if>
						<c:if test="${live.live_type == '私密' && verified != true}"> <!-- 对于未认证或认证失败的私密直播，让用户进行认证或显示状态 -->	
							<div class="col-xs-12 clearfix live-video">
								<div class="live-video-left">
									<div class="live-left-boxs"><img src="${live.live_poster }" alt="" /></div>
									<div class="live-notice">
										<div class="live-notice-btitle text-orange">课程进行中...</div>
										
										<p class="live-ztitle">${live.live_title }</p>
										<p>时间：<fmt:formatDate value="${live.live_start_time }" pattern="yyyy.MM.dd    HH:mm"/></p>
										<div class="live-speaker clearfix alignItem">
											<div>主讲人：</div>
											<div class="live-speaker-header"><img src="${live.headimg }" alt="" onerror="javascript:this.src='/resource/images/gj-headico.jpg';"/></div>
											<div class="col-xs-7">
												<p>${live.presenter }</p>
												<p>资深移民顾问</p>
											</div>
										</div>
										
										<c:if test="${verified == false }"><!-- 认证失败 -->
											<p class="mt-20">${apply_status }</p>
										</c:if>
										<c:if test="${empty verified}"><!-- 未认证 -->
											<p>${apply_status }
											<c:if test="${hadApplyCode != true}">
												<a class="live-btn ml-50" href="javascript:;" onclick="applyCode();">临时申请听课码</a>
											</c:if>
											
											</p>
											<p class="mt-20">输入听课码，参与本次课程</p>
											<p class="live-input mt-20"><input type="text" id="code"/></p>
											<p class="mt-20"><a class="live-btn" href="javascript:;" onclick="valiCode();">我要听课</a></p>
										</c:if>
									</div>
								</div>
								<div class="live-video-right">
									<h2 class="live-video-title">课程简介</h2>
									<div class="live-video-text">
										 <p>${live.live_introduce }</p>
									</div>
								</div>
							</div>
						</c:if>
					</c:if>
						
					<!-- 直播中 -->
					
					
				</div>
			</div>
		</div>
		<div class="container tpy-container"><!--中间container开始-->
			<div class="row">
				<div class="col-xs-12 live-title">直播间</div>
			</div>
			<div class="row">
				<ul class="col-xs-12 live-ul">
					<c:forEach items="${liveList}" var="item" varStatus = "status">
						<li class="col-md-3 col-xs-12">
							<div class="live-li-img">
								<a href="/live/${item.live_id }"><img src="${item.live_poster }" onerror="javascript:this.src='/resource/images/gj-headico.jpg';" alt="" /></a>
								<c:if test="${item.live_status == '直播中' }">
									<p class="live-live-status">正在播放</p>
								</c:if>
							</div>
							<h2><a href="#">${item.live_title }</a></h2>
							<p>时间：<fmt:formatDate value="${item.live_start_time }" pattern="yyyy.MM.dd HH:mm"/>   </p>
							<p>主讲人：${item.presenter }</p>
						</li>
					</c:forEach>
				</ul>
			</div>
			<!-- 相关活动 -->
		</div><!--中间container结束-->
		
		<!-- 页尾 开始 -->
		<%@ include file="/views/common/footer.jsp"%>
		<!-- 页尾 结束 -->
	<%@include file="/views/common/loginbox.jsp" %>
	<script type="text/javascript" src="/resource/js/system/jquery-2.2.0.min.js"></script>
	<script data-main="/resource/js/project/main-live" src="/resource/js/system/require.js"></script>
	<script src="/resource/js/modules/common.js"></script>
    <script src="/resource/js/modules/formValidate.js"></script>
	<script type="text/javascript">
	//点赞
	$(".live-zan").on("click",function(){
		var $this = $(this);
		$.ajax({
            url: '/live/praise/${live.live_id}',
            type: "get",
            dataType: "json",
            success: function (result) {
            	if(result.status == 0){
            		$this.addClass("on").siblings().removeClass("on");
            	}else if(result.status == 2){
            		$(".js-login").click();
            	}
            }
    	}) 
	});
	//拍砖
	$(".live-zhuan").on("click",function(){
		var $this = $(this);
		$.ajax({
            url: '/live/tread/${live.live_id}',
            type: "get",
            dataType: "json",
            success: function (result) {
            	if(result.status == 0){
            		$this.addClass("on").siblings().removeClass("on");
            	}else if(result.status == 2){
            		$(".js-login").click();
            	}
            }
    	}) 
	});
	
	//直播报名
	function apply(){
		$.ajax({
            url: '/live/apply/${live.live_id}',
            type: "get",
            dataType: "json",
            success: function (result) {
            	if(result.status == 2){
            		$(".js-login").click();
            	}else{
            		layer.alert(result.msg,function(data){
                    	location.reload();
            		});
            	}
            	
            }
    	}) 
	}
	
	//申请临时听课码
	function applyCode(){
		$.ajax({
            url: '/live/applyCode/${live.live_id}',
            type: "get",
            dataType: "json",
            success: function (result) {
            	if(result.status == 2){
            		$(".js-login").click();
            	}else{
            		layer.alert(result.msg,function(data){
            			location.reload();
            		});
                	
            	}
            	
            }
    	}) 
	}
	
	//我要听课 - 听课码校验
	function valiCode(){
		if($("#code").val() == null || $("#code").val().trim() == ''){
			alert("听课码不能为空!");
		}else{
			$.ajax({
	            url: '/live/watch',
	            data:{
	            	live_id:"${live.live_id}",
	            	code:encodeURIComponent($("#code").val())
	            },
	            type: "get",
	            dataType: "json",
	            success: function (result) {
	            	if(result.status == 0){
	            		location.reload();
	            	}else if(result.status == 2){
	            		$(".js-login").click();
	            	}else{
	            		layer.alert(result.msg,function(data){
	            			location.reload();
	            		});
	                	
	            	}
	            }
	    	}) 
		}
		
	}
	
	//登录
	function user_login(){
		$(".js-login").click();
	}
	
	//发布留言
	$(".live-message-btn").on("click",function(){
		$.ajax({
            url: '/live/comment',
            data:{
            	live_id:"${live.live_id}",
            	contents:encodeURIComponent($("#contents").val())
            },
            type: "get",
            dataType: "json",
            success: function (result) {
            	if(result.status == 0){
            		$("#contents").val("");
            		
            		layer.alert("评论成功",function(data){
            			//刷新留言
                		loadMessages();
                		$(".layui-layer-shade,.layui-layer").remove();
            		});
            		
            		
            	}else{
            		$(".js-login").click();
            	}
            }
    	}) 
	});
	
	window.onload=function(){
		$("#contents").val("");
		
		autoWatch();
		autoReloadMsg();
	}
	/* $(document).ready(function(){
		autoWatch();
		autoReloadMsg();
	});  */
	
	function autoReloadMsg(){
		loadMessages();
		setInterval('loadMessages()',"${message_refresh_rate}");
	}
	
	//直播中的公开直播 或已认证直播 直接登录
	function autoWatch(){
		if("${live.live_status}" == "直播中" && ("${verified}" == "true" || "${live.live_type}" == "公开") && "${custinfo}" != null && "${custinfo}" != ""){
			$.ajax({
	            url: '/live/watch',
	            data:{
	            	live_id:"${live.live_id}"
	            },
	            type: "get",
	            dataType: "json",
	            success: function (result) {
	            	
	            }
	    	}) 
		}
	}
	
	//用户评论
	function loadMessages(){
		if("${live.live_status}" == "直播中" && ("${verified}" == "true" || "${live.live_type}" == "公开") && "${custinfo}" !=null && "${custinfo}" != ""){
			$.ajax({
	            url: '/live/liveMessages/${live.live_id}',
	            type: "get",
	            dataType: "json",
	            success: function (result) {
	            	if(result.status == 2){//被取消参与资格
	            		location.reload();
	            	}else{
	            		$("#messages").html(result.messages);
	            	}
	            	
	            }
	    	})
		}
	}
	
	//页面刷新、跳转、关闭时更新用户的在线状态
	//为兼容windows下不同浏览器 onunload(firefox/) 和 onbeforeunload（chrome/qq）都需要
	window.onunload = function(){
		//debugger
		if("${live.live_status}" == "直播中" && ("${verified}" == "true" || "${live.live_type}" == "公开") && "${custinfo}" !=null && "${custinfo}" != ""){
			$.ajax({
	            url: '/live/offLine/${live.live_id}',
	            type: "get",
	            dataType: "json",
	            success: function (result) {
	            	
	            	
	            }
	    	})
		}
	}
	window.onbeforeunload = function(){
		//debugger
		if("${live.live_status}" == "直播中" && ("${verified}" == "true" || "${live.live_type}" == "公开") && "${custinfo}" !=null && "${custinfo}" != ""){
			$.ajax({
	            url: '/live/offLine/${live.live_id}',
	            type: "get",
	            dataType: "json",
	            success: function (result) {
	            	
	            	
	            }
	    	})
		}
	}
	</script>
	<!-- <script src="//nos.netease.com/vod163/nep.min.js"></script> -->
	<script type="text/javascript">
	neplayer('my-video');
	</script>
</body>
</html>
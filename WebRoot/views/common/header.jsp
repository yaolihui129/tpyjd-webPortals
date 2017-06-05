<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="../resource/css/layer.css" type="text/css" />
<!--header头部开始-->
<div class="tpy-header">
	<div class="tpy-header-top">
		<div class="container tpy-top-container">
			<div class="row">
				<div class="col-xs-2 tpy-header-company">
					<span>北京</span><span class="tpy-company-branch">分公司</span>
					<ul class="tpy-company-ul hide">
						<li><a href="#">沈阳</a></li>
						<li><a href="#">大连</a></li>
						<li><a href="#">长春</a></li>
						<li><a href="#">南京</a></li>
						<li><a href="#">上海</a></li>
						
					</ul>
				</div>
				<div class="col-xs-7 tpy-header-contact">
					<span class="tpy-contact-chat">微信关注</span><span class="tpy-contact-tel">直接联系</span>
					<div class="tpy-chat-box hide">
						<p><img src="/resource/images/tpy-chat.jpg" alt="" /></p>
						<p>关注了解更多资讯</p>
					</div>
					<div class="tpy-tel-box hide">
						<p><img src="/resource/images/tpy-tel-code.jpg" alt="" /></p>
						<p>扫码直接拨打电话</p>
					</div>
				</div>
				<div class="col-xs-2 tpy-header-phone pull-right">400-610-8118</div>
			</div>
		</div>
	</div>
	<div class="tpy-header-bottom">
		<div class="container tpy-bottom-container">
			<div class="row">
				<div class="col-xs-5 tpy-header-logo"><img src="/resource/images/tpy-logo.png" alt="" /></div>
				<div class="col-xs-4 tpy-header-nav">
					<ul>
						<li><a href="/">首页</a><i></i></li>
						<li <c:if test="${menu_on == 'live' }">class="on"</c:if> ><a href="/live">直播 </a><span>${liveDate }</span><i></i></li>
					</ul>
				</div>
				<div class="col-xs-3 tpy-header-status">
				<c:if test="${not empty custinfo}">
					<div class="tpy-login alignItem">
						<div class="tpy-login-img"><img src="<c:if test="${empty custinfo.headImg}">../resource/images/person-head.jpg</c:if><c:if test="${not empty custinfo.headImg}">${custinfo.headImg}</c:if>" alt="" /></div>
						<div class="tpy-login-name">${custinfo.phoneNum}</div>
					</div>
					<div class="tpy-login-box hide">
						<!-- <p><a href="#">我的业务</a></p> -->
						<p><a href="/person/living">我的活动</a></p>
						<p><a href="/logout">退出登录</a></p>
						
					</div>
				</c:if>	
				<c:if test="${empty custinfo}">
					<ul class="js-log-btn">
								<li><a class="js-login" href="#">登录</a></li>
								<li class="tpy-register"><a class="js-register" href="#">注册</a></li>
							</ul>
				</c:if>			
				</div>
				
			</div>
		</div>
	</div>
</div>
<!--header头部结束-->
		<!-- <script>
		var reclick = true;
		
			function login(){
				debugger
				var flag = true;
				var box = $(".js-alert-box").find(".tpy-login-context.on"),
					tel = box.find(".js-tel"),
					secret = box.find(".js-password");
				if(tel.hasClass("forbid")){
					flag = false;
					tel.next().removeClass("hide");
					return;
				}
				if(secret.hasClass("forbid")){
					flag = false;
					secret.next().removeClass("hide");
					return;
				}
				tel_val = tel.val(),
				secret_val = secret.val();
				if(flag === true){
					//放入提交代码
					if(reclick){//防止重复提交
						reclick = false;
						$.post(
								"/register/login",
								{
									"phone":tel_val,
									"password":secret_val	
								},
								function(data){
									if(data.status == 0){
										reclick = true;
										layer.alert("恭喜您登录成功",function(){
											window.location.reload();
										});
									}else{
										reclick = true;
										layer.alert(data.msg);
									}
								}	
						)
					}
				}
			}
			
			function register(){
				
				var flag = true;
				var box = $(".js-alert-box").find(".tpy-login-context.on"),
					tel = box.find(".js-tel"),
					secret = box.find(".js-password"),
					yzm = box.find(".register-yzm");
				if(tel.hasClass("forbid")){
					flag = false;
					tel.next().removeClass("hide");
					return;
				}
				if(secret.hasClass("forbid")){
					flag = false;
					secret.next().removeClass("hide");
					return;
				}
				yzm_val = yzm.val();
				if(!yzm_val){
					flag = false;
					layer.alert("验证码不能为空");
					return;
				}
				if (document.getElementById("register-checkbox").checked == false) {
                	flag = false;
                	layer.alert("请同意用户注册协议");
                	return;
            	} 
				tel_val = tel.val(),
				secret_val = secret.val();
				
				if(flag === true){
					//放入提交代码
					if(reclick){//防止重复提交
						reclick = false;
						$.post(
								"/register",
								{
									"phone":tel_val,
									"password":secret_val,
									"security":yzm_val
								},
								function(data){
									if(data.status == 0){
										reclick = true;
										layer.alert("恭喜您注册成功",function(){
											window.location.reload();
										});
										
									}else{
										reclick = true;
										layer.alert(data.msg);
									}
								}	
						)
					}
				}
			}
			function reset(){
				
				var flag = true;
				var box = $(".js-alert-mmbox"),
					tel = box.find(".js-tel"),
					secret = box.find(".js-password"),
					yzm = box.find(".register-yzm");
				if(tel.hasClass("forbid")){
					flag = false;
					tel.next().removeClass("hide");
					return;
				}
				if(secret.hasClass("forbid")){
					flag = false;
					secret.next().removeClass("hide");
					return;
				}
				yzm_val = yzm.val();
				if(!yzm_val){
					flag = false;
					layer.alert("验证码不能为空");
					return;
				}
				tel_val = tel.val(),
				secret_val = secret.val();
				if(flag === true){
					//放入提交代码
					if(reclick){//防止重复提交
						reclick = false;
						$.post(
								"/register/reset",
								{
									"phone":tel_val,
									"password":secret_val,
									"security":yzm_val
								},
								function(data){
									if(data.status == 0){
										reclick = true;
										layer.alert("恭喜您重置密码成功",function(){
											window.location.reload();
										});
										
									}else{
										reclick = true;
										layer.alert(data.msg);
									}
								}	
						)
					}
				}
			}
		</script> -->
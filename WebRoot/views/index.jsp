<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="author" content="Alvaro Trigo Lopez" />
    <meta name="description" content="fullPage plugin by Alvaro Trigo. Pure javascript version of full screen slider." />
    <meta name="keywords" content="fullpage,jquery,alvaro,trigo,plugin,fullscren,screen,full,iphone5,apple,pure,javascript,slider,hijacking" />
    <meta name="Resource-type" content="Document" />
    <title>太平洋出国</title>

    <link rel="stylesheet" type="text/css" href="/resource/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/resource/css/javascript.fullPage.css" />
    <link rel="stylesheet" href="/resource/css/common.css" type="text/css" />
    <link rel="stylesheet" href="/resource/css/person.css" type="text/css" />
    <link rel="stylesheet" href="/resource/css/cj-person.css">
    <link rel="stylesheet" href="/resource/css/index.css">
    <link rel="stylesheet" href="/resource/css/animate.css">
    <style>
        #section-footer {
            width: 100%;
            height: auto;
        }
    </style>
</head>

<body style="display:relative;">
    <ul id="menu">
        <li data-menuanchor="page1" class="active pot">
            <a href="#page1"></a>
        </li>
        <li data-menuanchor="page2" class="active pot">
            <a href="#page2"></a>
        </li>
        <li data-menuanchor="page3" class="active pot">
            <a href="#page3"></a>
        </li>
        <li data-menuanchor="page4" class="active pot">
            <a href="#page4"></a>
        </li>
    </ul>
    <!--导航条登陆状态开始-->
    <div class="tpy-header-bottom tpy-header-bar">
        <div class="container tpy-bottom-container person-business">
            <div class="row">
                <div class="col-xs-5 tpy-header-logo"><img src="/resource/images/tpy-logo2.png" alt="" /></div>
                <div class="col-xs-4 tpy-header-nav">
                    <ul>
                        <li><a href="#">首页</a></li>
                        <li><a href="/live">直播 <span>${liveDate }</span></a></li>
                    </ul>
                </div>
                <div class="col-xs-3 tpy-header-status">
                
                <c:if test="${not empty custinfo}">
					<div class="tpy-login-bar alignItem">
						<div class="tpy-login-img"><img src="<c:if test="${empty custinfo.headImg}">../resource/images/person-head.jpg</c:if><c:if test="${not empty custinfo.headImg}">${custinfo.headImg}</c:if>" alt="" /></div>
						<div class="tpy-login-name">${custinfo.phoneNum}</div>
					</div>
					<div class="tpy-login-box-bar hide">
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
    <!--导航条登陆状态结束-->
    <!--导航条未登陆状态开始-->
    <!-- <div class="tpy-header-bottom tpy-header-bar">
        <div class="container tpy-bottom-container person-business">
            <div class="row">
                <div class="col-xs-5 tpy-header-logo"><img src="./resource/images/tpy-logo2.png" alt="" /></div>
                <div class="col-xs-4 tpy-header-nav">
                    <ul>
                        <li><a href="#">首页</a></li>
                        <li><a href="#">直播 <span>3月3日开播</span></a></li>
                    </ul>
                </div>
                <div class="col-xs-3 tpy-header-status">
                    <ul class="js-log-btn">
                        <li><a class="js-login" href="#">登录</a></li>
                        <li class="tpy-register"><a class="js-register" href="#">注册</a></li>
                    </ul>
                </div>

            </div>
        </div>
    </div>-->
    <!--导航条未登陆状态结束-->
    <div id="fullpage">
        <div class="section fp-auto-height header">
            <!-- 页头 开始 -->		
			<%@include file="/views/common/header.jsp" %>
			<!-- 页头 结束 -->
        </div>
        <div class="section">
            <div class="index index-1">
                <div class="index1-content">
                    <div class="index1-title-top fadeInUpBig">
                        <div class="index1-title">
                            <p class="index1-big-title">太平洋出国集团</p>
                            <p class="index1-little-title">境外全服务领跑者</p>
                        </div>
                    </div>
                    <div class="index1-text fadeInUpBig">助您移居乐土、吸干净空气、享优质教育、资产保值增值、健康幸福！</div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="index index-2">
                <div class="index2-content">
                    <div class="index2-title">
                        <p class="index2-title-top">移民</p>
                        <p class="index2-title-bottom">Immigrate</p>
                    </div>
                    <div class="index2-masage">太平洋出国拥有20余年的移民经验，是2002年首批获得公安部颁发个人出入境资格认证的机构，于2016年8月成为中国移民行业龙头股。</div>
                    <ul class="index2-condition">
                        <li>中国移民行业挂牌公司：项目更安全，管理更规范，服务更周到，价格更透明</li>
                        <li>三个纪录： I-526、I-829、返款均通过纪录，确保绿卡、资金万无一失</li>
                        <li>大量成功案例：57个项目，成功取得近两万张绿卡</li>
                        <li>律所护航：国际移民律师城，美国六大律所，28位顶级律师全程服务</li>
                        <li>安家服务：一对一管家服务，涉及移民前期—中期—后期，全程无忧</li>

                    </ul>
                    <a href="#" class="more">了解更多 >></a>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="index index-3">
                <div class="index3-content">
                    <div class="index2-title index3-title">
                        <p class="index3-title-top">留学</p>
                        <p class="index3-title-bottom">Study abroad</p>
                    </div>
                    <div class="index2-masage index3-masage">太平洋出国留学的主营板遍布北美洲、欧洲、澳洲等各大高校，主打高端留学，打造留学超市、游学超市、移民留学一条龙等特色服务，开设出题官课程。</div>
                    <ul class="index2-condition index3-condition">
                        <li> 国常青藤盟校成长计划合作单位</li>
                        <li>私人订制留学规划，提供个人成长设计</li>
                        <li>转为工薪阶层设计移民之路</li>
                        <li>留学游学超市、留学移民一条龙服务，更多选择，更便捷</li>
                    </ul>
                    <a href="#" class="more index3-more">了解更多 >></a>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="index index-4">
                <div class="index4-content">
                    <div class="index2-title index4-title">
                        <p class="index4-title-top">海外房产</p>
                        <p class="index4-title-bottom">Overseas property</p>
                    </div>
                    <div class="index2-masage index3-masage">海外房产为购房者与海外房产商建立了直接接触的安全、透明交易平台，提供美国、英国、加拿大、澳大利亚、新西兰、泰国等国房产。</div>
                    <ul class="index2-condition index3-condition">
                        <li>专业团队 提供全球资产配置方案</li>
                        <li>全球房产 真实房源真实价格</li>
                        <li>一站服务 复杂流程我们帮您解决</li>
                        <li>交易安心 交易全程资金监管保安全</li>
                    </ul>
                    <a href="#" class="more index3-more">了解更多 >></a>
                </div>
            </div>
        </div>
        <div class="section fp-auto-height" id="section-footer" style="display:block;">
            <div id="footer-text" style="height:290px;">
                <!-- 页尾 开始 -->
					<%@ include file="/views/common/footer.jsp"%>
				<!-- 页尾 结束 -->
            </div>
        </div>
    </div>
    <%@include file="/views/common/loginbox.jsp" %>
    <script src="/resource/js/system/jquery-2.2.0.min.js"></script>
    <script data-main="/resource/js/project/main-person" src="/resource/js/system/require.js"></script>
    <script src="/resource/js/modules/common.js"></script>
    <script src="/resource/js/modules/formValidate.js"></script>
    <script type="text/javascript" src="/resource/js/modules/fullPage.js"></script>
    <script type="text/javascript">
        $('#fullpage').fullpage({
            anchors: ['header', 'page1', 'page2', 'page3', 'page4', 'footer'],
            menu: '#menu',
            css3: true,
            /* afterLoad: function (index, anchorLink) {
                 if (index == 6) {
                     $("#menu").css("display", "none");
                 }
             },*/
            onLeave: function (index, direction) {
                if (index == '1') {
                    $(".tpy-header-bar").fadeIn(2000);
                    $("#menu").fadeIn(700);
                };
                if (index == '2' && direction == '1') {

                    $(".tpy-header-bar").css("display", "none");
                    $("#menu").fadeOut(700);
                };
                if (index == '6') {
                    $("#menu").fadeIn(700);

                };
                if (index == '5' && direction == '6') {
                    $("#menu").fadeOut(700);
                }
            }

        });
    </script>

</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="col-xs-3 person-leftbar mb-20"><!--个人中心leftbar开始-->
					<div class="person-head-img"><img src="<c:if test="${empty custinfo.headImg}">../resource/images/person-head.jpg</c:if><c:if test="${not empty custinfo.headImg}">${custinfo.headImg}</c:if>" alt="" /></div>
					<p class="text-center mb-20"><script type="text/javascript">document.write("<c:if test='${empty custinfo.wxName}'>${custinfo.phoneNum}</c:if><c:if test='${not empty custinfo.wxName}'>"+decodeURI("${custinfo.wxName}")+"</c:if>")</script></p>
					<ul class="person-bar-ul">
						<%-- <li>
							<h2>我的业务</h2>
							<p <c:if test="${menu_on == 'headImg'}">class="on"</c:if>><a href="#">进行中</a></p>
							<p <c:if test="${menu_on == 'headImg'}">class="on"</c:if>><a href="#">已完成</a></p>
						</li> --%>
						<li>
							<h2 class="person-bar-active">我的活动</h2>
							<p <c:if test="${menu_on == 'live'}">class="on"</c:if>><a href="/person/living">网上直播</a></p>
							<p <c:if test="${menu_on == 'evaluate'}">class="on"</c:if>><a href="/person/evaluateResult">评估结果</a></p>
						</li>
						<li>
							<h2 class="person-bar-manage">账户管理</h2>
							<p <c:if test="${menu_on == 'personInfo'}">class="on"</c:if>><a href="/person/perosnInfo">个人信息</a></p>
							<p <c:if test="${menu_on == 'headImg'}">class="on"</c:if>><a href="/person/headImg">用户头像</a></p>
							<p <c:if test="${menu_on == 'password'}">class="on"</c:if>><a href="/register/changePassword">修改密码</a></p>
						</li>
					</ul>
				</div><!--个人中心leftbar结束-->
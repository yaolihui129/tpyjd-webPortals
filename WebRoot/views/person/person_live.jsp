<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" name="viewport" id="viewport">
    <meta name="format-detection"content="telephone=no" />   	
	<meta http-equiv="x-ua-compatible" content="ie=7" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<!--<meta name="renderer" content="webkit">-->
    <title>太平洋出国|个人中心</title>



<link rel="stylesheet" type="text/css" href="../resource/css/bootstrap.min.css" />
<link rel="stylesheet" href="../resource/css/common.css" type="text/css" />
<link rel="stylesheet" href="../resource/css/person.css" type="text/css" />
<link rel="stylesheet" href="../resource/css/cj-person.css">
</head>

<body class="bg-grey">
       <jsp:include page="../common/header.jsp"></jsp:include>
    <div class="container tpy-container">
        <div class="row person-breadline">
            <div class="col-xs-12"><a href="#">首页</a> > <a href="#">个人中心</a> > <a href="#">账户管理</a> > <a href="#">个人信息</a></div>
        </div>
        <div class="row mt-10">
                <jsp:include page="../common/lefter.jsp"></jsp:include>
            <div class="col-xs-9 pr-0">
                <!--个人中心rightbox开始-->
                <c:if test="${not empty liveList}">
                	<c:forEach items="${liveList}" var="item" varStatus="status">
		                <div class="prson-rightbox <c:if test='${status.count > 1}'>mt-10</c:if>">
		                    <div class="person-zhibo">
		                        <h1>直播：${item.live_title}</h1>
		                        <a href="javascript:;"><c:if test="${item.status != '002700020001'}">报名失败，请联系我们</c:if><c:if test="${item.status == '002700020001'}">报名成功</c:if></a>
		                    </div>
		                    <div class="person-zhibo-content">
		                        <div class="zhibo-man">讲解人：${item.english_name} ${item.job_title}</div>
		                        <div class="zhibo-time">时间：<fmt:formatDate value="${item.live_start_time}" type="both"/></div>
		                        <div class="zhibo-text">
		                            <p>培训简介：</p>
		                            <p class="zhibo-text-content">${item.live_introduce}</p>
		                        </div>
		                    </div>
		                </div>
                	</c:forEach>
                </c:if>
                <c:if test="${empty liveList}">
                	<h2>您未报名参与直播活动</h2>
                </c:if>
            </div>
            <!--个人中心rightbox结束-->
        </div>
    </div>
   </div>
    <!--footer头部结束-->
    <jsp:include page="../common/footer.jsp"></jsp:include>
    <script data-main="../resource/js/project/main" src="../resource/js/system/require.js"></script>
    </body>
</html>
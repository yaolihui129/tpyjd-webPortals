<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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



	<link rel="stylesheet" type="text/css" href="../resource/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="../resource/css/common.css" type="text/css" />
	<link rel="stylesheet" href="../resource/css/person.css" type="text/css" />
	</head>
	<body class="bg-grey">
		<jsp:include page="../common/header.jsp"></jsp:include>

		<div class="container tpy-container"><!--中间container开始-->
			<div class="row person-breadline"><div class="col-xs-12"><a href="#">首页</a> > <a href="#">个人中心</a> > <a href="#">账户管理</a> > <a href="#">个人信息</a></div></div>
			<div class="row mt-15 mb-15">
				<jsp:include page="../common/lefter.jsp"></jsp:include>
				<div class="col-xs-9 pr-0"><!--个人中心rightbox开始-->
					<div class="prson-rightbox container person-rightbox-result">
						<div class="row person-result-row">
						<c:if test="${!empty resultList}">
							<c:forEach var="item" items="${resultList}"  varStatus="status">
							<c:if test="${status.count > 1}"><hr></hr></c:if>
							<div class="col-xs-9 person-result-title">
								${item.projectName}
							</div>
							<div class="col-xs-3 person-result-percent">
								匹配度：<span><c:if test="${item.matching != null}">${item.matching}%</c:if></span>
							</div>
							<div class="clearfix">
								<ul class="person-result-ul">
									<li  <c:choose>
											<c:when test="${item.country==1 || item.country==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.country==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>移民国家</li>
									<li  <c:choose>
											<c:when test="${item.hotspots==1 || item.hotspots==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.hotspots==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>移民目的</li>
									<li  <c:choose>
											<c:when test="${item.asset==1 || item.asset==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.asset==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>资产要求</li>
									<li  <c:choose>
											<c:when test="${item.immigration_budget==1 || item.immigration_budget==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.immigration_budget==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>移民预算</li>
									<li  <c:choose>
											<c:when test="${item.qualifications==1 || item.qualifications==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.qualifications==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>学历要求</li>
									<li  <c:choose>
											<c:when test="${item.language==1 || item.language==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.language==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>外语能力</li>
									<li  <c:choose>
											<c:when test="${item.manage==1 || item.manage==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.manage==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>管理经验</li>
									<li  <c:choose>
											<c:when test="${item.live_requirement==1 || item.live_requirement==null}">
												 class="col-xs-6 no-match"
											</c:when>
											<c:when test="${item.live_requirement==2}">
												class="col-xs-6 no-match2"
											</c:when>
											<c:otherwise>
												class="col-xs-6"
											</c:otherwise>
										</c:choose>>居住条件</li>
								</ul>
							</div>
							</c:forEach>
						</c:if>	
						<c:if test="${empty resultList}">
							<h2>此会员尚未进行评估</h2>
						</c:if>	
						</div>
					</div>
				</div><!--个人中心rightbox结束-->
			</div>
		</div><!--中间container结束-->
				
<jsp:include page="../common/footer.jsp"></jsp:include>

	<script data-main="../resource/js/project/main" src="../resource/js/system/require.js"></script>
</body>
</html>
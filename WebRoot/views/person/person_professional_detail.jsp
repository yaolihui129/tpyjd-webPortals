<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <div class="tpy-header">
        <jsp:include page="../common/header.jsp"></jsp:include>
    <div class="container tpy-container person-business">
        <div class="row person-breadline">
            <div class="col-xs-12"><a href="#">首页</a> > <a href="#">个人中心</a> > <a href="#">账户管理</a> > <a href="#">个人信息</a></div>
        </div>
        <div class="row mt-15 mb-15">
            <div class="col-xs-3 person-leftbar mb-20">
                <jsp:include page="../common/lefter.jsp"></jsp:include>
            <div class="col-xs-9 pr-0 business-content-right">
                <!--个人中心rightbox开始-->
                <div class="prson-rightbox">
                    <div class="business-content-img">
                        <img src="../resource/images/business-img_03.jpg">
                    </div>
                    <div class="business-content-name">
                        <h1>曼哈顿广场1号曼哈顿广场1号曼哈顿广场1号曼哈顿广场1号曼哈顿广场1号曼哈顿广场1号</h1>
                        <p><span>分类：投资移民</span><span>国家：北美洲，美国</span></p>
                    </div>
                    <div class="business-content-type">
                        <p><span class="business-content-visa">签证类型：临时居民</span><span class="business-content-period">办理周期：3-6个月</span><span class="business-content-man">申请人：王大力</span></p>
                    </div>
                </div>
                <div class="prson-rightbox mt-10">
                    <div class="business-content-jindu">
                        <h1>办理进度</h1>
                        <div class="jd-head">
                            <i></i>
                            <p><span class="jd-time">签约日期</span><span class="fr text-grey">2016年7月20日</span></p>
                            <p class=" jd-content-text text-grey">负责人：<span>Alice</span></p>
                        </div>
                        <ul class="jd-text">
                            <li>
                                <i></i>
                                <h3>准备材料<span class="fr text-grey">2016年8月20日</span></h3>
                                <p class="jd-content-text text-grey">您已完成准备材料</p>
                            </li>
                            <li>
                                <i></i>
                                <h3>三方费用缴纳<span class="fr text-grey">2016年9月20日</span></h3>
                                <p class="jd-content-text text-grey">您已完成准备材料</p>
                            </li>
                            <li class="doing" style="border-left:1px solid #eaeaea">
                                <i></i>
                                <h3>三方费用缴纳<a href="#" class="jd-right">所需材料</a></h3>
                                <p><span class="text-grey">描述性文字</span></p>
                            </li>
                            <li class="undo" style="border-left:1px solid #eaeaea">
                                <i class="undo-yuan"></i>
                                <h3 class="text-grey">资料审核</h3>
                                <p><span class="text-grey">将您的材料递交移民局</span></p>
                            </li>
                            <li class="undo"></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--个人中心rightbox结束-->
        </div>
    </div>
    <!--footer头部结束-->
    <jsp:include page="../common/footer.jsp"></jsp:include>
    <script data-main="../resource/js/project/main" src="../resource/js/system/require.js"></script>
    </body>
</html>
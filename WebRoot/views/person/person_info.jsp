<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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



	<link rel="stylesheet" type="text/css" href="/resource/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="/resource/css/common.css" type="text/css" />
	<link rel="stylesheet" href="/resource/css/person.css" type="text/css" />
	<link rel="stylesheet" href="/resource/css/layer.css" type="text/css" />
	<link rel="stylesheet" href="/resource/css/laydate.css" type="text/css" />
	<link rel="stylesheet" href="/resource/css/skinlaydate.css" type="text/css" />
	</head>
	<body class="bg-grey">
	
	<jsp:include page="../common/header.jsp"></jsp:include>
	
		<div class="container tpy-container"><!--中间container开始-->
			<div class="row person-breadline"><div class="col-xs-12"><a href="#">首页</a> > <a href="#">个人中心</a> > <a href="#">账户管理</a> > <a href="#">个人信息</a></div></div>
			<div class="row mt-15 mb-15">
				<jsp:include page="../common/lefter.jsp"></jsp:include>
				<div class="col-xs-9 pr-0"><!--个人中心rightbox开始-->
					<div class="prson-rightbox container">
						<div class="row person-row">
							<form action="" id="personInfo" class="form-horizontal" role="form" method="post">
								<div class="form-group">
									<label class="col-xs-2" for="">姓名</label>
									<input class="col-xs-9 js-person-name" id="cname" name="cname" type="text" placeholder="请填写您的姓名" value="${custinfo.name}"/>
									<p class="col-xs-9 person-tips hide">请输入2-10字中文名字！</p>
								</div>
								<div class="form-group">
									<label class="col-xs-2" for="">昵称</label>
									<script type="text/javascript">document.write("<input type='text' id='wxName' name='wxName' class='col-xs-9' placeholder='请填写您的昵称' value='"+decodeURI("${custinfo.wxName}")+"' />")</script>
								</div>
								<div class="form-group">
									<label class="col-xs-2" for="">性别</label>
									<div class="col-xs-9">
										<input id="man" type="radio" name="gender" value="m" <c:if test="${custinfo.gender == 'm' || empty custinfo.gender}">checked='checked'</c:if> /><label for="man">男</label>&nbsp;&nbsp;&nbsp;&nbsp;<input id="woman"  name="gender" type="radio" value="f" <c:if test="${custinfo.gender == 'f'}">checked="checked"</c:if> /><label for="woman">女</label>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-2" for="">邮箱</label>
									<input class="col-xs-9 js-person-email" id="email" name="email" type="text" placeholder="请填写您的邮箱" value="${custinfo.email}"/>
									<p class="col-xs-9 person-tips hide">请输入正确格式邮箱！</p>
								</div>
								<div class="form-group">
									<label class="col-xs-2" for="">备用手机</label>
									<input class="col-xs-9 js-person-tel" type="text" id="contact" name="contact" placeholder="请填写您的备用手机" value="${custinfo.contact}"/>
									<p class="col-xs-9 person-tips hide">请输入正确格式手机号码！</p>
								</div>
								<div class="form-group">
									<label class="col-xs-2" for="">出生年月</label>
									<input class="col-xs-9" id="borntime" type="text" <c:if test="${not empty custinfo.birthday}">value="<fmt:formatDate value="${custinfo.birthday}" type="date" dateStyle="long"/>"</c:if> placeholder="请填写您的出生年月" readonly="readonly" />
								</div>
								<div class="form-group">
									<input id="operation" name="operation" type="hidden" value="${operation}" autocomplete="off"/>
									<input class="col-xs-offset-2 col-xs-1 button-btn js-save-btn" type="button"  value="保存" onClick="tijiao()" />
								</div>
							</form>
						</div>
						
					</div>
				</div><!--个人中心rightbox结束-->
			</div>
		</div><!--中间container结束-->
	<jsp:include page="../common/footer.jsp"></jsp:include>				
	<script data-main="/resource/js/project/main-person" src="/resource/js/system/require.js"></script>
	<script type="text/javascript">
		function tijiao(){
			var flag = true;
			if($(".js-person-name").hasClass("forbid")){
				flag = false;
				return;
			}
			if($(".js-person-email").hasClass("forbid")){
				flag = false;
				return;
			}
			if($(".js-person-tel").hasClass("forbid")){
				flag = false;
				return;
			}
			if(flag === true){
				//放入提交代码
				var name = $("#cname").val();
				var wxName = $("#wxName").val();
				var email = $("#email").val();
				var gender = $("input[name='gender']:checked").val();
				var contact = $("#contact").val();
				var operation = $("#operation").val();
				var birthday = $("#borntime").val();
				if(reclick){
					reclick = false;
					$.post(
							"/person/personInfo",
							{
								"name":name,
								"wxName":wxName,
								"email":email,
								"gender":gender,
								"contact":contact,
								"birthday":birthday,
								"operation":operation	
							},
							function(data){
								if(data.status == 0){
									reclick = true;
									layer.alert("恭喜您提交成功",function(){
										$("#operation").val("");
										window.location.reload();
									});
								}else if(data.status == 2){
									reclick = true;
									layer.alert(data.msg);
								}else{
									reclick = true;
									layer.alert(data.msg);
								}
							}	
					)
				}
			}
		}
	</script>
</body>
</html>
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



<link rel="stylesheet" type="text/css" href="/resource/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resource/css/common.css" type="text/css" />
<link rel="stylesheet" href="/resource/css/person.css" type="text/css" />
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
                        <form action="" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-xs-2" for="">输入原密码</label>
                                <input class="col-xs-9 js-password forbid" id="password" type="text" placeholder="输入当前密码（6-20）" />
                                <p class="col-xs-11 person-tips hide">请输入正确的密码（6-20）</p>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-2" for="">设置新密码</label>
                                <input class="col-xs-9 js-password forbid" id="newPassword" type="text" placeholder="输入新密码（6-20）" />
                                <p class="col-xs-11 person-tips hide">请输入正确的密码（6-20）</p>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-2" for="">确认新密码</label>
                                <input class="col-xs-9 js-password forbid" id="reNewPassword" type="text" placeholder="再次输入新密码（6-20）" />
                                <p class="col-xs-11 person-tips hide">请输入正确的密码（6-20）</p>
                            </div>
                            <div class="form-group">
                           	 	<input id="operation" name="operation" type="hidden" value="${operation}"/>
                                <input class="col-xs-offset-2 col-xs-1 button-btn" id="changePassword" type="button" value="保存" />
                            </div>
                        </form>
                    </div>

                </div>
            </div>
            <!--个人中心rightbox结束-->
        </div>
    </div>
   </div> 
    <!--footer头部结束-->
    </body>
    <jsp:include page="../common/footer.jsp"></jsp:include>
    <script data-main="/resource/js/project/main" src="/resource/js/system/require.js"></script>
    <script src="/resource/js/system/jquery-2.2.0.min.js"></script>
    <script type="text/javascript">
    var reclick = true;
	$("#changePassword").click(function(e) {
		 var flag = true;
		 $(".js-password").each(function(){
			 if($(this).hasClass("forbid")){
					flag = false;
					$(this).next().removeClass("hide");
					return;
				}
		 });
			if(flag === true){
				if(reclick){
					reclick = false;
					var password = $("#password").val();
					var newPassword = $("#newPassword").val();
					var reNewPassword = $("#reNewPassword").val();
					var operation = $("#operation").val();
					if(!password){layer.alert("请输入原密码！"); reclick = true; return false;}
					if(!newPassword){layer.alert("请输入新密码！"); reclick = true; return false;}
					if(!reNewPassword){layer.alert("请确认新密码！");  reclick = true; return false;}
					if(reNewPassword != newPassword){layer.alert("新密码和确认密码不同！"); reclick = true; return false;}
					$.post(
							"/register/changePassword",
							{
								"password":password,
								"newPassword":newPassword,
								"operation":operation
								//"reNewPassword":reNewPassword
							},
							function(data){
								if(data.status == 0){
									reclick = true;
									layer.alert("修改成功！");
								}else{
									reclick = true;
									layer.alert(data.msg);
								}
							}	
					)	
				}
			}
	});
	</script>
</html>
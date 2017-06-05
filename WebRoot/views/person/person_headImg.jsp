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
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/multiple-select.css">
	<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
	<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
	</head>
	<body class="bg-grey">
		<jsp:include page="../common/header.jsp"></jsp:include>

		<div class="container tpy-container"><!--中间container开始-->
			<div class="row person-breadline"><div class="col-xs-12"><a href="#">首页</a> > <a href="#">个人中心</a> > <a href="#">账户管理</a> > <a href="#">用户头像</a></div></div>
			<div class="row mt-15 mb-15">
				<jsp:include page="../common/lefter.jsp"></jsp:include>
				<div class="col-xs-9 pr-0"><!--个人中心rightbox开始-->
					<div class="prson-rightbox container">
						<div class="row person-row">
							<div class="col-xs-4 person-head-show">
								<img id="head_pic" <c:if test="${empty custinfo.headImg}">src="../resource/images/person-change-head.jpg"</c:if><c:if test="${not empty custinfo.headImg}">src="${custinfo.headImg}"</c:if> alt="" />
								<input id="headImg" value="${custinfo.headImg}" type="hidden"/>
							</div>
							<div class="col-xs-7">
								<div class="person-change-text">
									<p class="person-upload-btn">上传头像</p>
									<input id="upload" multiple accept="image/*" type="file" value="上传头像" />
									<p class="mt-10">支持jpg、png、bmp、gif等格式，文件大小不能超过5M</p>
								</div>
							</div>
						</div>
						<div class="row person-change-row">
							<input id="operation" name="operation" type="hidden" value="${operation}"/>
							<input  class="button-btn col-xs-1 col-xs-offset-5" type="button" id="save_img" value="保存" />
						</div>
						
					</div>
				</div><!--个人中心rightbox结束-->
			</div>
		</div><!--中间container结束-->
		<jsp:include page="../common/footer.jsp"></jsp:include>

	<script data-main="../resource/js/project/main" src="../resource/js/system/require.js"></script>
	<script src="/resource/js/system/jquery-2.2.0.min.js"></script>
	<script type="text/javascript">
	//防止多次点击
	var index = 1;
	$('#upload').click(function(){
		if(index >= 2){
			document.getElementById("upload").disabled = true;
		}
		index++;
	});
	//封面图片
	$('#upload').change(function() {
	//	document.getElementById("upload").disabled = true;
		var files = $('#upload').prop('files');
		console.log(files);
		var imgUrl = $("#headImg").val();
		for(var m=0;m<files.length;m++){
			if (!/\.(jpg|png|JPG|PNG|gif|GIF)$/.test(files[m].name)) {  
	            alert("图片类型必须是jpg,png,gif中的一种");
	            document.getElementById("upload").disabled = false;
	            index = 1;
	            return false;  
	        }
			if(files[m].size>5*1024*1024){
				alert("图片大小要小于5M");
				document.getElementById("upload").disabled = false;
				index = 1;
				return false;
			}
		lrz(files[m],{quality :0.3})
		  .then(function (rst) {
			var filename = rst.origin.name;
			$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
				function(data){
					if(data.status==0){
						 $('#head_pic').attr("src",data.picUrl);
						 $('#headImg').val(data.picUrl);
						 layer.alert('上传成功!');
						 index = 1;
						 document.getElementById("upload").disabled = false;
					}
					else {
						 $('#headImg').val('');
						 document.getElementById("upload").disabled = false;
						 index = 1;
						 layer.alert(data.msg);
					}
				});
		  })
		  .always(function () {
			  // 不管是成功失败，都会执行
		  });
		}
	});
	var reclick = true;
	$("#save_img").click(function(e) {
		if(reclick){
			reclick = false;
			var headImg = $("#headImg").val();
			var operation = $("#operation").val();
			$.post(
					"/person/headImg",
					{
						"headImg":headImg,
						"operation":operation	
					},
					function(data){
						if(data.status == 0){
							reclick = true;
							layer.alert("保存成功！",function(){
								window.location.reload();
							});
							
						}else{
							reclick = true;
							layer.alert("保存失败！");
						}
					}	
			)	
		}
	});
	</script>
</body>
</html>
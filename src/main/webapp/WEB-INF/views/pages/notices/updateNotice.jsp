<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The OMG ~~</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link
	href="//code.ionicframework.com/ionicons/1.5.2/css/ionicons.min.css"
	rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link href="/company/resources/css/AdminLTE.css" rel="stylesheet"
	type="text/css" />
</head>
<body class="skin-blue">
	<!-- header logo: style can be found in header.less -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp"></jsp:include>
	<div class="wrapper row-offcanvas row-offcanvas-left">
		<!-- 내용 부분 -->
		<!-- Left side column. contains the logo and sidebar -->
		<!-- 목록 눌럿을때 보이는 부분 -->
		<jsp:include page="/WEB-INF/views/tiles/sidebar.jsp"></jsp:include>
	
	<aside class="right-side">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1><i class="fa fa-bullhorn"></i>공지게시판</h1>
			<ol class="breadcrumb">
				<li><a href="/company/notice/index"><i class="fa fa-dashboard"></i>
						Home</a></li>
				<li class="active">게시글 입력</li>
			</ol>
		</section>
		<form action="updateNotice" method="POST">
			<div id="nboard" style="width: 773px; text-align: left;">
				<h1 style="font-style: oblique; font-weight: bold;">공지사항</h1>
			</div>

			<div align="left">
				<label class="item" style="font-weight: bold;"> 제목:<input
					type="text" name="title" style="width: 800px"
					value="${update.title}">
				</label>
			</div>

			<div>
 				<input type="hidden" name=notice_num value="${update.notice_num}">
				<input type="hidden" name=department_id value="${user.departmentId}"> 
				<b>게시 위치 선택 </b>
				공지<input type="radio" name='checked' value='O'>
				<c:if test="${user.departmentId == 'M'}">
					유지보수<input type="radio" name='checked' value='M' checked>
				</c:if>
				<c:if test="${user.departmentId == 'D'}">
					개발<input type="radio" name='checked' value='D' checked>
				</c:if>
				<c:if test="${user.departmentId == 'R'}">
					<c:if test="${update.checked == 'P'}">
						인사<input id="personnaldept" type="radio" name='checked' value='P' checked>
						영업<input id="salarydept" type="radio" name='checked' value='S'>
						경영<input id="rundept" type="radio" name='checked' value='R'>
					</c:if><c:if test="${update.checked == 'S'}">
						인사<input id="personnaldept" type="radio" name='checked' value='P'>
						영업<input id="salarydept" type="radio" name='checked' value='S' checked>
						경영<input id="rundept" type="radio" name='checked' value='R'>
					</c:if><c:if test="${update.checked == 'R'}">
						인사<input id="personnaldept" type="radio" name='checked' value='P'>
						영업<input id="salarydept" type="radio" name='checked' value='S'>
						경영<input id="rundept" type="radio" name='checked' value='R' checked>
					</c:if>
				</c:if>
				<input type="hidden" value="${user.employeeId}" name=writers>
				<!--user.employeeid를 받아와서 수정못하게함  -->

				<h2>내용</h2>
				<textArea name="content" rows="50" cols="160">${update.content}
        		 </textArea>
				<br> <input type="submit" class='btn btn-default' value="완성">
			</div>
		</form>

	</aside>
</div>

	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"
		type="text/javascript"></script>
</body>
</html>

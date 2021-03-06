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
				<h1>
					<i class="fa fa-bullhorn"></i>공지게시판
				</h1>
				<ol class="breadcrumb">
					<li><a href="/company/dashboard/hello"><i
							class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">공지사항</li>
				</ol>
			</section>
			<section class="content">
				<div class="row">
					<div class="col-xs-8">
						<div class="box" style="font-weight: bold">

							<div class="box-body">
								<table class="table table-bordered">
									<tr>
										<td style="width: 15%; background-color: #efefef;">제목</td>
										<th style="width: 35%">${detail.title}</th>
										<td style="width: 15%; background-color: #efefef;">등록일</td>
										<th style="width: 35%">${detail.credate}</th>
									</tr>
									<tr>
										<td style="width: 15%; background-color: #efefef;">작성자</td>
										<th style="width: 35%">${detail.writerName}</th>
										<td style="width: 15%; background-color: #efefef;">조회수</td>
										<th style="width: 35%">${detail.count}</th>
									</tr>
								</table>


								<br> <br> <br>
								<div>${detail.content }<br> <br> <br> <br>
								</div>






								<div class="box-footer clearfix"></div>
								<c:if test="${user.employeeId==detail.writer }">
									<a
										href="updateNotice?title=${detail.title }&notice_num=${detail.notice_num}&content=${detail.content}"
										class='btn btn-default'>수정</a>
									<a href="deleteNotice?notice_num=${detail.notice_num}"
										class='btn btn-default'>삭제</a>
								</c:if>
								<a href="index" class='btn btn-default'>공지사항으로</a><br> <br>

							</div>
						</div>
					</div>
				</div>

			</section>
		</aside>
	</div>
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- AdminLTE App -->
	<script src="/company/resources/js/AdminLTE/app.js"
		type="text/javascript"></script>
</body>
</html>
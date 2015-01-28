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

<script src="/company/resources/js/jquery-1.11.2.js"></script>
<script>
	$(function() {

		//현재 같은프로젝트하는 동료리스트
		$.ajax({
			url : "colist",
			dataType : "json",
			success : function(json) {
				$("#colist").empty();
				var str = "";
				$.each(json, function(index, item) {

					str += "<tr>";
					str += "<td>" + (index+1)+"</td>";
					str += "<td>" + item.employeeName + "</td>";
					str += "<td>" + item.phone + "</td>";
					str += "<td>" + item.email + "</td>";
					str += "<td>" + item.positionName + "</td>";
					str += "</tr>";

				});
				
				$("#colist").append(str);
			}
		});
		
		
		//현재 투입중인 프로젝트리스트
		$.ajax({

			url : "relist",
			dataType : "json",
			success : function(json) {
				$("#relist").empty();
				var sta = "";
				$.each(json, function(index, item) {

					sta += "<tr>";
					//sta += "<th>" + (index+1) +"</th>";
					sta += "<th>" + item.projectName + "</th>";
					sta += "<th>" + item.techName + "</th>";
					sta += "<td>" + item.startDate + "</td>";
					sta += "<td>" + item.endDate + "<td>";
					sta += "</tr>";

				});
				$("#relist").append(sta);
			},
			error : function() {
				alert("relist 애러다");
			}

		});

		//과거에 했엇던 프로젝트리스트
		$.ajax({
			url : "exlist",
			dataType : "json",
			success : function(json) {
				$("#exlist").empty();
				var str = "";
				$.each(json, function(index, item) {
					//index는 012345씩증가한다 item은 json를 하나씩 저장함
					//json에서 index번째를 item에 저장한다는뜻

					str += "<tr>";
					str += "<td>" + item.projectName + "</td>";
					str += "<td>" + item.techName + "</td>";
					str += "<td>" + item.startDate + "</td>";
					str += "<td>" + item.endDate + "<td>";
					str += "</tr>";

				});
				$("#exlist").append(str);
				//list 아래에 str을 위에서 선언한대로 찍는다

			},
			error : function() {
				alert("exlist 에러이다");
			}

		});


		
		
		
		
		
		
		
	});
</script>
</head>
<body class="skin-blue">
	<!-- header logo: style can be found in header.less -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp"></jsp:include>
	<div class="wrapper row-offcanvas row-offcanvas-left">
		<!-- 내용 부분 -->
		<!-- Left side column. contains the logo and sidebar -->
		<!-- 목록 눌럿을때 보이는 부분 -->
		<jsp:include page="/WEB-INF/views/tiles/sidebar.jsp"></jsp:include>
		<!-- Right side column. Contains the navbar and content of the page -->
		<!-- 내용부분... -->
		<aside class="right-side">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>개발 부서 업무</h1>
				<ol class="breadcrumb">
					<li><a href="/company/notice/index"><i
							class="fa fa-dashboard"></i>Home</a></li>
					<li class="active">개발 부서 업무</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">


				<div class="box box-solid">
					<div class="box-header">
						<h3 class="box-title">Current Project</h3>
					</div>
					<div class="box-body">


						<!-- /.col (LEFT) -->

						<!-- /.row -->
						<div class="table-responsive">
							<table id="gode" class="table table-hover">

								<thead>
									<tr>
										<th>Project명</th>
										<th>관련 기술</th>
										<th>Start day</th>
										<th>End day</th>
									</tr>
								</thead>
								<tbody id="relist">
								</tbody>
							</table>
						</div>


						<!-- /.col (RIGHT) -->

						<!-- /.row -->
					</div>
					<!-- /.box-body -->
					<div class="box-footer clearfix">
						<div class="pull-right"></div>
					</div>
					<!-- box-footer -->
				</div>
				<!-- /.box -->

				<!-- /.col (MAIN) -->

				<!-- MAILBOX END -->
			</section>

			<!-- Main content -->
			<section class="content">


				<div class="box box-solid">
					<div class="box-header">
						<h3 class="box-title">Colleague</h3>
					</div>
					<div class="box-body">
						<div class="row">

							<!-- /.col (LEFT) -->


							<!-- /.row -->
							<div class="table-responsive">
								<table id="gode" class="table table-hover">

									<thead>
										<tr>
											<th> NO.</th>
											<th>Name</th>
											<th>Phone</th>
											<th>Email</th>
											<th>Position</th>
										</tr>
									</thead>
									<tbody id="colist">
									</tbody>
								</table>
							</div>


							<!-- /.col (RIGHT) -->
						</div>
						<!-- /.row -->
					</div>
					<!-- /.box-body -->
					<div class="box-footer clearfix">
						<div class="pull-right"></div>
					</div>
					<!-- box-footer -->
				</div>
			</section>

			<section class="content">
				

					<div class="box box-solid">
						<div class="box-header">
							<h3 class="box-title">My Career</h3>
						</div>
						<div class="box-body">
							<div class="row">

								<!-- /.col (LEFT) -->
								
									
									<!-- /.row -->
									<div class="table-responsive">
										<table id="gode" class="table table-hover">
											<thead>
												<tr>
													<!-- <th>NO.</th> -->
													<th>Project명</th>
													<th>관련 기술</th>
													<th>Start day</th>
													<th>End day</th>
												</tr>
											</thead>

											<tbody id="exlist">
											</tbody>
										</table>
									</div>

								
								<!-- /.col (RIGHT) -->
							</div>
							<!-- /.row -->
						</div>
						<!-- /.box-body -->
						<div class="box-footer clearfix">
							<div class="pull-right"></div>
						</div>
						<!-- box-footer -->
					</div>
					<!-- /.box -->

					<!-- /.col (MAIN) -->
			
				<!-- MAILBOX END -->
			</section>
			<!-- /.content -->
		</aside>
		<!-- /.right-side -->
	</div>
	<!-- ./wrapper -->

	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- AdminLTE App -->
	<script src="/company/resources/js/AdminLTE/app.js"
		type="text/javascript"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="/company/resources/js/AdminLTE/demo.js"
		type="text/javascript"></script>

</body>
</html>
<%-- 질랑형설명필요
<script src="<c:url value='/resources/js/jquery.tmpl.js'/>"></script>
<script id="exerciseTemplate" type="text/x-jquery-tmpl">
   <tr>
      <td>\${exercise_date }</td>
      <td>\${body_name }</td>
      <td>\${exercise_name }</td>
      <td>\${cnt }</td>
      <td>\${set_cnt }</td>
      <td>\${exercise_time }</td>
   </tr>                                    
   </script> --%>
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
/*진행중인 프로젝트와 동료리스트*/
 function procol(){
	$.ajax({
		url : "dPro",
		dataType : "json",
		success : function(json) {
			$("#dPro").empty();
			var str = "";
			if(json != ""){
				$.each(json, function(index, item) {
				str += "<tr>";
				str += "<td>" + "<a id='colleague' projectId=" +item.projectId+">"+ item.projectName+ "</a></td>";
				str += "<td>" + item.techName + "</td>";
				str += "<td>" + item.startDate + "</td>";
				str += "<td>" + item.endDate + "</td>";
				str += "</tr>";
				});
				$("#dPro").append(str);
			}else{
				str+="<tr><td colspan='4' style='color: blue;' align='center'>진행중인 프로젝트가 없습니다.</td></tr>";
				$("#dPro").append(str);
			}
		}
	});

	 
	
} 
	$(function() {
		$("#Current").click(function() {
			procol();
		});
		procol();
		/* 부장 경력 */
		$("#ex").click(function() {
			$.ajax({
				url : "proList",
				dataType : "json",
				success : function(json) {
					$("#proList").empty();
					var str = "";
					if(json != ""){
						$.each(json, function(index, item) {
							str += "<tr>";
							str += "<td>" + item.projectName + "</td>";
							str += "<td>" + item.techName + "</td>";
							str += "<td>" + item.startDate + "</td>";
							str += "<td>" + item.endDate + "</td>";
							str += "</tr>";
						});
						$("#proList").append(str);
					}else{
						str += "<tr><td colspan='6' style='color: blue;' align='center'>개발한 프로젝트가 없습니다.</td></tr>";
						$("#proList").append(str);
					}
				}
			});
			
		});
		
		$("#Proing").click(function() {
			$.ajax({
				url : "proing", /* 부장페이지에서의 현재 진행중인 프로젝트 전체 */
				dataType : "json",
				success : function(json) {
					$("#ProingList").empty();
					var str = "";
					if(json != ""){
						$.each(json, function(index, item) {
							str += "<tr>";
							str += "<td>" + item.projectId + "</td>";
							str += "<td>" + item.projectName + "</td>";
							str += "<td>" + item.startDate + "</td>";
							str += "<td>" + item.endDate + "</td>";
							str += "<td>" + item.teamName + "</td>";
							str += "</tr>";
						});
						$("#ProingList").append(str);
					}else{
						str+="<tr><td colspan='6' style='color: blue;' align='center'>개발부서에서 진행중인 프로젝트가 없습니다.</td></tr>";
						$("#ProingList").append(str);
					}
				}
			});
			
		});
		
		/*부장이 넘겨받은 프로젝트*/
		cpview();
		function cpview() {
			$.ajax({
				url : "startPro",
				dataType : "json",
				success : function(json) {
					$("#startPro").empty();
					var str = "";
					if(json != ""){
						$.each(json,function(index, item) {
							str += "<tr><input type='hidden' name='projectId' value="+item.projectId+"></tr>";
							str += "<tr>";
							str += "<td>" + item.projectName
									+ "</td>";
							str += "<td>" + item.techName
									+ "</td>";
							str += "<td>" + item.startDate
									+ "</td>";
							str += "<td>" + item.endDate
									+ "</td>";
							$.ajax({
								url : "selectTeam",
								dataType : "json",
								async : false,
								success : function(json) {
									str += "<td><select id='selectTeam'  name='selectTeam'>";
									$.each(json,function(index,item) {
										str += "<option value="+item.teamId+">"+ item.teamName+"</option>";
									});
									str += "</select></td>";
								}
							});
							str += "<td><a id='setTeam' class='btn btn-default btn-sm' proId='"+item.projectId+"'>결정</a></td></tr>";
						});
					$("#startPro").append(str);
					}else{
						str+="<tr><td colspan='6' style='color: blue;' align='center'>받은 프로젝트가 없습니다.</td></tr>";
						$("#startPro").append(str);
					}
				}
			});
			
		}
		
		$.ajax({
			url : "start",
			dataType : "json",
			success : function(json) {
				$("#startlist").empty();
				var str = "";
				if(json != ""){
				$.each(json, function(index, item) {	
					str += "<tr>";
					str += "<td>" +"<a id='open' projectId="+item.projectId+">"+ item.projectName + "</td>";
					str += "<td>" + item.techName + "</td>";
					str += "<td>" + item.startDate + "</td>";
					str += "<td>" + item.endDate + "</td>";
					str += "<td>" + "<a id='fk' projectId="+item.projectId+">"
					+ "반환" + "</a>" + "</td>";
					str += "</tr>";	
				});
				$("#startlist").append(str);
			}else{
				str+="<tr><td colspan='5' style='color: blue;' align='center'>부장님에게 받은 프로젝트가 없습니다.</td></tr>";
				$("#startlist").append(str);
			}
		}
		});
		$("#startlist").on("click", "#fk", function() {
			var proId = $(this).attr("projectId");

			$.ajax({
				url : "fk",
				data : "proId=" + proId,
				dataType : "json",
				success : function(json) {

				}
			});

			$(this).attr("href", "index");
		});

		
		$("#detailview").on("click","#setTeam",function(){
			var projectId = $(this).attr("proId");
			var teamId =$(this).parent().parent().find("#selectTeam").val();
			
			$.ajax({
				url:"setTeam",
				data:"projectId="+projectId+"&teamId="+teamId,
				dataType:"txt",
				async:false,
				success : function(txt) {
				}
			});
			cpview();
		});	
	});
</script>

</head>
<body class="skin-blue">
	<!-- header logo: style can be found in header.less -->
	<jsp:include page="/WEB-INF/views/tiles/header.jsp"></jsp:include>
	<div class="wrapper row-offcanvas row-offcanvas-left">
		<jsp:include page="/WEB-INF/views/tiles/sidebar.jsp"></jsp:include>
		<!-- Right side column. Contains the navbar and content of the page -->
		<aside class="right-side">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1><i class="fa fa-th-list"></i>개발 부서 업무</h1>
				<ol class="breadcrumb">
					<li><a href="/company/dashboard/hello"><i class="fa fa-dashboard"></i>Home</a></li>
					<li class="active">개발 부서 업무</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content">
				<c:if test="${user.teamId==null}">
					<!-- 부장 -->
					<div class="mailbox row">
						<div class="col-xs-12">
							<div class="box box-solid">
								<div class="box-body">
									<div class="row">
										<div class="col-md-2 col-sm-4" id="bnt_window">
											<div class="box-header">
												<h3 class="box-title" id="h3"><b>Booked Project</b></h3>
											</div>
											<div style="margin-top: 15px;">
												<a id="Start" class="btn btn-danger btn-flat">Booked Project</a>
											</div>
											<div style="margin-top: 15px;">
												<a id="Proing" class="btn btn-warning btn-flat">Progressing Project</a>
											</div>
											<div style="margin-top: 15px;">
												<a id="ex" class="btn btn-primary btn-flat">My Career</a>
											</div>
										</div>
										<div id="detailview" class="col-md-10 col-sm-8">
											<div class="box-header">
												<h3 class="box-title">Booked Project</h3>
											</div>
											<div class="box-body">
												<!-- /.row -->
												<div class="table-responsive">
													<table class="table table-bordered" border="1">
														<thead>
															<tr>
																<th>Project명</th>
																<th>관련 기술</th>
																<th>Start day</th>
																<th>End day</th>
																<th>Team</th>
																<th>[결정]</th>
															</tr>
														</thead>
														<tbody id="startPro">
															<tr><td colspan="6" style="color: blue;" align="center">개발부서에 할당된 프로젝트가 없습니다.</td></tr>
														</tbody>
													</table>
												</div>
											</div>
											<!-- /.box-body -->
											<div class="box-footer clearfix">
												<div class="pull-right"></div>
											</div>
											<!-- box-footer -->
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<script>				
					$("#bnt_window").on("click","#ex",function() {
						$("#detailview").empty();
						$("#h3").html("<b>My Career</b>");
						var ex = "<div class='box-header'><h3 class='box-title'>My Career</h3></div>"
								+ "<div class='box-body'><div class='table-responsive'>"
								+ "<table class='table table-bordered' border='1'>"
								+ "<thead><tr><th>Project명</th>"
								+ "<th>관련 기술</th><th>Start day</th><th>End day</th>"
								+ "</tr></thead><tbody id='proList'></tbody></table></div></div>";
						$(ex).appendTo($("#detailview"));
					});
					
					

					//current project눌럿을때
					$("#Start").click(function() {
						$(this).attr("href", "index"); /*경로를 나타낼 떄 href를 쓰고 갈 위치를 적을것을 뒤에다쓴다  */
					});

					$("#bnt_window").on("click","#Proing",function() {
						$("#detailview").empty();
						$("#h3").html("<b>Progressing Project</b>");
						var spare = "<div class='box-header'><h3 class='box-title'>Progressing Project</h3></div><div class='box-body'>"
								+ "<div class='table-responsive'><table class='table table-bordered' border='1'>"
								+ "<thead><tr><th>ProId</th><th>ProName</th><th>Start day</th><th>End day</th><th>TEAM_ID</th>"
								+ "</tr></thead><tbody id='ProingList'>"
								+ "</tbody></table></div></div>";
						$(spare).appendTo($("#detailview"));
						
					});
				</script>

				<!-- 일반팀원 -->
				<c:if test="${user.teamId!=null && teamMgr.teamManager!=user.employeeId}">
					<div class="mailbox row">
						<div class="col-xs-12">
							<div class="box box-solid">
								<div class="box-body">
									<div class="row">
										<div class="col-md-2 col-sm-4" id="bnt_window">
											<div class="box-header">
												<h3 class="box-title" id="h3"><b>Current Project</b></h3>
											</div>
											<div style="margin-top: 15px;">
												<a id="Current" class="btn btn-danger btn-flat">Current Project</a>
											</div>
											<div style="margin-top: 15px;">
												<a id="ex" class="btn btn-primary btn-flat">My Career</a>
											</div>
										</div>
										<div id="detailview" class="col-md-10 col-sm-8">
											<div class="box-header">
												<h3 class="box-title">Current project</h3>
											</div>
											<div class="box-body">
												<div class="table-responsive">
													<table class="table table-bordered" border="1">
														<thead>
															<tr>
																<th>Project명</th>
																<th>관련 기술</th>
																<th>Start day</th>
																<th>End day</th>
															</tr>
														</thead>
														<tbody id="dPro">
														</tbody>
													</table>
												</div>
											</div>
											
											<!-- /.box-body -->
											<div class="box-footer clearfix">
												<div class="pull-right"></div>
											</div>
											<!-- box-footer -->
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<script>
					$("#Current").click(function() {
						$(this).attr("href", "index"); /*경로를 나타낼 떄 href를 쓰고 갈 위치를 적을것을 뒤에다쓴다  */
					});
					
				</script>

				<!-- 팀장 -->
				<c:if test="${teamMgr.teamManager==user.employeeId && (teamMgr.teamId=='D01' || teamMgr.teamId=='D02' || teamMgr.teamId=='D03' || teamMgr.teamId=='D04')}">
					<div class="mailbox row">
						<div class="col-xs-12">
							<div class="box box-solid">
								<div class="box-body">
									<div class="row">
										<div class="col-md-2 col-sm-4" id="bnt_window">
											<div class="box-header">
												<h3 class="box-title" id="h3"><b>New Project</b></h3>
											</div>
											<div style="margin-top: 15px;">
												<a id="NewP" class="btn btn-danger btn-flat">New Project</a>
											</div>
											<div style="margin-top: 15px;">
												<a id="Current" class="btn btn-warning btn-flat">Current Project</a>
											</div>
											<div style="margin-top: 15px;">
												<a id="ex" class="btn btn-primary btn-flat">My Career</a>
											</div>
										</div>
										<div id="detailview" class="col-md-10 col-sm-8">
											<div class="box-header">
												<h3 class="box-title">New Project</h3>
											</div>
											<div class="box-body">
												<!-- /.row -->
												<div class="table-responsive">
													<form action="setTeam">
														<table class="table table-bordered" border="1">
															<thead>
																<tr>
																	<th>프로젝트명</th>
																	<th>기술</th>
																	<th>start date</th>
																	<th>end date</th>
																	<th>반려</th>
																</tr>
															</thead>
															<tbody id="startlist">
																<tr><td colspan="5" style="color: blue;" align="center">팀장에게 할당된 프로젝트가 없습니다.</td></tr>
															</tbody>
														</table>
													</form>
												</div>
											</div>
											<!-- /.box-body -->
											<div class="box-footer clearfix">
												<div class="pull-right"></div>
											</div>
											<!-- box-footer -->
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
				<script>
					$("#bnt_window").on("click","#ex",function() {
						$("#detailview").empty();
						$("#h3").html("<b>My Career</b>");
						var ex = "<div class='box-header'><h3 class='box-title'>My Career</h3></div>"
								+ "<div class='box-body'><div class='table-responsive'>"
								+ "<table class='table table-bordered' border='1'>"
								+ "<thead><tr><th>Project명</th>"
								+ "<th>관련 기술</th><th>Start day</th><th>End day</th>"
								+ "</tr></thead><tbody id='proList'></tbody></table></div></div>";
						$(ex).appendTo($("#detailview"));
					});

					$("#NewP").click(function() {
						$(this).attr("href", "index"); /*경로를 나타낼 떄 href를 쓰고 갈 위치를 적을것을 뒤에다쓴다  */
					});

					$("#bnt_window").on("click","#Current",function() {
						$("#detailview").empty();
						$("#h3").html("<b>Current Project</b>");
						var spare = "<div class='box-header'><h3 class='box-title'>Current Project</h3></div><div class='box-body'>"
								+ "<div class='table-responsive'><table class='table table-bordered' border='1'>"
								+ "<thead><tr><th>Project명</th><th>관련 기술</th><th>Start day</th><th>End day</th>"
								+ "</tr></thead><tbody id='dPro'>"
								+ "</tbody></table></div></div>";
						$(spare).appendTo($("#detailview"));
						procol();
					}); 
					
					$("#detailview").on("click","#colleague",function(){
						$("#detailview").empty();
	
						var proId = $(this).attr("projectId");

					
						$("#h3").html("<b>Current list</b>");
						var re = "<div class='box-header'><h3 class='box-title'>Current Project</h3></div>"
								+ "<div class='box-body'><div class='table-responsive'>"
								+ "<table class='table table-bordered' border='1'><thead>"
								+ "<tr><th>Project명</th><th>관련 기술</th><th>Start day</th><th>End day</th>"
								+ "</tr></thead><tbody id='dPro'></tbody></table></div></div>"
								+ "<div class='box-header'><h3 class='box-title'>Colleague</h3></div>"
								+ "<div class='box-body'><div class='table-responsive'>"
								+ "<table class='table table-bordered' border='1'><thead>"
								+ "<tr><th>NO.</th><th>Name</th><th>Phone</th><th>Email</th><th>Position</th>"
								+ "</tr></thead><tbody id='ListColleague'></tbody></table></div></div>";
								$(re).appendTo($("#detailview"));
								
								
					
								//현재 투입중인 프로젝트리스트
								$.ajax({
									url : "dPro",
									dataType : "json",
									success : function(json) {
										$("#dPro").empty();
										var str = "";
										if(json != ""){
										$.each(json, function(index, item) {
											str += "<tr>";
											str += "<td>" + "<a id='colleague' projectId=" +item.projectId+">"+ item.projectName+ "</a></td>";
											str += "<td>" + item.techName + "</td>";
											str += "<td>" + item.startDate + "</td>";
											str += "<td>" + item.endDate + "</td>";
											str += "</tr>";
										
										});
										$("#dPro").append(str);
										}else{
											str+="<tr><td colspan='4' style='color: blue;' align='center'>진행중인 프로젝트가 없습니다.</td></tr>";
											$("#dPro").append(str);
										}
									}
								
								});
								
								
								$.ajax({
									
									url : "ListColleague",
									data:"proId="+proId,
									dataType : "json",
									success : function(json) {
										$("#ListColleague").empty();
										var str = "";
										if(json != ""){
										$.each(json, function(index, item) {
											str += "<tr>";
											str += "<td>" + (index + 1) + "</td>";
											str += "<td>" + item.name + "</td>";
											str += "<td>" + item.phone + "</td>";
											str += "<td>" + item.email + "</td>";
											str += "<td>" + item.positionName + "</td>";
											str += "</tr>";
										});
										//"<a id='open' projectId="+item.projectId+">"
										$("#ListColleague").append(str);
										}else{
											str+="<tr><td colspan='5' style='color: blue;' align='center'>동료가 없습니다.</td></tr>";
											$("#ListColleague").append(str);
										}
									}
								});
							
							});
								
						
					
					$("#startlist").on("click","#open",function(){
						var proId=$(this).attr("projectId");				
			 			$("#detailview").empty();
						$("#h3").html("<b>새 프로젝트</b>");
						var st = "<div class='box-header'><h3 class='box-title'>새 프로젝트</h3></div>"
								+"<div class='box-body'><div class='table-responsive'>"
								+"<table class='table table-bordered' border='1'><thead>"
								+"<tr><th>프로젝트명</th><th>기술</th><th>start date</th><th>end date</th>"
								+"</tr></thead><tbody id='viewlist'>"
								+"</tbody></table></div></div>"
			
								+"<div class='box-header'><h3 class='box-title'>프로젝트에 투입될 인원</h3>"
								+"</div><div class='box-body'><div class='table-responsive'>"
								+"<table class='table table-bordered' border='1'><thead>"
								+"<tr><th>NO.</th><th>Name</th><th>Phone</th><th>Email</th>"
								+"<th>Position</th><th>제거</th></tr></thead><tbody id='putlist'>"
								+"</tbody></table></div></div>"

								+"<div class='box-header'><h3 class='box-title'>팀원 리스트</h3>"
								+"</div><div class='box-body'><div class='table-responsive'>"
								+"<table class='table table-bordered' border='1'>"
								+"<thead><tr><th>NO.</th><th>Name</th><th>Phone</th>"
								+"<th>Email</th><th>Position</th><th>추가</th></tr>"
								+"</thead><tbody id='sparelist'></tbody></table>"
								+"</div></div>";

						$(st).appendTo($("#detailview"));

						$.ajax({
							url :"view",
							data:"proId="+proId,
							dataType:"json",
							success :function(json) {
								$("#viewlist").empty();
								var str = "";
								$.each(json, function(index, item) {
									str += "<tr><td>" + item.projectName + "</td>";
									str += "<td>" + item.techName + "</td>";
									str += "<td>" + item.startDate + "</td>";
									str += "<td>" + item.endDate + "</td></tr>";
								});
								$("#viewlist").append(str);
							}
						});

						$.ajax({
							url :"put",
							dataType :"json",
							data:"projectId="+proId,  //"projectId"에는 컨트롤러에 들어갈이름 ajax에는 뒤에꺼 proId
							success : function(json) {
								$("#putlist").empty();
								var str = "";
								if(json != ""){
								$.each(json, function(index, item) {
									str += "<tr><td>" + (index + 1) + "</td>";
									str += "<td>" + item.name + "</td>";
									str += "<td>" + item.phone + "</td>";
									if(item.email != null){
										str += "<td>" + item.email + "</td>";
										}else{
										str += "<td>-</td>";
										}
									str += "<td>" + item.positionName + "</td>";
									str += "<td><a id='delete' class='btn btn-default btn-sm' empId='"+item.employeeId+"' proId ='"+proId+"'>제거</a></td></tr>";
								});
								$("#putlist").append(str);
							}else{
								str+="<tr><td colspan='6' style='color: blue;' align='center'>프로젝트에 투입된 인원이 없습니다.</td></tr>";
								$("#putlist").append(str);
								}
							}
						});
						
						//spare 리스트부분 ajax
						$.ajax({
							url : "spare",
							data:"proId="+proId,
							dataType : "json",
							success : function(json) {
								$("#sparelist").empty();
								var str = "";
								$.each(json, function(index, item) {
									str += "<tr>";
									str += "<td>" + (index + 1) + "</td>";
									str += "<td>" + item.name + "</td>";
									str += "<td>" + item.phone + "</td>";
									if(item.email != null){
										str += "<td>" + item.email + "</td>";
										}else{
											str += "<td>-</td>";
										}
										if(item.positionName != null){
										str += "<td>" + item.positionName + "</td>";
										}else{
											str += "<td>-</td>";
										}
										
									/* str += "<td>" + "<input type='hidden' value='"+item.employeeId+"' name='empId'><input type='hidden' value='"+proId+"' name='proId'>" +"</td>"; */
									str += "<td><a id='setpeople' class='btn btn-default btn-sm' empId='"+item.employeeId+"' proId ='"+proId+"'>결정</a></td></tr>";
								});
								$("#sparelist").append(str);
							}
						});
							
						//잉여리스트에서 추가 눌렀을때
						$("#detailview").on("click","#setpeople",function(){
							var empId = $(this).attr("empId");
							var proId = $(this).attr("proId");
			
							$.ajax({
								url:"setpeople",
								data:"empId="+empId+"&proId="+proId,
								dataType:"json",
								async:false,
								success : function(json) {
									
								}										
							});

							$("#detailview").empty();
							$("#h3").html("<b>새 프로젝트</b>");
							var st = "<div class='box-header'><h3 class='box-title'>새 프로젝트</h3></div>"
									+"<div class='box-body'><div class='table-responsive'>"
									+"<table class='table table-bordered' border='1'><thead>"
									+"<tr><th>프로젝트명</th><th>기술</th><th>start date</th><th>end date</th>"
									+"</tr></thead><tbody id='viewlist'>"
									+"</tbody></table></div></div>"
									
									+"<div class='box-header'><h3 class='box-title'>프로젝트에투입될인원</h3>"
									+"</div><div class='box-body'><div class='table-responsive'>"
									+"<table class='table table-bordered' border='1'><thead>"
									+"<tr><th>NO.</th><th>Name</th><th>Phone</th><th>Email</th>"
									+"<th>Position</th><th>제거</th></tr></thead><tbody id='putlist'>"
									+"</tbody></table></div></div>"
	
									+"<div class='box-header'><h3 class='box-title'>팀원 리스트</h3>"
									+"</div><div class='box-body'><div class='table-responsive'>"
									+"<table class='table table-bordered' border='1'>"
									+"<thead><tr><th>NO.</th><th>Name</th><th>Phone</th>"
									+"<th>Email</th><th>Position</th><th>추가</th></tr>"
									+"</thead><tbody id='sparelist'></tbody></table>"
									+"</div></div>";

							$(st).appendTo($("#detailview"));
											
							$.ajax({
								url :"view",
								data:"proId="+proId,
								dataType:"json",
								success :function(json) {
									$("#viewlist").empty();
									var str = "";
									$.each(json, function(index, item) {
										str += "<tr><td>" + item.projectName + "</td>";
										str += "<td>" + item.techName + "</td>";
										str += "<td>" + item.startDate + "</td>";
										str += "<td>" + item.endDate + "</td></tr>";
									});
									$("#viewlist").append(str);
								}
							});	
											
							$.ajax({
								url :"put",
								dataType :"json",
								data:"projectId="+proId,  //"projectId"에는 컨트롤러에 들어갈이름 ajax에는 뒤에꺼 proId
								success : function(json) {
									$("#putlist").empty();
									var str = "";
									if(json != ""){
									$.each(json, function(index, item) {
										str += "<tr><td>" + (index + 1) + "</td>";
										str += "<td>" + item.name + "</td>";
										str += "<td>" + item.phone + "</td>";
										if(item.email != null){
										str += "<td>" + item.email + "</td>";
										}else{
										str += "<td>-</td>";
										}
										str += "<td>" + item.positionName + "</td>";
										str += "<td><a id='delete' class='btn btn-default btn-sm' empId='"+item.employeeId+"' proId ='"+proId+"'>제거</a></td></tr>";
									});
									$("#putlist").append(str);
									}else{
										str+="<tr><td colspan='6' style='color: blue;' align='center'>프로젝트에 투입된 인원이 없습니다.</td></tr>";
										$("#putlist").append(str);
									}
								}
							});
						
							//spare 리스트부분 ajax
							$.ajax({
								url : "spare",
								data:"proId="+proId,
								dataType : "json",			
								success : function(json) {
									$("#sparelist").empty();
									var str = "";
									$.each(json, function(index, item) {
										str += "<tr><td>" + (index + 1) + "</td>";
										str += "<td>" + item.name + "</td>";
										str += "<td>" + item.phone + "</td>";
										if(item.email != null){
										str += "<td>" + item.email + "</td>";
										}else{
											str += "<td>-</td>";
										}
										if(item.positionName != null){
										str += "<td>" + item.positionName + "</td>";
										}else{
											str += "<td>-</td>";
										}
										
										/* str += "<td>" + "<input type='hidden' value='"+item.employeeId+"' name='empId'><input type='hidden' value='"+proId+"' name='proId'>" +"</td>"; */
										str += "<td><a id='setpeople' class='btn btn-default btn-sm' empId='"+item.employeeId+"' proId ='"+proId+"'>결정</a></td></tr>";
									});
									$("#sparelist").append(str);
								}
							});
						});

						//프로젝트 투입인원리스트에서 제거 눌럿을때
						$("#detailview").on("click","#delete",function(){
							var empId = $(this).attr("empId");
							var proId = $(this).attr("proId");								
							$.ajax({
								url:"delete",
								data:"empId="+empId+"&proId="+proId,
								dataType:"json",
								success:function(json){
							
								}	
							});
							$("#detailview").empty();
							$("#h3").html("<b>새 프로젝트</b>");
							var st = "<div class='box-header'><h3 class='box-title'>새 프로젝트</h3></div>"
									+"<div class='box-body'><div class='table-responsive'>"
									+"<table class='table table-bordered' border='1'><thead>"
									+"<tr><th>프로젝트명</th><th>기술</th><th>start date</th><th>end date</th>"
									+"</tr></thead><tbody id='viewlist'>"
									+"</tbody></table></div></div>"
										
									+"<div class='box-header'><h3 class='box-title'>프로젝트에투입될인원</h3>"
									+"</div><div class='box-body'><div class='table-responsive'>"
									+"<table class='table table-bordered' border='1'><thead>"
									+"<tr><th>NO.</th><th>Name</th><th>Phone</th><th>Email</th>"
									+"<th>Position</th><th>제거</th></tr></thead><tbody id='putlist'>"
									+"</tbody></table></div></div>"

									+"<div class='box-header'><h3 class='box-title'>팀원 리스트</h3>"
									+"</div><div class='box-body'><div class='table-responsive'>"
									+"<table class='table table-bordered' border='1'>"
									+"<thead><tr><th>NO.</th><th>Name</th><th>Phone</th>"
									+"<th>Email</th><th>Position</th><th>추가</th></tr>"
									+"</thead><tbody id='sparelist'></tbody></table>"
									+"</div></div>";

									$(st).appendTo($("#detailview"));
									
							$.ajax({
								url :"view",
								data:"proId="+proId,
								dataType:"json",
								success :function(json) {
									$("#viewlist").empty();
									var str = "";
									$.each(json, function(index, item) {
										str += "<tr><td>" + item.projectName + "</td>";
										str += "<td>" + item.techName + "</td>";
										str += "<td>" + item.startDate + "</td>";
										str += "<td>" + item.endDate + "</td></tr>";
									});
									$("#viewlist").append(str);
								}
							});

							$.ajax({
								url :"put",
								dataType :"json",
								data:"projectId="+proId,  //"projectId"에는 컨트롤러에 들어갈이름 ajax에는 뒤에꺼 proId
								success : function(json) {
									$("#putlist").empty();
									var str = "";							
									if(json != ""){
										$.each(json, function(index, item) {									
											str += "<tr><td>" + (index + 1) + "</td>";
											str += "<td>" + item.name + "</td>";
											str += "<td>" + item.phone + "</td>";
											if(item.email != null){
												str += "<td>" + item.email + "</td>";
												}else{
												str += "<td>-</td>";
												}
											str += "<td>" + item.positionName + "</td>";
											str += "<td><a id='delete' class='btn btn-default btn-sm' empId='"+item.employeeId+"' proId ='"+proId+"'>제거</a></td></tr>";
										});
									$("#putlist").append(str);
									}else{
										str+="<tr><td colspan='6' style='color: blue;' align='center'>프로젝트에 투입된 인원이 없습니다.</td></tr>";
										$("#putlist").append(str);
									}
								}
							});
							
							//spare 리스트부분 ajax
							$.ajax({
								url : "spare",
								data:"proId="+proId,
								dataType : "json",
								success : function(json) {
									$("#sparelist").empty();
									var str = "";
									$.each(json, function(index, item) {
										str += "<tr><td>" + (index + 1) + "</td>";
										str += "<td>" + item.name + "</td>";
										str += "<td>" + item.phone + "</td>";
										if(item.email != null){
											str += "<td>" + item.email + "</td>";
											}else{
												str += "<td>-</td>";
											}
											if(item.positionName != null){
											str += "<td>" + item.positionName + "</td>";
											}else{
												str += "<td>-</td>";
											}
											
										str += "<td><a id='setpeople' class='btn btn-default btn-sm' empId='"+item.employeeId+"' proId ='"+proId+"'>결정</a></td></tr>";
									});
									$("#sparelist").append(str);
								}
							});
						});	
					});
				</script>
			</section>
		</aside>
	</div>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- AdminLTE App -->
	<script src="/company/resources/js/AdminLTE/app.js" type="text/javascript"></script>
</body>
</html>
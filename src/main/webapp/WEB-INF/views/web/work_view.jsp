<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.setAttribute("bUrl", "worker_view"); 
String member = (String)session.getAttribute("member");
if(!(session.getAttribute("member").equals("master"))) {%>
	<jsp:forward page="/LoginForm" />
<%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap core CSS -->
<link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
<link href="https://getbootstrap.com/docs/4.1/examples/blog/blog.css" rel="stylesheet">

 <script src="http://code.jquery.com/jquery.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 

<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<title>JibaeIn 지하철 택배</title>
</head>
<style>
	table{
		width:80%;
		height: 300px;
		margin:auto;

	}
	table tr th{
		text-align:center;
	}
</style>
<script>
	$(function() {
	    $( "#testDatepicker" ).datepicker({
	         changeMonth: true, 
	         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         showButtonPanel: true, 
		     closeText: '닫기', 
	         dateFormat: "yymmdd",
	         showOn: "both", 
	         buttonImage: "./picture/calendar.png", 
	         buttonImageOnly: true,
	         
	         onClose: function( selectedDate ) {
                 // 시작일(fromDate) datepicker가 닫힐때
                 // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                 $("#testDatepicker2").datepicker( "option", "minDate", selectedDate );
             }
	  });
	});
	$(function() {
	    $( "#testDatepicker2" ).datepicker({
	         changeMonth: true, 
	         dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
	         dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
	         monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
	         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	         showButtonPanel: true,
		     closeText: '닫기', 
	         dateFormat: "yymmdd",
	         showOn: "both", 
	         buttonImage: "./picture/calendar.png", 
	         buttonImageOnly: true,
	         
	         onClose: function( selectedDate ) {
                 // 종료일(toDate) datepicker가 닫힐때
                 // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정
                 $("#testDatepicker").datepicker( "option", "maxDate", selectedDate );
          }
	  });
	});
</script>
<script>
	function workCount(){
		var testDatepicker = document.getElementById("testDatepicker").value;
		var testDatepicker2 = document.getElementById("testDatepicker2").value;
		var totalCount = document.getElementById("totalCount");
		var wk_Id = document.getElementById("wk_Id").value;

		$.ajax({
			url:'./totalCount',
			type: 'POST',
			data : {wk_Id:wk_Id, testDatepicker:testDatepicker, testDatepicker2:testDatepicker2},
			dataType:'json',
			success : function(json){
				var results = eval(json);
				if(results.result=="ok"){
					totalCount.innerHTML = results.desc;
				}
				else{
					alert(results.desc);
				}
			}			
		});	
		
	}
	
	function masterList(){
		var wk_Id = document.getElementById("wk_Id").value;
		document.location.href="tracking?wk_Id="+wk_Id;
	}
	
	function deleteInfo(){
		var wk_Id = document.getElementById("wk_Id");
		var check = confirm("정말 삭제하시겠습니까?");
		if(check == true){
			document.location.href="deleteWorker2?wk_Id="+wk_Id.value;
		}
		
	}
	
	function ModifyInfo(){
		var wk_Id = document.getElementById("wk_Id");
		document.location.href="workerModify?wk_Id="+wk_Id.value;
	}
</script>
<script>  
	function openChatt(){  
	    window.open("http://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/chatt", "관리자 대화방", "width=1200, height=850, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}  
 
</script>
 <script type="text/javascript">
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
    	var wk_Id = document.getElementById("wk_Id");
    	var threeMonth;
    	var twoMonth;
    	var oneMonth;
    	var nowMonth;
    	
    	var threeCount;
    	var twoCount;
    	var oneCount;
    	var nowCount;
    	
    	$.ajax({
			url:'./chart',
			type: 'POST',
			data : {wk_Id:wk_Id.value},
			dataType:'json',
			success : function(json){
				var results = eval(json);
				if(results.result=="ok"){
					threeMonth = results.three;
					twoMonth = results.two;
					oneMonth = results.one;
					nowMonth = results.now;
					
					threeCount = results.threeCount;
					twoCount = results.twoCount;
					oneCount = results.oneCount;
					nowCount = results.nowCount;
				
				
					var data = google.visualization.arrayToDataTable([
					       ["Element", "Density", { role: "style" } ],
					       [threeMonth+"월", threeCount, "#b87333"],
					       [twoMonth+"월", twoCount, "silver"],
					       [oneMonth+"월", oneCount, "gold"],
					       [nowMonth+"월", nowCount, "red"]
					    ]);

					var view = new google.visualization.DataView(data);
					view.setColumns([0, 1,
					                { calc: "stringify",
					                  sourceColumn: 1,
					                  type: "string",
					                  role: "annotation" },
					                2]);

					var options = {
					title: "최근 3개월 전까지 볼 수 있습니다.",
					width: 780,
					height: 600,
					bar: {groupWidth: "70%"},
					legend: { position: "none" },
					};
					var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
					chart.draw(view, options);
				
				}
				else{
						
				}
			}			
		});
    	
     
  }
  </script>

<body class="bg-light">
<div class="container">
	<header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
          <div class="col-4 pt-1">
          	<button type="button" onclick="javascript:window.location='addWorkerWrite'" class="btn btn-primary">신입 기사 추가</button> 
			&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-danger" id="delete" name="delete" onclick="deleteWorker()">삭제</button>
          </div>
          <div class="col-4 text-center">
            <a class="blog-header-logo text-dark" href="main">JibaeIn 지하철 택배</a>
          </div>
          <div class="col-4 d-flex justify-content-end align-items-center">
          <%if(member == null) {%>
          	      
            <a class="btn btn-sm btn-outline-secondary" href="JoinForm">회원가입</a> &nbsp;
            <a class="btn btn-sm btn-outline-secondary" href="LoginForm">로그인</a>       
         <%} else { %>
         	<%=session.getAttribute("id") %>님 안녕하세요! &nbsp;&nbsp;
         	
         	<%if(member.equals("google")){ %>
         	<script>
				function signOut() {
				    var auth2 = gapi.auth2.getAuthInstance();
				    auth2.signOut().then(function () {
				    	console.log('User signed out.');
				    	document.location.href="logout.do"
				    });
				}
				function onLoad() {
					gapi.load('auth2', function(){
						gapi.auth2.init();
					});
				}
			</script>
         	 <a href="#" onclick = "signOut();"class="badge badge-primary">로그아웃</a>
         	 <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
         	 
      		 <%} else if(member.equals("customer") || member.equals("worker") || member.equals("master")) { %>
         	<a href = "logout.do" class="badge badge-primary">로그아웃</a>
         	<%} %>
         <%} %>
          </div>
	      <div class="col-4 text-center">
	        
	      </div>
        </div>
     </header>
     	<div class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-4 pt-1">
          		
          	</div>
       		<div class="col-4 text-center">
            	<a class="blog-header-logo text-dark" href="workerList">기사 정보</a>
        	</div>
        	<div class="col-4 d-flex justify-content-end align-items-center">
        	</div>
       </div>
		<br />
        <nav class="nav justify-content-center" >  
        <%if(member == null || member.equals("customer") || member.equals("worker")){ %>
		 <button type="button" class="btn btn-outline-secondary btn-lg" onclick="javascript:window.location='notice'" aria-haspopup="true" aria-expanded="false">
		   공지사항
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%} else if(member.equals("master")){ %>
		<div class="btn-group">
        <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   공지사항
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="dropdown-menu">
		   <a class="dropdown-item" href="notice?bCheck=2">회원 공지사항</a>
		   <a class="dropdown-item" href="notice?bCheck=3">기사 공지사항</a>
		</div>
		</div>
		<%} %>
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   회사 소개
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="greeting">인사말</a>
		    <a class="dropdown-item" href="comeLoad">찾아오시는길</a>
		  </div>
		</div> 
		<button type="button" class="btn btn-outline-secondary btn-lg"  onclick="javascript:window.location='pay_info'" aria-haspopup="true" aria-expanded="false">
		   요금표
		</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%if(member == null || member.equals("customer")){%>
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		 	배송
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="deliveryRequest">배송 신청</a>
		    <a class="dropdown-item" href="tracking">배송 조회</a>
		  </div>
		</div>
		<%} else if(member.equals("worker") || member.equals("master")) {%>
		 <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true"  onclick="javascript:window.location='tracking'" aria-expanded="false">
		   배송 조회
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%} %>
        <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true"  onclick="javascript:window.location='QandA'" aria-expanded="false">
		   고객의 소리
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%if(member == null || member.equals("customer") || member.equals("worker")){ %>
		 <button type="button" class="btn btn-outline-secondary btn-lg" onclick="javascript:window.location='ModifyForm'" aria-haspopup="true" aria-expanded="false">
		   내 정보
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%} else if(member.equals("master")){ %>
		<div class="btn-group">
        <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   관리자
		 </button> 
		<div class="dropdown-menu">
		   <a class="dropdown-item" href="workerList">기사 정보</a>
		   <a class="dropdown-item" href="#" onclick="openChatt()">대화방</a>
		   <a class="dropdown-item" href="tracking">전체 배송 조회</a>
		   <a class="dropdown-item" href="map">현재 기사 위치 조회</a>
		</div>
		</div>
		<%} %>
        </nav>
        <br />
        <table class="table table-bordered">
        	<tr>
				<th colspan="2">
					<img src="resources/upload/${content_view.wk_Picture }" width="300" height="300"/><br>					
				</th>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				이름
				</nav>
				</th>
				<td>${content_view.wk_Name}</td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				아이디
				</nav>
				</th>
				<td><input type="hidden" id="wk_Id" value="${content_view.wk_Id}"> ${content_view.wk_Id}</td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				전화번호
				</nav>
				</th>
				<td>${content_view.wk_Phone}</td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				현재 상태
				</nav>
				</th>
				<td>
					<c:if test="${content_view.wk_Mode == 0}">
						배송모드(대기 중)
					</c:if>
					<c:if test="${content_view.wk_Mode == 1}">
						배송모드(배송 중)
					</c:if>
					<c:if test="${content_view.wk_Mode == 2}">
						휴식 중
					</c:if>
					<c:if test="${content_view.wk_Mode == 3}">
						퇴근 중
					</c:if>
				</td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				패널티
				</nav>
				</th>
				<td>${content_view.wk_Penalty}</td>
			</tr>
			<tr>
				<th class="table-light" colspan="2">
					<input type="text" id="testDatepicker" name="testDatepicker" value="${testDatepicker }">
						~ 
					<input type="text" id="testDatepicker2" name="testDatepicker2" value="${testDatepicker2 }">
					&nbsp;&nbsp;&nbsp; <button type="button" class="btn btn-outline-success" id="search" name="search" onclick="workCount()" class="btn btn-outline-dark">총 배송 수 조회 </button>
					&nbsp;&nbsp;&nbsp; <button class="btn btn-outline-primary" type="button" onclick="masterList()">배송 조회</button>
					&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-outline-warning" data-toggle="modal" data-target="#startModal">월별 배송 조회 차트</button>

					<div class="modal fade bd-example-modal-lg" id="startModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					 <div class="modal-dialog modal-lg" role="document">
					    <div class="modal-content" style="width:800px;height:700px">
					    	
					      	<div class="modal-header" style="width:800px">
					        	<h3 class="modal-title" id="exampleModalLabel">월별 배송 조회 차트</h3>

					        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          		<span aria-hidden="true">&times;</span>
					        	</button>
					      	</div>
					      	
					      	<div class="modal-body">
					      	<form>
					      		<div id="columnchart_values" style="width: 300px; height: 300px;"></div>
							</form>
					      	</div>
					      	<div class="modal-footer">
					        	<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
					        	
					      	</div>
					    </div>
					 </div>
				</div>
				</th>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				총 횟수
				</nav>
				</th>
				<td><div id="totalCount"></div></td>
			</tr>

			<tr>
				<th class="table-light" colspan="2">
					<button class="btn btn-outline-success" id="modify" type="button" onclick="ModifyInfo()">정보 수정</button> &nbsp;&nbsp;&nbsp;
					<button class="btn btn-outline-danger" id="deleteWorker" type="button" onclick="deleteInfo()">삭제</button>
					
				</th>
			</tr>
        </table>
        <hr class="mb-4">
            	<button class="btn btn-outline-primary btn-lg btn-block" type="button" onclick="javascript:window.location='workerList'">목록보기</button>
    	<footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; JibaeIn 지하철 택배</p>
      </footer>
    </div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
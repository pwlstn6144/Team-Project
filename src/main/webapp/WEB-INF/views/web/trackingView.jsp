<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.setAttribute("bUrl", "tracking"); 
String member = (String)session.getAttribute("member");
if(session.getAttribute("id") == null) {%>
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
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
 <script src="http://code.jquery.com/jquery.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 
<script>  
	function openChatt(){  
	    window.open("http://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/chatt", "관리자 대화방", "width=1200, height=850, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}  
 
</script>
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
	function cancel(){
		var check = confirm("배송요청을 취소하시겠습니까?");
		var orderid = document.getElementById("cst_orderid");
		if(check == true){
			document.location.href="revoke?cst_orderid="+orderid.value;
		}
	}
</script>
<title>JibaeIn 지하철 택배</title>
</head>
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
            	<a class="blog-header-logo text-dark" href="tracking">배송 조회</a>
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
		<c:if test="${picture.wk_Id ne null }">
		<tr>
			<th colspan="2"><img src="resources/upload/${picture.wk_Picture}" width="300" height="300" /></th>
		</tr>	
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			기사님 성함
			</nav>
			</th>
			<td>${picture.wk_Name}</td>
		</tr>	
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			기사님 전화번호
			</nav>
			</th>
			<td>${picture.wk_Phone}</td>
		</tr>
		</c:if>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			번호
			</nav>
			</th>
			<td><input type="hidden" id="cst_orderid" value="${order.cst_orderid}">${order.cst_orderid}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			보내는 분(성함)
			</nav>
			</th>
			<td><input type="hidden" name="cst_Name" id="cstName" value="${order.cst_Name}">${order.cst_Name}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			보내는 분(전화번호)
			</nav>
			</th>
			<td><input type="hidden" name="cst_Phone" id="cstPhone" value="${order.cst_Phone}">${order.cst_Phone}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			출발지
			</nav>
			</th>
			<td><input type="hidden" name="start_Zip" id="startZip" value="${order.start_Zip}">${order.start_Zip}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			받는 분(성함)
			</nav>
			</th>
			<td><input type="hidden" name="arrive_Name" id="arriveName" value="${order.arrive_Name}">${order.arrive_Name}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			받는 분(전화번호)
			</nav>
			</th>
			<td><input type="hidden" name="arrive_Phone" id="arrivePhone" value="${order.arrive_Phone}">${order.arrive_Phone}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			도착지
			</nav>
			</th>
			<td><input type="hidden" name="end_Zip" id="endZip" value="${order.end_Zip}">${order.end_Zip}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			물품 종류
			</nav>
			</th>
			<td>
				<input type="hidden" name="orderkinds" id="orderKinds" value="${order.orderkinds}">
				<c:if test="${order.orderkinds == 1 }">			
				간단(1kg)
				</c:if>
				<c:if test="${order.orderkinds == 2 }">
				서류(2kg)
				</c:if>
				<c:if test="${order.orderkinds == 3 }">
				박스(5kg)
				</c:if>
			</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			방향
			</nav>
			</th>
			<td> 
				<input type="hidden" name="direction" id="Direction" value="${order.direction}">
				<c:if test="${order.direction == 1 }">
				편도
				</c:if>
				<c:if test="${order.direction == 2 }">
				왕복
				</c:if>
			</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			요금
			</nav>
			</th>
			<td>
				<input type="hidden" name="orderPrices" id="orderprices" value="${order.orderPrices}">
				${order.orderPrices}원
			</td>
		<tr>
			<input type="hidden" name="payment_info" id="paymentInfo" value="${order.payment_info}">
			<th class="table-success">
			<nav class="nav justify-content-center" >
			요금 지불 방식
			</nav>
			</th>
			<td>
				<c:if test="${order.payment_info == 1 }">
				선불
				</c:if>
				<c:if test="${order.payment_info == 2 }">
				후불
				</c:if>
				<c:if test="${order.payment_info == 3 }">
				포인트
				</c:if>
			</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			주문 날짜
			</nav>
			</th>
			<td>${order.orderDate}</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			배송 완료 날짜
			</nav>
			</th>
			<td>${order.finished_DeliveryTime }</td>
		</tr>	
 		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			요청사항
			</nav>
			</th>
			<td> 
				<input type="hidden" name="bContent" id="Bcontent" value="${order.bContent}">
				${order.bContent}
			</td>
		</tr>
		<tr>
			<th class="table-success">
			<nav class="nav justify-content-center" >
			현재 상태
			</nav>
			</th>
			<td>
				<c:if test="${order.orderMode == 0 }">
				배송 대기 &nbsp;&nbsp;&nbsp; <button class="btn btn-outline-danger" id="cancel" type="button" onclick="cancel()">배송 취소</button>
				</c:if>
				<c:if test="${order.orderMode == 1 }">
				배송 중
				</c:if>
				<c:if test="${order.orderMode == 2 }">
				배송 완료
				</c:if>
				<c:if test="${order.orderMode == 3 }">
				배송 취소
				</c:if>
			</td>
		</tr>
	</table>
	<footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; JibaeIn 지하철 택배</p>
      </footer>
</div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
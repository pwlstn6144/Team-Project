<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.setAttribute("bUrl", "deliveryRequest"); 
String member = (String)session.getAttribute("member");
if(session.getAttribute("id") == null) {%>
	<jsp:forward page="/LoginForm" />
<%} %>
<%String id = (String)session.getAttribute("id");%>
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
<title>JibaeIn 지하철 택배</title>
 <script src="http://code.jquery.com/jquery.js"></script>

<!-- Firebase App is always required and must be first -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-app.js"></script>

<!-- Add additional services that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-messaging.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-functions.js"></script>

<!-- Comment out (or don't include) services that you don't want to use -->
<!-- <script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-storage.js"></script> -->



<script>
 // Initialize Firebase
 var config = {
   apiKey: "AIzaSyCxNls_B1-81Xm8uU5i9I69ht7gT6Hg1C4",
   authDomain: "teamproject-91feb.firebaseapp.com",
   databaseURL: "https://teamproject-91feb.firebaseio.com",
   projectId: "teamproject-91feb",
   storageBucket: "teamproject-91feb.appspot.com",
   messagingSenderId: "590223549372"
 };
 firebase.initializeApp(config);
</script>
<script>  
	function openChatt(){  
	    window.open("http://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/chatt", "관리자 대화방", "width=1200, height=850, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}  
 
</script>
<script>
  // Initialize Firebase
  
  var databaseRef = firebase.database().ref("users/"); 
  
  function formCheck(){
	  var cst_Id = document.getElementById("cstId").value;
	  var cst_Name = document.getElementById("cstName").value;
	  var cst_Phone = document.getElementById("cstPhone").value;
	  var start_Zip = document.getElementById("startZip").value;
	  var arrive_Name = document.getElementById("arriveName").value;
	  var arrive_Phone = document.getElementById("arrivePhone").value;
	  var end_Zip = document.getElementById("endZip").value;
	  var orderkinds = document.getElementById("orderKinds").value;
	  var direction = document.getElementById("Direction").value;
	  var orderPrices = document.getElementById("orderprices").value;
	  var payment_info = document.getElementsByName("payment_info");
	  var paymentInfo;
	  var bContent = document.getElementById("Bcontent").value;
	  var start_Lat = document.getElementById("start_Lat");
	  var start_Lon = document.getElementById("start_Lon");
	  var arrive_Lat = document.getElementById("arrive_Lat");
	  var arrive_Lon = document.getElementById("arrive_Lon");

	  if(bContent == null){
		  bContent = "입력된 내용이 없습니다."
	  }

	  for(var i = 0; i < payment_info.length; i++){
		  if(payment_info[i].checked == true){
			  paymentInfo = payment_info[i].value;
		  }
	  }
	  var nowTime = getTimeStamp();

	  var request_number = "w" + nowTime + cst_Id;
	  var uid = firebase.database().ref().child("delivery").child("deliveryMain").push().key;
	 
	  var data = {
		  endAddress: end_Zip,
		  endName: arrive_Name,
		  endPhone: arrive_Phone,
		  kinds: orderkinds,
		  prices: orderPrices,
		  startAddress: start_Zip,
		  startName: cst_Name,
		  startPhone: cst_Phone,
		  requestMessage: bContent,
		  time: nowTime,
		  ordermode: 0,
		  direction: direction,
		  payment_info: paymentInfo,
		  request_number: request_number
	  }
	  
	  var updates = {};
	  updates["/delivery/deliveryMain/"+uid] = data;
	  firebase.database().ref().update(updates);
	  
	  var requestNumber = document.getElementById("request_number");
	  requestNumber.value = request_number;
	  
	  $.ajax({
			url:'./alertDelivery',
			type: 'get',
			data : {title:"새로운 배송 요청", messageBody:start_Zip, Lat:start_Lat.value, Lon:start_Lon.value},
			dataType:'json',
			success : function(json){
			}			
		});
	 	
	  document.delivery_View.submit();
  }
  
  function getTimeStamp() {
	  var d = new Date();

	  var s =
	    leadingZeros(d.getFullYear(), 4) +
	    leadingZeros(d.getMonth() + 1, 2) +
	    leadingZeros(d.getDate(), 2) + '_' +

	    leadingZeros(d.getHours(), 2) +
	    leadingZeros(d.getMinutes(), 2) +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
	}



	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
	}
</script>
</head>
<body>
<div class="container">
	<header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
          <div class="col-4 pt-1">
          	
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
            	<a class="blog-header-logo text-dark" href="deliveryRequest">배송 신청</a>
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

	<div class="row">
		<div class="col-md-12 order-md-1">
		<form name="delivery_View" action="deliveryResult" method="post">
			<input type="hidden" name="approval_url" value="http://localhost:8081/spring/paysuccess">
			<input type="hidden" name="cancel_url" value="http://localhost:8081/spring/paycancel">
			<input type="hidden" name="fail_url" value="http://localhost:8081/spring/payfail">
			<input type="hidden" name="cst_id" id="cstId" value="${order.cst_Id }">
			<input type="hidden" name="request_number" id="request_number">
			<input type="hidden" name="start_Lat" id="start_Lat" value="${order.start_Lat }">
			<input type="hidden" name="start_Lon" id="start_Lon" value="${order.start_Lon }">
			<input type="hidden" name="arrive_Lat" id="arrive_Lat" value="${order.arrive_Lat }">
			<input type="hidden" name="arrive_Lon" id="arrive_Lon" value="${order.arrive_Lon }">
			<input type="hidden" name="partner_user_id" id="partner_user_id" value="${order.cst_Id }">
			<input type="hidden" name="cid" value="TC0ONETIME">
			<c:if test="${order.orderkinds == 1 }">			
				<input type="hidden" name="item_name" value="간단(1kg)">
			</c:if>
			<c:if test="${order.orderkinds == 2 }">
				<input type="hidden" name="item_name" value="서류(2kg)">
			</c:if>
			<c:if test="${order.orderkinds == 3 }">
				<input type="hidden" name="item_name" value="박스(5kg)">
			</c:if>
			<input type="hidden" name="partner_order_id" value="testorder01">
			<input type="hidden" name="quantity" value="1"><br>
			
			<input type="hidden" name="item_name" value="${order.orderkinds}">
			<input type="hidden" name="vat_amount" value="10">
			<div class="row">
				<div class="col-md-6 mb-3">
					 <label for="startName">보내는 분(이름)</label><br>
					<input type="text" name="cst_Name" id="cstName" value="${order.cst_Name}" >
                </div>
			</div>
			<div class="mb-3">
				<label for="startPhone">보내는 분(전화번호)</label><br>
				<input type="text"  name="cst_Phone" id="cstPhone" value="${order.cst_Phone}" >
            </div>
            <div class="mb-3">
              	<label for="startAddress">출발지</label><br>
              	<input type="text" class="form-control" name="start_Zip" id="startZip" value="${order.start_Zip}" >
             </div>
             
			<div class="row">
				<div class="col-md-6 mb-3">
					 <label for="endName">받는 분(이름)</label><br>
					<input type="text" name="arrive_Name" id="arriveName" value="${order.arrive_Name}" >
                </div>
			</div>
			<div class="mb-3">
				<label for="endPhone">받는 분(전화번호)</label><br>
				<input type="text" name="arrive_Phone" id="arrivePhone" value="${order.arrive_Phone}" >

            </div>
			<div class="mb-3">
              <label for="startAddress">도착지</label>
              <input type="text" class="form-control" name="end_Zip" id="endZip" value="${order.end_Zip}" >
            </div>
			<div class="mb-3">
				<label for="kinds">물품 종류</label>
				<input type="hidden" name="orderkinds" id="orderKinds" value="${order.orderkinds}" >
					<c:if test="${order.orderkinds == 1 }">			
					<h5>간단(1kg)</h5>
					</c:if>
					<c:if test="${order.orderkinds == 2 }">
					<h5>서류(2kg)</h5>
					</c:if>
					<c:if test="${order.orderkinds == 3 }">
					<h5>박스(5kg)</h5>
					</c:if>
			</div>
			<div class="mb-3">
              	<label for="direct">방향</label>
              	<input type="hidden" name="direction" id="Direction" value="${order.direction}">
					<c:if test="${order.direction == 1 }">
					<h5>편도</h5>
					</c:if>
					<c:if test="${order.direction == 2 }">
					<h5>왕복</h5>
					</c:if>
            </div>
			<div class="mb-3">
              	<label for="orderprice">요금</label>
              	<c:if test="${order.direction == 1 }">
						<input type="hidden" name="orderPrices" id="orderprices" value="${order.orderPrices}">
						<input type="hidden" name="total_amount" value="${order.orderPrices}">
						<h5>${order.orderPrices}원</h5>
					</c:if>
					<c:if test="${order.direction == 2 }">
						<input type="hidden" name="orderPrices" id="orderprices" value="${order.orderPrices * 2}">
						<input type="hidden" name="total_amount" value="${order.orderPrices * 2}">
						<h5>${order.orderPrices * 2}원</h5>
					</c:if>         
            </div>
			<div class="mb-3">
              	<label for="payinfo">요금 지불 방식</label>
              	<h5><input type="radio" name="payment_info" value="1" checked>선불</h5>
				<h5><input type="radio" name="payment_info" value="2" >후불</h5>
				<h5><input type="radio" name="payment_info" value="3">포인트</h5>        
            </div>
			<div class="mb-3">
              	<label for="direct">요청사항</label>
              	<div class="container">
				<div class="input-group">
					<textarea class="form-control" rows="10" name="bContent" id="Bcontent" aria-label="With textarea" >${order.bContent}</textarea>
				</div>
				</div>      
            </div>
			<div class="mb-3">
			<nav aria-label="..." class="nav justify-content-center">
				<button class="btn btn-outline-success" type="button" onclick="formCheck()">확인</button>
            </nav>
            </div>
		</form>
	</div>
</div>
<footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; JibaeIn 지하철 택배</p>
      </footer>
</div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
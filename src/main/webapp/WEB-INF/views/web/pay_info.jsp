<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.setAttribute("bUrl", "pay_info"); 
String member = (String)session.getAttribute("member");
%>
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
 
<title>JibaeIn 지하철 택배</title>
<script>
	function payInfo(){
		var startZip = document.getElementById("startZip");
		var arriveZip = document.getElementById("arriveZip");
		var orderPrice = document.getElementById("orderPrice");
		$.ajax({
			url:'./payInfo',
			type: 'POST',
			data : {startZip:startZip.value, arriveZip:arriveZip.value},
			dataType:'json',
			success : function(json){
				var results = eval(json);
				if(results.result=="ok"){
					orderPrice.innerHTML = results.pay+"원"; 
				}
				else{
					alert("error");
				}
			}			
		});
	}
</script>
<script>  
	function openChatt(){  
	    window.open("http://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/chatt", "관리자 대화방", "width=1200, height=850, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}  
 
</script>
</head>
<body class="bg-light">
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
            	<a class="blog-header-logo text-dark" href="pay_info">요금표</a>
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
        <table class="table">
        	<tr class="table-success">
        		<th scope="row" >
        		<nav class="nav justify-content-end" >
        		출발지 &nbsp;&nbsp;
        		<select class="custom-select" id="startZip" name="startZip" style="width:150px"> 
        				<option value="choose">선택
						<option value="강남구" >강남구 
						<option value="강동구">강동구
						<option value="강북구">강북구
						<option value="강서구" >강서구 
						<option value="관악구">관악구
						<option value="광진구">광진구
						<option value="구로구" >구로구 
						<option value="금천구">금천구
						<option value="노원구">노원구
						<option value="도봉구" >도봉구 
						<option value="동대문구">동대문구
						<option value="동작구">동작구
						<option value="마포구" >마포구 
						<option value="서대문구">서대문구
						<option value="서초구">서초구
						<option value="성동구" >성동구 
						<option value="성북구">성북구
						<option value="송파구">송파구
						<option value="양천구" >양천구 
						<option value="영등포구">영등포구
						<option value="용산구">용산구
						<option value="은평구" >은평구 
						<option value="종로구">종로구
						<option value="중구">중구
						<option value="중랑구">중랑구
						<option value="부천시">부천시
						<option value="인천시" >인천시 
						<option value="안양시">안양시
						<option value="수원시">수원시
						<option value="안양시">안산시
						<option value="수원시">성남시
						<option value="고양시" >고양시 
						<option value="의정부시">의정부시
						<option value="광명시">광명시
					</select>
        		</nav>
        		</th>
        		<th scope="row">
        		<nav class="nav" >
        		도착지 &nbsp;&nbsp;
        		<select class="custom-select" id="arriveZip" name="arriveZip" style="width:150px"> 
        				<option value="choose">선택
						<option value="강남구" >강남구 
						<option value="강동구">강동구
						<option value="강북구">강북구
						<option value="강서구" >강서구 
						<option value="관악구">관악구
						<option value="광진구">광진구
						<option value="구로구" >구로구 
						<option value="금천구">금천구
						<option value="노원구">노원구
						<option value="도봉구" >도봉구 
						<option value="동대문구">동대문구
						<option value="동작구">동작구
						<option value="마포구" >마포구 
						<option value="서대문구">서대문구
						<option value="서초구">서초구
						<option value="성동구" >성동구 
						<option value="성북구">성북구
						<option value="송파구">송파구
						<option value="양천구" >양천구 
						<option value="영등포구">영등포구
						<option value="용산구">용산구
						<option value="은평구" >은평구 
						<option value="종로구">종로구
						<option value="중구">중구
						<option value="중랑구">중랑구
						<option value="부천시">부천시
						<option value="인천시" >인천시 
						<option value="안양시">안양시
						<option value="수원시">수원시
						<option value="안양시">안산시
						<option value="수원시">성남시
						<option value="고양시" >고양시 
						<option value="의정부시">의정부시
						<option value="광명시">광명시
					</select>
        		</nav>
        		</th>
        	</tr>
        	<tr class="table-light">
        		<th scope="row" colspan="4">
        		<nav class="nav justify-content-center" >
        		<button type="button" class="btn btn-outline-secondary" onclick="payInfo()">요금 조회</button>&nbsp;&nbsp;
        		요금 :&nbsp;&nbsp;
        		<div id="orderPrice"></div>
        		</nav>
        		</th>
        	</tr>

        </table>       
		<nav class="nav justify-content-center" >
			(각 숫자는 천원단위 입니다.)
 			<img src="./picture/요금표.png">
		</nav>
</div>
<footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; JibaeIn 지하철 택배</p>
      </footer>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
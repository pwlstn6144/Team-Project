<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.setAttribute("bUrl", "ModifyForm"); 
String member = (String)session.getAttribute("member");
if(session.getAttribute("id") == null ||!(session.getAttribute("member").equals("customer"))) {%>
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
<title>JibaeIn 지하철 택배</title>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
function updateInfoConfirm() {

	var chk = confirm("정보를 수정하시겠습니까?");

	if(document.reg_frm.cst_PASSWORD.value == "") {
		alert("패스워드를 입력하세요.");
		document.reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PASSWORD.value != document.reg_frm.cst_PASSWORD_check.value) {
		alert("패스워드가 일치하지 않습니다.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PASSWORD.value.length < 8) {
		alert("비밀번호는 8~16자 영문 대 소문자, 숫자, 특수문자만 사용 가능합니다.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(!document.reg_frm.cst_PASSWORD.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
	      alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PHONE.value == 0) {
		alert("전화번호는 필수사항입니다..");
		reg_frm.cst_PHONE.focus();
		return;
	}	
	
	if (document.reg_frm.cst_EMAIL.value.length == 0) {
		alert("이메일은 필수사항입니다.");
		reg_frm.cst_EMAIL.focus();
		return;
	}
	
	document.reg_frm.submit();
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
            	<a class="blog-header-logo text-dark" href="ModifyForm">정보 수정</a>
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
		    <a class="dropdown-item" href="#">인사말</a>
		    <a class="dropdown-item" href="comeLoad">찾아오시는길</a>
		  </div>
		</div> 
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   서비스 안내
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="pay_info">요금표</a>
		    <a class="dropdown-item" href="payTracking">요금조회</a>
		  </div>
		</div>
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		 	배송
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="deliveryRequest">배송 신청</a>
		    <a class="dropdown-item" href="tracking">배송 조회</a>
		  </div>
		</div>
        <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true"  onclick="javascript:window.location='QandA'" aria-expanded="false">
		   고객의 소리
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%if(member == null || member.equals("customer") || member.equals("worker")){ %>
		 <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true" aria-expanded="false">
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
		</div>
		</div>
		<%} %>
        </nav>
        <br />
	<form action="updateMember" method="post" name="reg_frm">
		<table class="table table-bordered">
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				아이디
				</nav>
				</th>
				<td><input type="hidden" id="cst_ID" name="cst_ID" value="${dto.cst_ID}">${dto.cst_ID}</td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				비밀번호
				</nav>
				</th>
				<td><input type="password" id="cst_ID"  name="cst_PASSWORD" size="20" value="${dto.cst_PASSWORD}"></td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				비밀번호 확인
				</nav>
				</th>
				<td><input type="password" id="cst_PASSWORD_check"  name="cst_PASSWORD_check" size="20" value="${dto.cst_PASSWORD}"></td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				이름
				</nav>
				</th>
					<td><input type="hidden" id="cst_NAME" name="cst_NAME" value="${dto.cst_NAME}">${dto.cst_NAME}</td>
			</tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				휴대전화
				</nav>
				</th>
				<td><input type="text" id="cst_PHONE"  name="cst_PHONE" value="${dto.cst_PHONE}"></td>
			<tr>
			<tr>
				<th class="table-success">
				<nav class="nav justify-content-center" >
				메일
				</nav>
				</th>
				<td><input type="text" id="cst_EMAIL"  name="cst_EMAIL" style="width:300px"value="${dto.cst_EMAIL}"></td>
			</tr>
			<tr>
				<td colspan="2">
					<button class="btn btn-outline-primary" type="button" onclick="updateInfoConfirm()">정보 수정</button>&nbsp;&nbsp;
					<button class="btn btn-outline-success" type="button" onclick="javascript:window.location='Member_house'">취소</button>&nbsp;&nbsp;
					<button class="btn btn-outline-danger" type="button" onclick="javascript:window.location='DeleteForm?cst_ID=${dto.cst_ID}&cst_PASSWORD=${dto.cst_PASSWORD}'">회원탈퇴</button>
					<!-- 나중에 post 방식으로  -->
				</td>
		</table>
	</form>
</div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>

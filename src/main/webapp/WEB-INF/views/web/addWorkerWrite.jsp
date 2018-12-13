<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.setAttribute("bUrl", "addWorkerWrite"); 
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

<script src="http://code.jquery.com/jquery.js"></script>
<script>
	function infoConfirm(){
		if(document.addWorker.wk_Name.value == 0) {
			alert("이름을 입력하세요.");
			addWorker.wk_Name.focus();
			return;
		}
		
		if(document.addWorker.wk_Id.value.length < 5) {
			alert("아이디를 입력하세요.");
			addWorker.wk_Id.focus();
			return;
		}
		
		if(document.addWorker.wk_Password.value == 0) {
			alert("비밀번호는 필수사항입니다.");
			addWorker.wk_Password.focus();
			return;
		}
		
		if(document.addWorker.wk_Password.value != document.addWorker.wk_Password2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			addWorker.wk_Password2.focus();
			return;
		}

		if(document.addWorker.wk_Phone.value.length== 0) {
			alert("휴대폰 번호는 필수사항입니다.");
			addWorker.wk_Phone.focus();
			return;
		}
		
		if(document.addWorker.userfile1.value.length== 0) {
			alert("사진을 넣어주세요.");
			return;
		}
			
		document.addWorker.submit();
	}
	
	function createId(){
		var location = document.getElementById("location").value;
		var loNum;
		var today = new Date();
		var yy = today.getFullYear().toString().substr(2,2);
		var mm = today.getMonth()+1;

		var id;
		var wk_Id = document.getElementById("wk_Id");
		if(location == "Seoul"){
			loNum = "01";
		}
		else if(location == "Gyunggido"){
			loNum = "02";
		}
		else if(location == "Inchan"){
			loNum = "03";
		}
		
		$.ajax({
			url:'./createId',
			type: 'POST',
			data : {year:yy, month:mm, location:loNum},
			dataType:'json',
			success : function(json){
				var results = eval(json);
				if(results.result=="ok"){
					wk_Id.value = results.id;
				}
				else{
					alert(results.desc);
				}
			}			
		});	
		
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
	function openChatt(){  
	    window.open("http://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/chatt", "관리자 대화방", "width=1200, height=850, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
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
            	<a class="blog-header-logo text-dark" href="addWorkerWrite">신입기사 추가</a>
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
	<form name="addWorker" method="post" action="addView" enctype="multipart/form-data">
		<table class="table table-bordered">
			<tr>
				<th class="table-success">이름</th>
				<td><input type="text" id="wk_Name" name="wk_Name" ></td>
			</tr>
			<tr>
				<th class="table-success">아이디</th>
				<td>
					<select id="location" name="location" >
						<option value="Seoul">서울특별시 
						<option value="Gyunggido">경기도
						<option value="Inchan" >인천광역시 				
					</select>			
					<input type="text" id="wk_Id" name="wk_Id"><br>	
					<button class="btn btn-primary" type="button" onclick="createId()">아이디 생성</button>
				</td>
			</tr>
			<tr>
				<th class="table-success">비밀번호</th>
				<td><input type="password" id="wk_Password" name="wk_Password" ></td>
			</tr>
			<tr>
				<th class="table-success">비밀번호 확인</th>
				<td><input type="password" id="wk_Password2" name="wk_Password2" ></td>
			</tr>
			<tr>
				<th class="table-success">전화번호</th>
				<td><input type="text" id="wk_Phone" name="wk_Phone" placeholder="-은 제외하고 입력하세요." ></td>
			</tr>
			<tr>
				<th class="table-success">사진 업로드</th>
				<td><input type="file" id="userfile1" name="userfile1" /></td>
			</tr>
			<tr>
				<th class="table-light" colspan="2">
					<button class="btn btn-outline-primary" type="button" onclick="infoConfirm()">다음</button>
				</th>
			</tr>
		</table>
	</form>
	<footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; JibaeIn 지하철 택배</p>
      </footer>
</div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
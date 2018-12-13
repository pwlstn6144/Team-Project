<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.setAttribute("bUrl", "notice"); 
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


<script>
function frm_submit(){
	var search = document.getElementById("searchText").value;
	var bsearch = document.getElementById("bSearch").value;
	var searchValue = document.getElementById("Info");


	if(bsearch == "writerId"){
		searchValue.value = "writerId";
	}
	else if(bsearch == "writerTitle"){
		searchValue.value = "writerTitle";
	}

	document.frm_search.submit();
	
	
}
</script>
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
				<%if((session.getAttribute("member") == null) || !(session.getAttribute("member").equals("master"))) {%>
          		
          		<%} else {%>
          		<h2><a class="badge badge-primary" href="service_write?bName=<%=session.getAttribute("id")%>">글 작성</a></h2>
          		<%} %>
          	</div>
       		<div class="col-4 text-center">
            	<a class="blog-header-logo text-dark" href="notice">공지사항</a>
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
		<thead class="thead-dark">
		<tr>
			<th scope="col">번호</th>
			<th scope="col">아이디</th>
			<th scope="col">제목</th>
			<th scope="col">날짜</th>
			<th scope="col">히트</th>
		</tr>
		</thead>
		<c:forEach items="${list}" var="dto">
		<tr>
			<td>${dto.bId}</td>
			<td>${dto.bName}</td>
			<td>
				<c:forEach begin="1" end="${dto.bIndent}">-</c:forEach>
				<a href="service_view?bId=${dto.bId}&page=${page.curPage}">${dto.bTitle}</a></td>
			<td>${dto.bDate}</td>
			<td>${dto.bHit}</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="6">
				<nav aria-label="..." class="nav justify-content-center">
				<form action="search" name="frm_search"> 
					<c:if test="${info eq null }">
						<select class="custom-select" id="bSearch" name="bSearch" style="width:150px"> 
							<option value="writerId" >아이디 
							<option value="writerTitle">제목
						</select>
					</c:if>
					<c:if test="${info eq ''}">
						<select class="custom-select" id="bSearch" name="bSearch" style="width:150px"> 
							<option value="writerId" >아이디 
							<option value="writerTitle">제목
						</select>
					</c:if>
					<c:if test="${info eq 'writerId' }">
						<select class="custom-select" id="bSearch" name="bSearch" style="width:150px"> 
							<option value="writerId" >아이디 
							<option value="writerTitle">제목
						</select>
					</c:if>
					<c:if test="${info eq 'writerTitle' }">
						<select class="custom-select" id="bSearch" name="bSearch" style="width:150px"> 
							<option value="writerTitle">제목
							<option value="writerId" >아이디
						</select>
					</c:if>
					<input type="hidden" name="info" id="Info" value="${info}">
					<input type="text" name="search" id="searchText" style="width: 200px; height:30px" aria-label="검색" aria-describedby="button-addon2" value="${search}">
					<button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="frm_submit();">검색</button>
				</form>
				</nav>
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<nav aria-label="..." class="nav justify-content-center">
				<!-- 처음 버튼 -->
				<ul class="pagination" id="nav">	
					<c:choose>
						<c:when test="${(page.curPage -1) < 1}">
							<li class="page-item disabled" >
								<a class="page-link" href="notice?page=1&info=${info}&search=${search}" tabindex="-1">처음</a>	
							</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="notice?page=1&info=${info}&search=${search}">처음</a>				
						</li>
					</c:otherwise>
				</c:choose>

				<!-- 개별 페이지 -->
				<c:forEach var = "fEach" begin="${page.startPage}" end="${page.endPage}" varStatus="status">
					<c:choose>
						<c:when test="${page.curPage == fEach}">
							<li class="page-item active">
								<a class="page-link" href="notice?page=${fEach}&info=${info}&search=${search}">${fEach}<span class="sr-only">(current)</span></a> 
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="notice?page=${fEach}&info=${info}&search=${search}">${fEach}</a></li> 				
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- 끝 버튼 -->
				<c:choose>
					<c:when test="${(page.curPage +1) > page.totalPage}">
						<li class="page-item disabled">
							<a class="page-link"  href="#" tabindex="-1">끝</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link" href="notice?page=${page.totalPage}&info=${info}&search=${search}">끝</a></li>				
					</c:otherwise>
				</c:choose>
				</ul>
				</nav>
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
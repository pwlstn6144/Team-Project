<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.setAttribute("bUrl", "main"); 
String member = (String)session.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
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
<style>

   
   ul li{
   		display: inline;
   		margin: 60px;
   }
   
   img{
   		max-width: 100%;
		width: 600px;
		max-height: 100%;
		height:600px;
   }
</style>

<script>  
	function openChatt(){  
	    window.open("http://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/chatt", "관리자 대화방", "width=1200, height=850, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}  
 
</script>  

<title>JibaeIn 지하철 택배</title>
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
		<div class="col-md-12 px-0">
        	<div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
  				<div class="carousel-inner">
    				<div class="carousel-item active">
      					<img class="d-block w-100" src="./picture/jibaeIn1.png" alt="첫번째 슬라이드">
    				</div>
    				<div class="carousel-item">
      					<img class="d-block w-100" src="./picture/jibaeIn2.png" alt="두번째 슬라이드">
    				</div>
    				<div class="carousel-item">
      					<img class="d-block w-100" src="./picture/jibaeIn3.png" alt="세번째 슬라이드">
    				</div>
  				</div>
  					<a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
    					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    					<span class="sr-only">이전</span>
 	 				</a>
  					<a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
    					<span class="carousel-control-next-icon" aria-hidden="true"></span>
    					<span class="sr-only">다음</span>
  					</a>
			</div>
        </div>
		<div class="row mb-2" >
        	<div class="col-md-6" >
          		<div class="card flex-md-row mb-4 shadow-sm h-md-250">
            		<div class="card-body d-flex flex-column align-items-start" style="overflow:auto;">
              			<strong class="d-inline-block mb-2 text-success">공지사항</strong>      
               	 		<c:choose>
               	 			<c:when test="${best == null}">
               	 				게시물이 없습니다.
               	 				<hr>
               	 			</c:when>
               	 			<c:otherwise>
               	 				<c:forEach items="${best}" var="best">
               	 					<a href="service_view?bId=${best.bId}&page=1" ><h3>제목 : ${best.bTitle }</h3></a> <br>
               	 					아이디 : ${best.bName} &nbsp;&nbsp; 게시일 : ${best.bDate } &nbsp;&nbsp;<br> 조회수 : ${best.bHit }회 <br>
               	 					<%out.println("-----------------------------------------------------------------"); %>
               	 				</c:forEach>             	 		
               	 			</c:otherwise>
               	 		</c:choose>
            		</div>         
          		</div>
        	</div>
        <div class="col-md-6">
          <div class="card flex-md-row mb-4 shadow-sm h-md-250">
            <div class="card-body d-flex flex-column align-items-start" style="overflow:auto;">
              <strong class="d-inline-block mb-2 text-success">고객의 소리</strong>
              <c:choose>
               	 <c:when test="${notice == null}">
               	 	게시물이 없습니다.
               	 	<hr>
               	 </c:when>
               	 <c:otherwise>
               	 	<c:forEach items="${notice}" var="notice">
               	 		<a href="service_view?bId=${notice.bId}&page=1"><h3>제목 : ${notice.bTitle }</h3></a> <br>
               	 			아이디 : ${notice.bName} &nbsp;&nbsp; 게시일 : ${notice.bDate } &nbsp;&nbsp;<br> 조회수 : ${notice.bHit }회 <br>
               	 			<%out.println("-----------------------------------------------------------------"); %>
               	 	</c:forEach>             	 		
               	 </c:otherwise>
              </c:choose>
            </div>     
          </div>
        </div>
      </div>
      
        
 </div>

    <footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; JibaeIn 지하철 택배</p>
      </footer>


<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
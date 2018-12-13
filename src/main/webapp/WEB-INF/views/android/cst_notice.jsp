<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.setAttribute("bUrl", "cst_notice"); 
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

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 
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
<title>JibaeIn 지하철 택배</title>
</head>

<body class="bg-light">
<div class="container">
	<table class="table">
		<thead class="thead-dark">
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">히트</th>
		</tr>
		</thead>
		<c:forEach items="${list}" var="dto">
		<tr>
			<td>${dto.bId}</td>
			<td>
				<c:forEach begin="1" end="${dto.bIndent}">-</c:forEach>
				<a href="notice_View?bId=${dto.bId}&page=${page.curPage}">${dto.bTitle}</a></td>
			<td>${dto.bHit}</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="6">
				<nav aria-label="..." class="nav justify-content-center">
				<form action="search" name="frm_search"> 
					<c:if test="${info eq null }">
						<select class="custom-select" id="bSearch" name="bSearch" style="width:150px"> 
							<option value="writerTitle">제목
						</select>
					</c:if>
					<c:if test="${info eq ''}">
						<select class="custom-select" id="bSearch" name="bSearch" style="width:150px"> 
							<option value="writerTitle">제목
						</select>
					</c:if>
					<c:if test="${info eq 'writerTitle' }">
						<select class="custom-select" id="bSearch" name="bSearch" style="width:150px"> 
							<option value="writerTitle">제목
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
								<a class="page-link" href="cst_notice?page=1&info=${info}&search=${search}" tabindex="-1">처음</a>	
							</li>
					</c:when>
					<c:otherwise>
						<li class="page-item">
							<a class="page-link" href="cst_notice?page=1&info=${info}&search=${search}">처음</a>				
						</li>
					</c:otherwise>
				</c:choose>

				<!-- 개별 페이지 -->
				<c:forEach var = "fEach" begin="${page.startPage}" end="${page.endPage}" varStatus="status">
					<c:choose>
						<c:when test="${page.curPage == fEach}">
							<li class="page-item active">
								<a class="page-link" href="cst_notice?page=${fEach}&info=${info}&search=${search}">${fEach}<span class="sr-only">(current)</span></a> 
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" href="cst_notice?page=${fEach}&info=${info}&search=${search}">${fEach}</a></li> 				
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
						<li class="page-item"><a class="page-link" href="cst_notice?page=${page.totalPage}&info=${info}&search=${search}">끝</a></li>				
					</c:otherwise>
				</c:choose>
				</ul>
				</nav>
			</td>
		</tr>
				
		
	</table>	
</div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
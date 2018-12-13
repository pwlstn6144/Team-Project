<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
 <script src="http://code.jquery.com/jquery.js"></script>
<title>JibaeIn 지하철 택배</title>
</head>
<%!
	String curpage;
	
%>
<body class="bg-light">
<div class="container">
	<br>
	<br>
	<table class="table table-bordered">
			<tr>			
				<th class="table-secondary">
				<nav class="nav justify-content-center" >  
				번호
				</nav>
				</th>
				<td>${content_view.bId}</td>
			</tr>
			<tr>
				<th class="table-secondary">
				<nav class="nav justify-content-center" > 
				히트
				</nav>
				</th>
				<td>${content_view.bHit}</td>
			</tr>
			<tr>
				<th class="table-secondary">
				<nav class="nav justify-content-center" > 
				날짜
				</nav>
				</th>
				<td> ${content_view.bDate}</td>
			</tr>
			<tr>
				<th class="table-secondary">
				<nav class="nav justify-content-center" > 
				아이디
				</nav>
				</th>
				<td> ${content_view.bName}</td>
			</tr>
			<tr>
				<th class="table-secondary">
				<nav class="nav justify-content-center" > 
				제목
				</nav>
				</th>
				<td> ${content_view.bTitle}</td>
			</tr>
			<tr>
				<th class="table-secondary">
				<nav class="nav justify-content-center" > 
				내용
				</nav>
				</th>
				<td> 
					${content_view.bContent}
				</td>
			</tr>
	
	</table>
	<nav class="nav justify-content-end" >  		
		<%if((int)session.getAttribute("bCheck") == 3) {%>
		<button type="button" class="btn btn-outline-success" aria-haspopup="true"  onclick="javascript:window.location='wk_notice?page=<%=session.getAttribute("cpage")%>'" aria-expanded="false">목록보기</button>&nbsp;&nbsp;
		<%} else if(((int)session.getAttribute("bCheck") == 2) ) {%>
		<button type="button" class="btn btn-outline-success" aria-haspopup="true"  onclick="javascript:window.location='cst_notice?page=<%=session.getAttribute("cpage")%>'" aria-expanded="false">목록보기</button>&nbsp;&nbsp;
		<%} %>
	</nav>
</div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
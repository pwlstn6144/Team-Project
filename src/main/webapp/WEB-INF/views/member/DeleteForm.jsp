<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>탈퇴 화면</title>
<script>
	function deletecheck(){
		var chk = confirm("정말로 탈퇴하시겠습니끼?");
		if(chk){
			document.delete1.submit();
		}
	}
</script>	
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form name="delete1" method="post" action="deleteMember">
				<div class="w3-center w3-large w3-margin-top">
					<h1>회원탈퇴</h1>
				</div>
				<div>
					<p>
						<label>아이디</label> 
						<input class="w3-input" type="hidden" id="cst_ID" name="cst_ID" value="${dto.cst_ID}">${dto.cst_ID}
					</p>
					<p>
						<label>비밀번호</label> 
						<input class="w3-input" type="password" id="cst_PASSWORD" name="cst_PASSWORD" />
					</p>
					<p class="w3-center">
						<input class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round" type="button" value="취소" onclick="javascript:window.location='main'">
						<input class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round" type="submit" value="탈퇴" onclick="deletecheck()">
					</p>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
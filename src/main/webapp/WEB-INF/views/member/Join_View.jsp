<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>회원가입 정보확인</title>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form action="LoginForm" method="post" name="Join_View">
				<div class="w3-center w3-large w3-margin-top">
					<h1>회원가입 정보확인창입니다.</h1>
				</div>
				<div>
					<p>
						<label>아이디</label>
						<input class="w3-input" type="hidden" name="cst_ID" value="${dto.cst_ID}">${dto.cst_ID}
					</p>
					<p>
						<label>이름 : </label>
						<input class="w3-input" type="hidden" name="cst_NAME" value="${dto.cst_NAME}">${dto.cst_NAME}
					</p>
					<p>
						<label>휴대전화</label>
						<input class="w3-input" type="hidden" name="cst_PHONE" value="${dto.cst_PHONE}">${dto.cst_PHONE}
					</p> 
					<p>
						<label>메일</label>
						<input class="w3-input" type="hidden" name="cst_EMAIL" value="${dto.cst_EMAIL}">${dto.cst_EMAIL}
					</p>
					<p class="w3-center">
						<input class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round" type="button" value="확인" onclick="javascript:window.location='LoginForm'">
					</p>
				</div>
			</form>	
		</div>
	</div>
</body>
</html>
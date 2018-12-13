<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>비밀번호 이메일 발송 확인</title>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form action="LoginForm" method="post" >
				<div class="w3-center w3-large w3-margin-top">
					<h1>이메일로 비밀번호가 발송되었습니다.</h1><br>
				</div>
				<p>
					<input class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round" type="button" value="확인" onclick="javascript:window.location='LoginForm'">
				</p>		
			</form>
		</div>
	</div>
</body>
</html>
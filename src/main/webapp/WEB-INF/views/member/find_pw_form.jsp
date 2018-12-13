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
<title>비밀번호 찾기</title>
<script>
	$(function(){
		$("#findBtn").click(function(){
			var data = {"cst_EMAIL": $("#cst_EMAIL").val()};
			$.ajax({
				url : "./find_pw",
	            data : data,
	            success : function (data) {
	            	alert("이메일로 비밀번호를 발송하였습니다."); 
	            }
	        });
	    });
	});
</script>

</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<form action="find_pw" method="post">
				<div class="w3-center w3-large w3-margin-top">
					<h1>비밀번호 찾기</h1>
				</div>
				<div>
					<p>
						<label>ID</label> 
						<input class="w3-input" type="text" id="cst_ID" name="cst_ID" required>
					</p>
					<p>
						<label>Email</label> 
						<input class="w3-input" type="text" id="cst_EMAIL" name="cst_EMAIL" required>
					</p>
					<p class="w3-center">
						<button type="submit" id=findBtn class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round">비밀번호 찾기</button>
						<button type="button" onclick="history.go(-1);"class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round">취소</button>
					</p>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
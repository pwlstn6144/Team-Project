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
<title>회원가입 화면</title>
<script type="text/javascript">
	function infoConfirm() {

		if (document.reg_frm.cst_ID.value == 0) {
			alert("아이디는 필수사항입니다.");
			reg_frm.cst_ID.focus();
			return;
		}

		if (document.reg_frm.cst_ID.value.length < 5) {
			alert("아이디는 5~20자의 영문 대/소문자, 숫자만 사용 가능합니다.");
			reg_frm.cst_ID.focus();
			return;
		}

		if (!document.reg_frm.cst_ID.value
				.match(/([a-zA-Z0-9])|([a-zA-Z0-9])/)) {
			alert("아이디는 5~20자의 영문 대/소문자, 숫자만 사용 가능합니다.");
			reg_frm.cst_ID.focus();
			return;
		}

		if (document.reg_frm.cst_PASSWORD.value == 0) {
			alert("비밀번호는 필수사항입니다.");
			reg_frm.cst_PASSWORD.focus();
			return;
		}

		if (document.reg_frm.cst_PASSWORD.value != document.reg_frm.cst_PASSWORD_check.value) {
			alert("비밀번호가 일치하지 않습니다.");
			reg_frm.cst_PASSWORD.focus();
			return;
		}

		if (document.reg_frm.cst_PASSWORD.value.length < 8) {
			alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
			reg_frm.cst_PASSWORD.focus();
			return;
		}

		if (!document.reg_frm.cst_PASSWORD.value
				.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
			alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
			reg_frm.cst_PASSWORD.focus();
			return;
		}

		if (document.reg_frm.cst_NAME.value == 0) {
			alert("이름은 필수사항입니다.");
			reg_frm.cst_NAME.focus();
			return;
		}

		if (document.reg_frm.cst_PHONE.value.length == 0) {
			alert("전화번호는 필수사항입니다.");
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
<script>
	 //아이디 체크여부 확인 (아이디 중복일 경우 = 0 , 중복이 아닐경우 = 1 )
		function duplicationId() {
			var cst_ID = $("#cst_ID").val();
			
			$.ajax({
			type : 'POST',
			url : './idcheck',
			data : {cst_ID:cst_ID},
			cache: false,
			dataType : "json",
			success: function (json) {
				var results = eval(json);
				 if (results.i == "1") {
						alert("이미존재하는 아이디입니다.");
	                    $("#cst_ID").focus();
				 } else {
					 	alert("사용가능한 아이디입니다.");
	                    $("#cst_ID").focus();
	                }
	            },
	            error : function(error) {
	                
	                alert("error : " + error);
	            }
	        });
		}
</script>

<script>
$(function () {
    var chk = -1;
    
    $("#auth_btn").click(function () {
        var data = {"cst_EMAIL": $("#cst_EMAIL").val()};
        var cst_KEY = "";
        
        $.ajax({
            url : "./emailAuth",
            data : data,
            success : function (data) {
            	cst_KEY = data;
                alert("인증번호 전송완료."); 
            }
        });
    }); // 이메일 인증 버튼 end
});
</script>

 <script type="text/javascript">
	$(function () {
    	var chk = 0;
    	
    	$("#check_btn").click(function () {
    		
    		// 인증번호 비교 
   	 		if (cst_KEY = user_KEY){
    			alert("인증완료");
        		chk = 1;
        		$("user_KEY").val(user_KEY);
    		} else {
    			alert("인증실패");
        		chk = -1;
    		}
    		return chk;
    	});
	});
</script> 
</head>
 <body>
 	<div class="w3-content w3-container w3-margin-top" style="width:600px">
		<div class="w3-container w3-card-4">
			<form action=Join_View method="post" name="reg_frm" id="reg_frm">
				<div class="w3-center w3-large w3-margin-top">
					<h1>지배人 회원가입</h1>
				</div>
				<br>
				<div>
					<p>
						<label>아이디</label><br>
						<input class="w3-input" style="width:85%;float:left" type="text" id="cst_ID" name="cst_ID" maxlength="20"> 
						<input class="w3-input w3-block w3-blue" style="width:15%;float:left" type="button" value="중복확인" onclick="duplicationId()" />		
					</p>
					<p>
						<label>비밀번호</label><br>
						<input class="w3-input" type="password" id="cst_PASSWORD" name="cst_PASSWORD" maxlength="16" />
					</p>
					<p>
						<label>비밀번호 확인</label><br>
						<input class="w3-input" type="password" id="cst_PASSWORD_check" name="cst_PASSWORD_check" maxlength="16" />
					</p>
					<p>
						<label>이름</label><br>
						<input class="w3-input" type="text" id="cst_NAME" name="cst_NAME" />
					</p>
					<p>
						<label>전화 번호</label><br>
						<input class="w3-input" type="text" id="cst_PHONE" name="cst_PHONE" placeholder="- 제외한 숫자만 입력해주세요" />
					</p>
					<p>
						<label>이메일</label><br>
						<input class="w3-input"style="width:85%;float:left"type="text" id="cst_EMAIL" name="cst_EMAIL" placeholder="이메일 인증 후 로그인이 가능합니다." />
						<button class="w3-input w3-block w3-blue" style="width:15%;float:left" type="button" id="auth_btn">인증하기</button>
					</p>
					<br>
					<p>
						<label>인증번호</label><br>
						<input class="w3-input"style="width:85%;float:left" type="text" id="user_KEY" name="user_KEY">
						<button class="w3-input w3-block w3-blue" style="width:15%;float:left" type="button" id="check_btn">확인</button>
					</p>
					<p class="w3-center"><br>
						<input class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round" type="button" value="회원가입" onclick="infoConfirm()">
						<input class="w3-button w3-block w3-blue w3-ripple w3-margin-top w3-round" type="reset" value="취소" onclick="javascript:window.location='LoginForm'">
					</p>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
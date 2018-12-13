<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>로그인 화면</title>
<!-- Bootstrap core CSS -->
<link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="resources/design/signin.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery.js"></script>

<script>

function logininfoConfirm() {
	if(document.reg_frm.input_ID.value == 0) {
		alert("아이디 및 비밀번호를 확인해 주세요.");
		reg_frm.input_ID.focus();
		return;
	}
	
	if(document.reg_frm.input_PASSWORD.value == 0) {
		alert("아이디 및 비밀번호를 확인해 주세요.");
		reg_frm.input_PASSWORD.focus();
		return;
	}
	
	document.reg_frm.submit();
	
}
</script>
<!-- <script>
	$(function(){
		$("#find_id_form").click(function(){
			location.href='find_id_form';
		});
		$("#find_pw_form").click(function(){
			location.href='find_pw_form';
		});
	})
</script> -->


</head>

<body class="text-center">
<form name = frm_glogin></form>
<form action="userCheck" class="form-signin" method="post" name=reg_frm>
	<img class="mb-4" type="button" src="./picture/jibaeIn2.png" onclick="javascript:window.location='main'" alt="" width="85" height="85"><br>
	
	<input type="radio" name="LoginMode" id="LoginMode" value="admin" checked="checked"/>고객용
	<input type="radio" name="LoginMode" id="LoginMode" value="adminmanager" />기사용
	<input type="radio" name="LoginMode" id="LoginMode" value="adminmaster" />관리자
	
	<label for="inputID" class="sr-only">ID</label>
	<input type="text" name="input_ID" id="input_ID" value="<% if(session.getAttribute("cst_ID") != null)
												out.println(session.getAttribute("cst_ID"));
												%>" class="form-control" placeholder="ID" >
      <label for="inputPassword" class="sr-only">Password</label>
      <input type="password" name="input_PASSWORD" id="inputPassword" class="form-control" placeholder="PASSWORD">
      <div class="checkbox mb-3">
        <label>
          <input type="checkbox" value="remember-me"> Remember me
        </label>
      </div>
      <button class="btn btn-lg btn-primary btn-block" type="button" onclick="logininfoConfirm()">로그인</button>
      <button class="btn btn-lg btn-primary btn-block" onclick="javascript:window.location='JoinForm'">회원가입</button>
      <a href="find_id_form">아이디 찾기</a>&nbsp;
      |&nbsp;
      <a href="find_pw_form">비밀번호 찾기</a>
      <br>
	<button class="btn btn-lg btn-danger btn-block" type="button" id="check_btn">Google Login</button>
	
	<button class="btn btn-lg btn-primary btn-block" type="button" id="check_btn">FaceBook Login</button>
	
	<button class="btn btn-lg btn-warning btn-block" type="button" id="check_btn">KaKao Login</button>
	
	<button class="btn btn-lg btn-success btn-block" type="button" id="check_btn">Naver Login</button>

	<script src="https://code.jquery.com/jquery-1.12.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
</form>
	
</body>
</html>
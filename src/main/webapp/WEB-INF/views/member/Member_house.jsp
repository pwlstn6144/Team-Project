<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>${dto.cst_ID}님 안녕하세요</h1><br>
	<form action="ModifyForm" method="post" >
		<input type="hidden" value="${dto.cst_ID}" name="cst_ID">
	<%-- 	<input type="hidden" value="${dto}" name="cst_PASSWORD">
		<input type="hidden" value="${dto}" name="cst_NAME">
		<input type="hidden" value="${dto}" name="cst_PHONE">
		<input type="hidden" value="${dto}" name="cst_EMAIL"> --%>
		
		<!-- <a href="ModifyForm">회원정보 수정</a>, <a href="Logout">로그아웃</a> -->
		<a href="ModifyForm?cst_ID=${dto.cst_ID}">회원정보 수정</a>, <a href="Logout.do">로그아웃</a>
		<!-- <button class="btn btn-lg btn-primary btn-block" type="submit">회원정보 수정</button> -->
		
	</form>
</body>
</html>
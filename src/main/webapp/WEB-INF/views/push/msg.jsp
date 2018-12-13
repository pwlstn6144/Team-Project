<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>사용자들에게 보낼 Push Message 입력</h2>

<form action="sendMessage" method="GET">
	<input type="hidden" name="fromMem" value="Web">
	
	<textarea name="title" rows="1" cols="50" placeholder="제목을 입력하세요"></textarea><br>
    <textarea name="message" rows="4" cols="50" placeholder="메세지를 입력하세요"></textarea><br>

    <input type="submit" name="submit" value="Send" id="submitButton">

</form>


</body>
</html>
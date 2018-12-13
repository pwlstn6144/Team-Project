<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String member = (String)session.getAttribute("member");
 	if(!(member.equals("master"))) {
 %>
	<jsp:forward page="/LoginForm" />
<%
	}
%>

<%String rname = (String)session.getAttribute("rn"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=rname %> 대화방</title>
<!-- Bootstrap core CSS -->
<link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
<link href="https://getbootstrap.com/docs/4.1/examples/blog/blog.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
<link href="form-validation.css" rel="stylesheet">

<!--  <script src="https://cdn.ckeditor.com/4.10.0/standard/ckeditor.js"></script>-->
<script type="text/javascript" src="./naver-editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script language="JavaScript" src="members.js"></script>
<meta name="google-signin-client_id" content="356131626574-6u6njs718ofrd2ju2bjtcqkmos8299rk.apps.googleusercontent.com">
<style>
	#ir1 {
		resize:none;
		width:100%;
		
		border:1px solid #ccc;
	}
</style>

<script src = "http://code.jquery.com/jquery.js"> </script>

</head>
<body class="bg-light">
<div class="container">
	<header class="blog-header py-3">
		<div class="row flex-nowrap justify-content-between align-items-center">
        	<div class="col-4 pt-1">
        		<input type="hidden" id="myid" value="${masterName}" />
          	</div>
        <div class="col-4 text-center">
            <a class="blog-header-logo text-dark" href="main">JibaeIn 지하철 택배</a>
        </div>
        <div class="col-4 d-flex justify-content-end align-items-center">
           <%if(member == null) {%>
            <a class="btn btn-sm btn-outline-secondary" href="JoinForm">회원가입</a> &nbsp;
            <a class="btn btn-sm btn-outline-secondary" href="LoginForm">로그인</a>        
         <%} else { %>
         	<%=session.getAttribute("id") %>님 안녕하세요! &nbsp;&nbsp;
         	
         	<%if(member.equals("google")){ %>
         	<script>
				function signOut() {
				    var auth2 = gapi.auth2.getAuthInstance();
				    auth2.signOut().then(function () {
				    	console.log('User signed out.');
				    	document.location.href="logout.do"
				    });
				}
				function onLoad() {
					gapi.load('auth2', function(){
						gapi.auth2.init();
					});
				}
				</script>
	         	 <a href="#" onclick = "signOut();"class="badge badge-primary">로그아웃</a>
	         	 <script src="https://apis.google.com/js/platform.js?onload=onLoad" async defer></script>
	         	 
	      		 <%} else if(member.equals("customer") || member.equals("worker") || member.equals("master")) { %>
	         	<a href = "logout.do" class="badge badge-primary">로그아웃</a>
	         	<%} %>
	         <%} %>
        </div>
       </div>
       
      </header>
      
		<div class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-4 pt-1">
          		
          	</div>
       		<div class="col-4 text-center">
            	<a class="blog-header-logo text-dark" href="notice.do"><%=rname %> 대화방</a>
        	</div>
        	<div class="col-4 d-flex justify-content-end align-items-center">
        	</div>
       </div>
       <br />
		
   		<br>
		<div class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-8" style="overflow:auto;">
			<textarea id="echoText" style="width:700px;height:550px;"></textarea>
			</div>	
			<div class="col-4">
          		<button type="button" class="btn btn-primary" id="rlist" value="mrlist" onclick="mrList()">방 인원 리스트</button>	
            	<div id="myRoom" style="width:300px;height:500px;background-color:white"></div>
          		
        	</div>	
        	
		</div>
		<div class="row flex-nowrap justify-content-between align-items-center">
		
		</div>		
		<div class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-12">
			<form onsubmit="return false">
				<input id="message" type="text" style="width:760px; height:30px;" onkeydown="Enter(event)">
				<input onclick="wsSendMessage();" id="trans" value="전송" type="button" >
				<br>
			</form>
			</div>
		</div>

		
</div>
	<script type="text/javascript">
		function Enter(e){
			if(e.which == 13){
				wsSendMessage();
			}
		}
		var id = document.getElementById("myid");
		
		var webSocket = new WebSocket("ws://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/echo-ws");
		var echoText = document.getElementById("echoText");
		echoText.value = "";
		var message = document.getElementById("message");
		webSocket.onopen = function(message){ wsOpen(message);};
		webSocket.onmessage = function(message){ wsGetMessage(message);};
		webSocket.onclose = function(message){ wsClose(message);};
		webSocket.onerror = function(message){ wsError(message);};
		
		
		function wsOpen(message){
			webSocket.send(id.value+"|"+"님이 들어오셨습니다.");

		}
		
		function wsSendMessage(){
			webSocket.send( id.value+ "|"+message.value);
			message.value = "";
		}
		
		function mrList(){ // 내방 인원
			var rlist = document.getElementById("rlist");
			webSocket.send(id.value+ "|"+"/"+rlist.value);
		}
		
		
		
		function wsCloseConnection(){
			webSocket.close();
		}
		
		function wsGetMessage(message){
			var roomlist = message.data;
			var order = roomlist.substring(0,7);
			var realmsg = roomlist.substring(7);

			if(order == "/mrList") // 내 방 인원
			{
				document.getElementById("myRoom").innerHTML = realmsg;			
			}
			else
			{
				echoText.value += message.data + "\n";
			}
			
		}
		
		function wsclose(message){
			webSocket.send(id.value+"|"+"님이 사라지셨습니다.");
			echoText.value += "Disconnect ... \n";
		}
		
		function wserror(message){
			echoText.value += "Error ... \n";
		}
	</script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
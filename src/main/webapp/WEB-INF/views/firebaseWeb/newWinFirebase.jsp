<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- Firebase App is always required and must be first -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-app.js"></script>

<!-- Add additional services that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-messaging.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-functions.js"></script>

<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery.js"></script>
    
    <%! String childKey, childDataId, childDataTitle, childDataMessage, masterId; %>
    <%
    	childKey = request.getParameter("childKey");
    	childDataId = request.getParameter("childDataId");
    	childDataTitle = request.getParameter("childDataTitle");
    	childDataMessage = request.getParameter("childDataMessage");
    	masterId = request.getParameter("masterId");
    %>
    
    <script>
    
    	var config = {
    	    apiKey: "AIzaSyCxNls_B1-81Xm8uU5i9I69ht7gT6Hg1C4",
    	    authDomain: "teamproject-91feb.firebaseapp.com",
    	    databaseURL: "https://teamproject-91feb.firebaseio.com",
    	    projectId: "teamproject-91feb",
    	    storageBucket: "teamproject-91feb.appspot.com",
    	    messagingSenderId: "590223549372",
    	  };
   		var mainApp = firebase.initializeApp(config);
    	  
   		
   		function uploadFirebase(){
   			var text = document.getElementById("messageinput").value;
   			
   			var postData = {
   			    	masterId : <%=masterId%>,
   			    	message: text
   			};
   			
   			// Get a key for a new Post.
   			var newPostKey = firebase.database().ref().child("delivery").child("chat").child("<%=childKey%>").push().key;
   			     		
   			// Write the new post's data simultaneously in the posts list and the user's post list.
   			var updates = {};
   			updates['/delivery/chat/<%=childKey%>/'+newPostKey] = postData;

   			
   			firebase.database().ref().update(updates);
   		}
	   	
	    
    </script>
	<script type="text/javascript">
		var message = document.getElementById("message");
		var textarea = document.getElementById("messageWindow");
		
		var innerchildDataMessage = "<%= childDataMessage%>";
		
		window.onload = function init(){
			document.getElementById('messageWindow').innerHTML = innerchildDataMessage +"\n";
			};
			
			
		function send(){

			var text = document.getElementById("messageinput").value;
			
			if(text ==""){
				return;
			}
			
			uploadFirebase();
			document.getElementById("messageWindow").innerHTML += text +"\n";
			document.getElementById("messageinput").value="";
		}
		
		
	</script>

</head>
<body>

<main role="main" class="container">

	<table>
	<tr>
	<td rowspan="2" style="padding-right: 50px;"> 
		<div class="media text-muted pt-3 row" id="messagediv">	
							<!-- Server responses get written here -->

			<textarea readonly id="messageWindow" rows="20" cols="100" readonly="true" style="resize:none; width:100%; height:100%;"></textarea>
		</div>
		
		<input type="text" style="width:380px;" id="messageinput" onkeypress="if(event.keyCode==13) {send(); }"/>
		<div class="input-group-append">
		<button class="btn btn-outline-secondary" type="button" onclick="send();">Send</button>
		</div>
</body>
</html>
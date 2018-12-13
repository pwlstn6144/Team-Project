<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONArray" %>
<%@page import="org.json.simple.JSONObject" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%! String id; %>
<% id = (String)session.getAttribute("id");%>

<!-- Firebase App is always required and must be first -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-app.js"></script>

<!-- Add additional services that you want to use -->
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-firestore.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-messaging.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-functions.js"></script>

<!-- Comment out (or don't include) services that you don't want to use -->
<!-- <script src="https://www.gstatic.com/firebasejs/5.5.2/firebase-storage.js"></script> -->

<link rel="stylesheet" href="./resources/map/map.css" type="text/css" />
<script src="http://code.jquery.com/jquery.js"></script>

<script type="text/javascript">
  // Initialize Firebase
  // TODO: Replace with your project's customized code snippet
  var config = {
    apiKey: "AIzaSyCxNls_B1-81Xm8uU5i9I69ht7gT6Hg1C4",
    authDomain: "teamproject-91feb.firebaseapp.com",
    databaseURL: "https://teamproject-91feb.firebaseio.com",
    projectId: "teamproject-91feb",
    storageBucket: "teamproject-91feb.appspot.com",
    messagingSenderId: "590223549372",
  };
  var mainApp = firebase.initializeApp(config);
  
  //mainApp.database().ref().set(value_1);
  
  var listEl = document.getElementById('kisaList')
  
  var list = new Array();
  
  //var userId = firebase.auth().currentUser.uid;
  
 
  //for (var i = 0; i < list.length; i++)
	//  listEl.appendChild(list[i]);
	  //document.write(list[i], ' / ');
  
  

</script>

</head>
<body>

<ul id="kisaList"></ul>

<div id="setTable"></div>

<script>  
	function openConsulting(childKey, childDataId, childDataTitle, childDataMessage){

		var masterId = '<%=id%>';
	    window.open("http://localhost:8081/spring/newWinFirebase?childKey="+childKey+"&childDataId="+childDataId+"&childDataTitle="+childDataTitle+"&childDataMessage="+childDataMessage+"&masterId="+masterId, "고객 상담실", "width=600, height=650, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}  
 
</script>

<script type="text/javascript">


	firebase.database().ref().child("delivery").child("chat").once('value').then(function(snapshot) {
		//console.log(snapshot);
		
	  snapshot.forEach(function(childSnapshot) {
		  
		  	
		  	//console.log(childSnapshot);
		  	
		    var childKey = childSnapshot.key;
		    var childData = childSnapshot.val();
		  
			
		    list.push(childKey);
		    list.reverse();
		    
		    console.log(childKey);
		    console.log(childData);
		    
		    //console.log(list);
		    
		    var td = document.createElement( "TD" );
		    
		    td.innerHTML = '<a href=javascript:openConsulting(\"'+childKey+'\",\"'+childData.id+'\",\"'+childData.title+'\",\"'+childData.message+'\")>'+childData.title+'</a>'; 
		     //td.style.border = "1px solid #92acbb"; 
		     //td.style.padding = "3px"; 
		  	
			
			var tr = document.createElement( "TR" ); 
    		tr.appendChild( td ); 

			var table = document.createElement( "TABLE" ); 
    		table.appendChild( tr ); 
		    // ...
		    
    		setTable.appendChild( table ); 
		  });
	  	
	  //var username = (snapshot.val() && snapshot.val()) || 'Anonymous';
  // ...
	});

	

	
	
var date = new Date(); 
var string = date.toLocaleString(); 




</script>

</body>
</html>
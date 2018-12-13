<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<meta name="description" content="">
<meta name="author" content="">
<!-- Bootstrap core CSS -->
<link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
<link href="https://getbootstrap.com/docs/4.1/examples/blog/blog.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script" rel="stylesheet">
 <script src="http://code.jquery.com/jquery.js"></script>
<style>
   div nav a {
     font-family: 'Nanum Pen Script', cursive;
     font-size: 25px;
   }
   
   div p{
     font-family: 'Nanum Pen Script', cursive;
     font-size: 30px;
   }
   form label{
	   font-family: 'Nanum Pen Script', cursive;
	     font-size: 30px;
   }
</style>
<title>배송 요청</title>
 <script src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="./naver_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDkOYoOUAA5i93hagnc47sOmK2eYFCVIrM&callback=geo"
  type="text/javascript"></script>


</head>
<body class="bg-light">
<script type="text/javascript">
	function geo(){
		var geocoder = new google.maps.Geocoder();
        var geocoder2 = new google.maps.Geocoder();
        var start_Lat = document.getElementById("start_Lat");
    	var start_Lon = document.getElementById("start_Lon");
    	var arrive_Lat = document.getElementById("arrive_Lat");
    	var arrive_Lon = document.getElementById("arrive_Lon");
        var start_zip = document.getElementById('start');
        var end_zip = document.getElementById('arrive');
        geocoder.geocode({'address': start_zip.value}, function(results, status) {
          if (status === google.maps.GeocoderStatus.OK) {
            start_Lat.value=results[0].geometry.location.lat();
    	    start_Lon.value=results[0].geometry.location.lng();

          } else {

          }
        });
        
        geocoder2.geocode({'address': end_zip.value}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
            	arrive_Lat.value=results[0].geometry.location.lat();
            	arrive_Lon.value=results[0].geometry.location.lng();

            	document.deliveryRequest.submit();
            } else {

            }
          });
	}
	
	function form_check(){

        var start_Lat = document.getElementById("start_Lat");
    	var start_Lon = document.getElementById("start_Lon");
    	var arrive_Lat = document.getElementById("arrive_Lat");
    	var arrive_Lon = document.getElementById("arrive_Lon");
        var start_zip = document.getElementById('start');
        var end_zip = document.getElementById('arrive');


		var cstName = document.getElementById("cstName");
		var cstPhone = document.getElementById("cstPhone");
		var arriveName = document.getElementById("arriveName");
		var arrivePhone = document.getElementById("arrivePhone");

	    if(cstName.value == ""){
	    	alert("보내는 분을 입력하세요.");
	    	cstName.focus();
	    	return;
	    }
	    else if(cstPhone.value == ""){
	    	alert("전화번호를 입력하세요.");
	    	cstPhone.focus();
	    	return;
	    }
	    else if(arriveName.value == ""){
	    	alert("받는 분을 입력하세요.");
	    	arriveName.focus();
	    	return;
	    }
	    else if(arrivePhone.value == ""){
	    	alert("전화번호를 입력하세요.");
	    	arrivePhone.focus();
	    	return;
	    }
	    if(start ==""){
			alert("출발지를 선택하세요");
			start_zip.focus();
			return;
		}
		
		if(end == "") {
			alert("도착지를 선택하세요");
			end_zip.focus();
			return;
		}
		
		var start = start_zip.value;
		var strArray = start.split(" ");
		
		var end = end_zip.value;
		var endArray = end.split(" ");
		
		if(strArray[0] == "서울특별시" || strArray[0] == "경기도"){

			if(endArray[0] == "서울특별시" || endArray[0] == "경기도"){

			}
			else{
				alert("수도권 지역만 가능합니다.");
				return;
			}
		}
		else{
			alert("수도권 지역만 가능합니다.");
			return;
		}

		geo();
		
	}
	
	
	
	function startLocation(){
		var startZip = document.getElementById("startZip");
		var cst_Id = document.getElementById("cst_Id");
		var start = document.getElementById("start");
		if(startZip.value != "choose"){
			$.ajax({
				url:'./startLocation',
				type: 'POST',
				data : {check:startZip.value, cst_Id:cst_Id.value},
				dataType:'json',
				success : function(json){
					var results = eval(json);
					if(results.result=="ok"){
						start.value = results.zip;
					}
					else{
						
					}
				}			
			});
		}
			
	}
	
	function arriveLocation(){
		var arriveZip = document.getElementById("arriveZip");
		var cst_Id = document.getElementById("cst_Id");
		var arrive = document.getElementById("arrive");
		if(arriveZip.value != "choose"){
			$.ajax({
				url:'./arriveLocation',
				type: 'POST',
				data : {check:arriveZip.value, cst_Id:cst_Id.value},
				dataType:'json',
				success : function(json){
					var results = eval(json);
					if(results.result=="ok"){
						arrive.value = results.zip;
					}
					else{
						
					}
				}			
			});
		}
			
	}
	
	
	
</script>
<script>
	function zipSave(){
		var startZip = document.getElementById("startZip");
		var cst_Id = document.getElementById("cst_Id");
		var start = document.getElementById("start");
		if(startZip.value != "choose"){
			$.ajax({
				url:'./zipSaveCon',
				type: 'POST',
				data : {check:startZip.value, cst_Id:cst_Id.value, zip:start.value},
				dataType:'json',
				success : function(json){			
					var results = eval(json);
					if(results.result=="ok"){
						alert("저장되었습니다.");
					}
					else{
						alert("번호를 선택하세요.");
					}
				}			
			});
		}
		
	}
	
	function arriveSave(){
		var arriveZip = document.getElementById("arriveZip");
		var cst_Id = document.getElementById("cst_Id");
		var arrive = document.getElementById("arrive");
		if(arriveZip.value != "choose"){
			$.ajax({
				url:'./arriveSave',
				type: 'POST',
				data : {check:arriveZip.value, cst_Id:cst_Id.value, zip:arrive.value},
				dataType:'json',
				success : function(json){			
					var results = eval(json);
					if(results.result=="ok"){
						alert("저장되었습니다.");
					}
					else{
						alert("번호를 선택하세요.");
					}
				}			
			});
		}
		
	}

    function geocodeAddress(geocoder, geocoder2) {
    	var start_Lat = document.getElementById("start_Lat");
    	var start_Lon = document.getElementById("start_Lon");
    	var arrive_Lat = document.getElementById("arrive_Lat");
    	var arrive_Lon = document.getElementById("arrive_Lon");
        var start = document.getElementById('start').value;
        var end = document.getElementById('arrive').value;
        geocoder.geocode({'address': start}, function(results, status) {
          if (status === google.maps.GeocoderStatus.OK) {
            start_Lat.value=results[0].geometry.location.lat();
    	    start_Lon.value=results[0].geometry.location.lng();
    	    alert(start_Lat.value + ", a" + start_Lon.value);
          } else {
            alert('Geocode was not successful for the following reason: ' + status);
          }
        });
        
        geocoder.geocode({'address': end}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
            	arrive_Lat.value=results[0].geometry.location.lat();
            	arrive_Lon.value=results[0].geometry.location.lng();
            	alert(arrive_Lat.value + ", a" + arrive_Lon.value);
            } else {
              alert('Geocode was not successful for the following reason: ' + status);
            }
          });
      }
</script>
<div class="container">
	<header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
          <div class="col-4 pt-1">
          	
          </div>
          <div class="col-4 text-center">
            <a class="blog-header-logo text-dark" href="main">Project Web Site</a>
          </div>
          <div class="col-4 d-flex justify-content-end align-items-center">
          <%if(session.getAttribute("login") == null) {%>
          	      
            <a class="btn btn-sm btn-outline-secondary" href="JoinForm">회원가입</a> &nbsp;
            <a class="btn btn-sm btn-outline-secondary" href="LoginForm">로그인</a>       
         <%} else { %>
         	<%=session.getAttribute("id") %>님 안녕하세요! &nbsp;&nbsp;
         	
         	<%if(session.getAttribute("login").equals("google")){ %>
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
         	 
      		 <%} else if(session.getAttribute("login").equals("origin")) { %>
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
            	<a class="blog-header-logo text-dark" href="deliveryRequest">배송 신청</a>
        	</div>
        	<div class="col-4 d-flex justify-content-end align-items-center">
        	</div>
       </div>
		<br />
        <nav class="nav justify-content-center" >  
        <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true" aria-expanded="false">
		   공지사항
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   회사 소개
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="#">인사말</a>
		    <a class="dropdown-item" href="#">찾아오시는길</a>
		  </div>
		</div> 
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   서비스 안내
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="#">요금표</a>
		    <a class="dropdown-item" href="#">요금조회</a>
		  </div>
		</div>
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		 	배송
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="deliveryRequest">배송 신청</a>
		    <a class="dropdown-item" href="tracking">배송 조회</a>
		  </div>
		</div>
        <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true" aria-expanded="false">
		   고객의 소리
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="btn-group">
        <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   관리자
		 </button> 
		<div class="dropdown-menu">
		   <a class="dropdown-item" href="#">기사 정보</a>
		   <a class="dropdown-item" href="#">대화방</a>
		   <a class="dropdown-item" href="#">전체 배송 조회</a>
		</div>
		</div>
        </nav>
        <br />
<table cellpadding="0" cellspacing="0" border="1">
	<form name="deliveryRequest" action="delivery_View" method="post">
		<input type="hidden" id="cst_Id" name="cst_id" value="test001">
		<input type="hidden" id="start_Lat" name="start_Lat">
		<input type="hidden" id="start_Lon" name="start_Lon">
		<input type="hidden" id="arrive_Lat" name="arrive_Lat">
		<input type="hidden" id="arrive_Lon" name="arrive_Lon">
		<tr>
			<td>보내는 분(성함)</td>
			<td><input type="text" name="cst_Name" id=cstName></td>
		</tr>
		<tr>
			<td>보내는 분(전화번호)</td>
			<td><input type="text" name="cst_Phone" id=cstPhone></td>
		</tr>
		<tr>
			<td>출발지</td>
			<td> 
				<select id="startZip" name="startZip" onchange="startLocation()"> 
					<option value="choose" >선택 
					<option value="first">1
					<option value="second">2
					<option value="third">3
				</select>
				<input type="text" id="start" name="start_zip" value=""> &nbsp;
				<input type="button" value="즐겨찾기 저장" onclick="zipSave()">
			</td>
		</tr>
		<tr>
			<td>받는 분(성함)</td>
			<td><input type="text" name="arrive_Name" id="arriveName"></td>
		</tr>
		<tr>
			<td>받는 분(전화번호)</td>
			<td><input type="text" name="arrive_Phone" id="arrivePhone"></td>
		</tr>
		<tr>
			<td>도착지</td>
			<td> 
				<select id="arriveZip" name="arriveZip" onchange="arriveLocation()"> 
					<option value="choose" >선택 
					<option value="first">1
					<option value="second">2
					<option value="third">3
				</select>
				<input type="text" id="arrive" name="arrive_zip" value=""> &nbsp;
				<input type="button" value="즐겨찾기 저장" onclick="arriveSave()">
			</td>
		</tr>
		<tr>
			<td>물품 종류</td>
			<td> <input type="radio" name="kind" value="1" checked>간단(1kg)
				 <input type="radio" name="kind" value="2" >서류(2kg)
				 <input type="radio" name="kind" value="3"> 박스(5kg)
			</td>
		</tr>
		<tr>
			<td>방향</td>
			<td> <input type="radio" name="direction" value="1" checked>편도
				 <input type="radio" name="direction" value="2" >왕복
			</td>
		</tr>
	
 		<tr>
			<td>요청사항</td>
			<td> 
				<textarea name="bContent" id="ir1" rows="10" cols="100">${content_view.bContent}
				</textarea>

			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" id="next" value="다음" onclick="form_check()">
			</td>
		</tr>
	</form>
</table>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<%
session.setAttribute("bUrl", "adminmap"); 
String member = (String)session.getAttribute("member");
if(!(session.getAttribute("member").equals("master"))) {%>
	<jsp:forward page="/LoginForm" />
<%} %>

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
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 
<title>JibaeIn 지하철 택배</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">


<link rel="stylesheet" href="./resources/map/map.css" type="text/css" />
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0272a5541ea760d1155d14ce7723f0b7&libraries=services,LIBRARY,MarkerClusterer,clusterer,drawing"></script>
<script src="http://code.jquery.com/jquery.js"></script>

<script>
	var mo;
</script>
</head>
<body class="bg-light">
<div class="container">
	<header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
          <div class="col-4 pt-1">

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
        <div class="col-4 text-center">
        
        </div>
        </div>
      </header>
      <div class="row flex-nowrap justify-content-between align-items-center">
			<div class="col-4 pt-1">
				<%if(session.getAttribute("id") != null) {%>

          		<%}%>
          	</div>
       		<div class="col-4 text-center">
       			<a class="blog-header-logo text-dark" href="map">현재 기사 위치 조회</a>

        	</div>
        	<div class="col-4 d-flex justify-content-end align-items-center">
        	</div>
       </div>
		<br />
        <nav class="nav justify-content-center" >  
       <%if(member == null || member.equals("customer") || member.equals("worker")){ %>
		 <button type="button" class="btn btn-outline-secondary btn-lg" onclick="javascript:window.location='notice'" aria-haspopup="true" aria-expanded="false">
		   공지사항
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%} else if(member.equals("master")){ %>
		<div class="btn-group">
        <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   공지사항
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class="dropdown-menu">
		   <a class="dropdown-item" href="notice?bCheck=2">회원 공지사항</a>
		   <a class="dropdown-item" href="notice?bCheck=3">기사 공지사항</a>
		</div>
		</div>
		<%} %>
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   회사 소개
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="greeting">인사말</a>
		    <a class="dropdown-item" href="comeLoad">찾아오시는길</a>
		  </div>
		</div> 
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   서비스 안내
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="pay_info">요금표</a>
		    <a class="dropdown-item" href="payTracking">요금조회</a>
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
        <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true"  onclick="javascript:window.location='QandA'" aria-expanded="false">
		   고객의 소리
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%if(member == null || member.equals("customer") || member.equals("worker")){ %>
		 <button type="button" class="btn btn-outline-secondary btn-lg" onclick="javascript:window.location='ModifyForm'" aria-haspopup="true" aria-expanded="false">
		   내 정보
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%} else if(member.equals("master")){ %>
		<div class="btn-group">
        <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   관리자
		 </button> 
		<div class="dropdown-menu">
		   <a class="dropdown-item" href="workerList">기사 정보</a>
		   <a class="dropdown-item" href="#" onclick="openChatt()">대화방</a>
		   <a class="dropdown-item" href="tracking">전체 배송 조회</a>
		   <a class="dropdown-item" href="map">현재 기사 위치 조회</a>
		</div>
		</div>
		<%} %>
        </nav>
 </div>
        <br />
	
	
	<div class="map_wrap" style="margin-left:100px;">
	    <div id="map" style="margin-bottom:50px;width:1300px;height:800px;position:relative;overflow:hidden;"></div>
	
	    <div id="menu_wrap" class="bg_white" style="margin-right:300px;">
	        <div class="option">
	            <div>
	                <form onsubmit="searchPlaces(); return false;">
	                    키워드 : <input type="text" value="서울 지하철" id="keyword" size="10"> 
	                    <button type="submit">검색하기</button> 
	                </form>
	                <button onclick="removeMarker(1)">마커 지우기</button> 
	            </div>
	        </div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
		</div>
		
		<div id="menu_wrap1" class="bg_white"  style="margin-right:300px;">
	        <div class="option">
	            <div>
	                <form onsubmit="searchKisa(); return false;">
	                    키워드 : <input type="text" value="기사 검색" id="keywordKisa" size="10">
	                    <button type="submit">검색하기</button> 
	                </form>
	                <button onclick="removeMarker(2)">마커 지우기</button> 
	            </div>
	        </div>
	        <hr>
	        <ul id="kisaList"></ul>
	        <div id="pagination"></div>
		</div>
		
		<div class="category">
	        <ul>
	            <li id="coffeeMenu" onclick="findKisa(this.value); start(this.value)" value=0 >
	                <span class="ico_comm ico_coffee"></span>
	                배송대기
	            </li>
	            
	            <li id="coffeeMenu" onclick="findKisa(this.value); start(this.value)" value=1 >
	                <span class="ico_comm ico_store"></span>
	                배송중
	            </li>
	            
	            <li id="coffeeMenu" onclick="findKisa(this.value); start(this.value)" value=2 >
	                <span class="ico_comm ico_carpark"></span>
	                휴식중
	            </li>
	            <li id="coffeeMenu" onclick="findLocation('0')">
	                <span class="ico_comm ico_oil"></span>
	                배송요청
	            </li>
	            <li id="coffeeMenu" onclick="findLocation('1')">
	                <span class="ico_comm ico_bank"></span>
	                도착지
	            </li>
	        </ul>
    	</div>

	</div>

	<SCRIPT>

		/* function start()
		{	
			
			setInterval("alert()", 60 * 1000);
		}
	
		function alert()
		{
			findKisa(1);
			location.reload();
			widow.status = " ";
			return true;
		} */
	

	</SCRIPT>
	
	<SCRIPT>
	
	//start();
	
	</SCRIPT>



	<script>
	function sendMessage(data){
		var token = data;
		
		//alert("token : " + data);
		$('#sendMessageModal').modal({backdrop: 'static', keyboard: false});
		
		var tokens = $('#tokens');
		tokens.attr('value', token);
	}
	
	function sendMessagesave() {

	 	var queryString3 = $("#messageForm").serialize(); // <- 이것만 사용
		//alert(queryString3);
	 
		
		//webSocket.send("inviteMessage" + " # " + uid + "@"+rmLoc + " % " + username + " | " + toinvite);
		
 		$.ajax({
			url		: './sendMessageAdmin?'+queryString3,
			type	: 'GET',
			data	: queryString3,
//			dataType: 'json',
			error	: function(xhr, status, error){

			},
			success : function(json){
				// 서버에서 에러 메시지나 성공 메시지는 여기서 출력됨.
				$('#messageBody').attr('value', "");
			}
			
		}).done(function(){

			}); 
		
	    $('#sendMessageModal').modal('hide');
	}
	
	
		
		//////////////////////////////////////////////////
		var clickedOverlay = null;
		var overlay = null;
		
		
		// 마커를 담을 배열입니다
		var markers = [];
		var searchKisaMarkers = [];
		var searchMarkers = [];
		var locationMarkers = [];
		var wait_wk_markers = [];
		var delivering_wk_markers = [];
		
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new daum.maps.LatLng(37.57811, 126.98044), // 지도의 중심좌표
		        level: 9, // 지도의 확대 레벨
		        mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
		    }; 

		// 지도를 생성한다 
		var map = new daum.maps.Map(mapContainer, mapOption); 

 		//addMarker(new daum.maps.LatLng(37.578933, 126.878906));
 		//findKisa(0);	//배송모드(대기중)
 		//findKisa(1);	//배송모드(배송중)
 		//findKisa(2);	//휴식모드
		
 		////////////////////////////////
 		// 장소 검색 객체를 생성합니다
		var ps = new daum.maps.services.Places();  
		
 		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new daum.maps.InfoWindow({zIndex:1});
		
 		
		// 키워드로 장소를 검색합니다
		//searchPlaces();
		
		/////////////////////////////////
 	// 마커를 생성하고 지도위에 표시하는 함수입니다
 		/* function addMarker(position) {
 		    
 		    // 마커를 생성합니다
 		    var marker = new daum.maps.Marker({
 		        position: position
 		    });

 		    // 마커가 지도 위에 표시되도록 설정합니다
 		    marker.setMap(map);
 		    
 		    // 생성된 마커를 배열에 추가합니다
 		    markers.push(marker);
 		} */
 	
 	// 배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
 		/* function setMarkers(map) {
 		    for (var i = 0; i < markers.length; i++) {
 		        markers[i].setMap(map);
 		    }            
 		} */

 		
 		
 		
 	
 		var clusterer = new daum.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        minLevel: 9 // 클러스터 할 최소 지도 레벨 
	    });
	 
 		var refreshIntervalId;
 		
 		function start(mode)
		{	
 			clearInterval(refreshIntervalId);
 			refreshIntervalId = setInterval("alert(\'"+mode+"\')", 1 * 1000);
		}
	
 		function alert(mode)
		{
			findKisa(mode);
			//location.reload();
			//widow.status = " ";
			return true;
		} 
		
		//start();
		
		//var refreshIntervalId = setInterval("alert(\'"+mode+"\')", 60 * 1000);
		
 		function findKisa(mode) {
 			//clearInterval();
 			
 			//alert(mode);
 		// 데이터를 가져오기 위해 jQuery를 사용합니다
 		    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
 		    //alert("findKisa mode : " + mode);
 		
 		    $.get("./findKisa?mode="+mode, function(data) {
 		        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
 		        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다

 		        //alert( "success" );   
 		        
 		        
 		    })
 		    .done(function(data) {
 		        //alert( "second success" );
 		       
 		       //clusterer.clear();
 		       console.log(data);
 				
 		      searchKisaMarkers = [];
 		      for(var i=0; i<data.positions.length; i++){
 		    	 searchKisaMarkers[i] = data.positions[i].wk_Name; 
 		      }
 		      console.log(searchKisaMarkers);
 		      //alert(data);
 		      //alert(data.positions);
 		      displayKisa(data.positions);
 		      
/*  		    	var markers = $(data.positions).map(function(i, position) {
 		    		var sMode = null;
 		    		if(position.wk_Mode == 0){
 		    			sMode = "(배송모드[대기중])";
 		    		} else if(position.wk_Mode == 1){
 		    			sMode = "(배송모드[배송중])";
 		    		} else if(position.wk_Mode == 2){
 		    			sMode = "(휴식모드)";
 		    		}
 		    		

	 		    	////	
 		    		var marker = new daum.maps.Marker({
 		                position : new daum.maps.LatLng(position.wk_Lat, position.wk_Lon)
 		             });
 		    		
 		    		daum.maps.event.addListener(marker, 'click', function() {
 		    			
					  
 		    			var CustomOverlay = new daum.maps.CustomOverlay({
				 		    //content: content,
				 		    map: map,
				 		    position: marker.getPosition()     
				 		   
				 		});
 		    			if (clickedOverlay) {
					        clickedOverlay.setMap(null);
					    }
					    CustomOverlay.setMap(map);
					    clickedOverlay = CustomOverlay;
					    
					    
 		    			 //마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 시작
						var Customcontent = document.createElement('div');
						Customcontent.className = "wrap";

						var info = document.createElement('div');
						info.className = "info"			
						Customcontent.appendChild(info);

						//커스텀오버레이 타이틀
						var contentTitle = document.createElement("div");
						contentTitle.className = "title"
						contentTitle.appendChild(document.createTextNode(position.wk_Name + " " + sMode));
						info.appendChild(contentTitle);

						//커스텀오버레이 닫기 버튼
						var closeBtn = document.createElement("div");
						closeBtn.className = "close";
						closeBtn.setAttribute("title","닫기");
						closeBtn.onclick = function() { CustomOverlay.setMap(null); };
						contentTitle.appendChild(closeBtn);

						var bodyContent = document.createElement("div");
						bodyContent.className = "body";
						info.appendChild(bodyContent);

						var imgDiv = document.createElement("div");
						imgDiv.className = "img";
						bodyContent.appendChild(imgDiv);

						//커스텀오버레이 이미지
						var imgContent = document.createElement("img");
						imgContent.setAttribute("src", "http://localhost:8081/spring/resources/upload/"+position.wk_Picture);
						//imgContent.setAttribute("src", "http://cfile181.uf.daum.net/image/250649365602043421936D");
						imgContent.setAttribute("width", "73");
						imgContent.setAttribute("heigth", "70");
						imgDiv.appendChild(imgContent);

						var descContent = document.createElement("div");
						descContent.className = "desc"
						bodyContent.appendChild(descContent);

						//커스텀오버레이 주소			
						var addressContent = document.createElement("div");
						addressContent.className = "ellipsis";
						addressContent.appendChild(document.createTextNode(position.wk_Phone));
						descContent.appendChild(addressContent);

						//커스텀오버레이 지번주소
						var address2Content = document.createElement("div");
						address2Content.className = "jibun ellipsis";
						address2Content.appendChild(document.createTextNode(position.wk_Phone));
						descContent.appendChild(address2Content);

						var LinkDiv = document.createElement("div");
						descContent.appendChild(LinkDiv);

						//커스텀오버레이 링크
						var LinkContent = document.createElement("a");
 						//if (url == "")
						//{
						//	url = "javascript:"
						//}
						//LinkContent.setAttribute("href", url);
						//if (url != "javascript:")
						//{
						//	LinkContent.setAttribute("target", "_blank");
						//}
						
						LinkContent.setAttribute("href", "javascript:sendMessage(\'"+position.wk_Token+"\')");
						LinkContent.className = "link";
						LinkContent.appendChild(document.createTextNode("메시지"));
						LinkDiv.appendChild(LinkContent);
						//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝

						CustomOverlay.setContent(Customcontent);
						 
						
						//daum.maps.event.addListener(marker, 'click', function() {
						//    if (clickedOverlay) {
						//        clickedOverlay.setMap(null);
						//    }
						//    CustomOverlay.setMap(map);
						//    clickedOverlay = CustomOverlay;
						//  });
						
					  });

 		    		
 		    		 return marker;
 		    	  });

 		     	clusterer.addMarkers(markers);
 		        */
 		    })
 		    .fail(function(data) {
 		        alert( "error" );
 		    })
 		    .always(function(data) {
 		        //alert( "finished" );
 		    });

 		}
	    

 		function findLocation(mode) {
 			
 			
 	 		// 데이터를 가져오기 위해 jQuery를 사용합니다
 	 		    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
 	 		    
 	 		
 	 		    $.get("./findLocation?mode="+mode, function(data) {
 	 		        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
 	 		        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다

 	 		        //alert( "success" );   
 	 		        
 	 		        
 	 		    })
 	 		    .done(function(data) {
 	 		        //alert( "second success" );
 	 		       
 	 		       clusterer.clear();
 	 		       console.log(data);
 	 		   		
 	 		   		
 	 		   		var Lat;
 	 		   		var Lon;
 	 		   		
 	 		   		if(mode == 0){
						var markers = $(data.positions).map(function(i, position) {
 	 		    	
 	 		    		
 	 		    		var marker = new daum.maps.Marker({
 	 		                position : new daum.maps.LatLng(position.start_Lat, position.start_Lon)
 	 		             });
 	 		    		
 	 		    		daum.maps.event.addListener(marker, 'click', function() {
 	 		    			
 	 		    			var idx = position.start_Zip.indexOf(" ", 9);
 	 		    	        var subAddr = position.start_Zip.substring(idx);
 						  
 	 		    			var CustomOverlay = new daum.maps.CustomOverlay({
 					 		    //content: content,
 					 		    map: map,
 					 		    position: marker.getPosition()     
 					 		   
 					 		});
 	 		    			if (clickedOverlay) {
 						        clickedOverlay.setMap(null);
 						    }
 						    CustomOverlay.setMap(map);
 						    clickedOverlay = CustomOverlay;
 						    
 						    
 	 		    			 //마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 시작
 							var Customcontent = document.createElement('div');
 							Customcontent.className = "wrap";

 							var info = document.createElement('div');
 							info.className = "info"			
 							Customcontent.appendChild(info);

 							//커스텀오버레이 타이틀
 							var contentTitle = document.createElement("div");
 							contentTitle.className = "title"
 							contentTitle.appendChild(document.createTextNode(subAddr));
 							info.appendChild(contentTitle);

 							//커스텀오버레이 닫기 버튼
 							var closeBtn = document.createElement("div");
 							closeBtn.className = "close";
 							closeBtn.setAttribute("title","닫기");
 							closeBtn.onclick = function() { CustomOverlay.setMap(null); };
 							contentTitle.appendChild(closeBtn);

 							var bodyContent = document.createElement("div");
 							bodyContent.className = "body";
 							info.appendChild(bodyContent);

 							var imgDiv = document.createElement("div");
 							imgDiv.className = "img";
 							bodyContent.appendChild(imgDiv);

 							//커스텀오버레이 이미지
 							var imgContent = document.createElement("img");
 							
 							imgContent.setAttribute("src", "/resources/map/logo.png");
 							imgContent.setAttribute("width", "73");
 							imgContent.setAttribute("heigth", "70");
 							imgDiv.appendChild(imgContent);

 							var descContent = document.createElement("div");
 							descContent.className = "desc"
 							bodyContent.appendChild(descContent);

 							//커스텀오버레이 주소			
 							var addressContent = document.createElement("div");
 							addressContent.className = "ellipsis";
 							addressContent.appendChild(document.createTextNode(position.cst_Name));
 							descContent.appendChild(addressContent);

 							//커스텀오버레이 지번주소
 							var address2Content = document.createElement("div");
 							address2Content.className = "jibun ellipsis";
 							address2Content.appendChild(document.createTextNode(position.cst_Phone));
 							descContent.appendChild(address2Content);

 							var LinkDiv = document.createElement("div");
 							descContent.appendChild(LinkDiv);

 							/* //커스텀오버레이 링크
 							var LinkContent = document.createElement("a");
 							if (url == "")
 							{
 								url = "javascript:"
 							}
 							LinkContent.setAttribute("href", url);
 							if (url != "javascript:")
 							{
 								LinkContent.setAttribute("target", "_blank");
 							}
 							LinkContent.className = "link";
 							LinkContent.appendChild(document.createTextNode("홈페이지"));
 							LinkDiv.appendChild(LinkContent); */
 							//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝

 							CustomOverlay.setContent(Customcontent);
 							 
 							
 							/* daum.maps.event.addListener(marker, 'click', function() {
 							    if (clickedOverlay) {
 							        clickedOverlay.setMap(null);
 							    }
 							    CustomOverlay.setMap(map);
 							    clickedOverlay = CustomOverlay;
 							  }); */
 							
 						  });

 	 		    		
 	 		    		 return marker;
 	 		    	  });
						
 	 		   		} else{
						var markers = $(data.positions).map(function(i, position) {
 	 		    	
 	 		    		
 	 		    		var marker = new daum.maps.Marker({
 	 		                position : new daum.maps.LatLng(position.arrive_Lat, position.arrive_Lon)
 	 		             });
 	 		    		
 	 		    		daum.maps.event.addListener(marker, 'click', function() {
 	 		    			
 						  
 	 		    			var CustomOverlay = new daum.maps.CustomOverlay({
 					 		    //content: content,
 					 		    map: map,
 					 		    position: marker.getPosition()     
 					 		   
 					 		});
 	 		    			if (clickedOverlay) {
 						        clickedOverlay.setMap(null);
 						    }
 						    CustomOverlay.setMap(map);
 						    clickedOverlay = CustomOverlay;
 						    
 						    
 	 		    			 //마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 시작
 							var Customcontent = document.createElement('div');
 							Customcontent.className = "wrap";

 							var info = document.createElement('div');
 							info.className = "info"			
 							Customcontent.appendChild(info);

 							//커스텀오버레이 타이틀
 							var contentTitle = document.createElement("div");
 							contentTitle.className = "title"
 							contentTitle.appendChild(document.createTextNode(position.end_Zip));
 							info.appendChild(contentTitle);

 							//커스텀오버레이 닫기 버튼
 							var closeBtn = document.createElement("div");
 							closeBtn.className = "close";
 							closeBtn.setAttribute("title","닫기");
 							closeBtn.onclick = function() { CustomOverlay.setMap(null); };
 							contentTitle.appendChild(closeBtn);

 							var bodyContent = document.createElement("div");
 							bodyContent.className = "body";
 							info.appendChild(bodyContent);

 							var imgDiv = document.createElement("div");
 							imgDiv.className = "img";
 							bodyContent.appendChild(imgDiv);

 							//커스텀오버레이 이미지
 							var imgContent = document.createElement("img");
 							
 							imgContent.setAttribute("src", "/resources/map/logo.png");
 							imgContent.setAttribute("width", "73");
 							imgContent.setAttribute("heigth", "70");
 							imgDiv.appendChild(imgContent);

 							var descContent = document.createElement("div");
 							descContent.className = "desc"
 							bodyContent.appendChild(descContent);

 							//커스텀오버레이 주소			
 							var addressContent = document.createElement("div");
 							addressContent.className = "ellipsis";
 							addressContent.appendChild(document.createTextNode(position.arrive_Name));
 							descContent.appendChild(addressContent);

 							//커스텀오버레이 지번주소
 							var address2Content = document.createElement("div");
 							address2Content.className = "jibun ellipsis";
 							address2Content.appendChild(document.createTextNode(position.arrive_Phone));
 							descContent.appendChild(address2Content);

 							var LinkDiv = document.createElement("div");
 							descContent.appendChild(LinkDiv);

 							/* //커스텀오버레이 링크
 							var LinkContent = document.createElement("a");
 							if (url == "")
 							{
 								url = "javascript:"
 							}
 							LinkContent.setAttribute("href", url);
 							if (url != "javascript:")
 							{
 								LinkContent.setAttribute("target", "_blank");
 							}
 							LinkContent.className = "link";
 							LinkContent.appendChild(document.createTextNode("홈페이지"));
 							LinkDiv.appendChild(LinkContent); */
 							//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝

 							CustomOverlay.setContent(Customcontent);
 							 
 							
 							/* daum.maps.event.addListener(marker, 'click', function() {
 							    if (clickedOverlay) {
 							        clickedOverlay.setMap(null);
 							    }
 							    CustomOverlay.setMap(map);
 							    clickedOverlay = CustomOverlay;
 							  }); */
 							
 						  });
 	 		    		
 	 		    		 return marker;
 	 		    	  });
 	 		   			
 	 		   		}
 	 		    	

 	 		     	clusterer.addMarkers(markers);
 	 		       
 	 		    })
 	 		    .fail(function(data) {
 	 		        alert( "error" );
 	 		    })
 	 		    .always(function(data) {
 	 		        //alert( "finished" );
 	 		    });

 	 		}

 		/* // "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
 		function showMarkers() {
 		    setMarkers(map);    
 		}

 		// "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
 		function hideMarkers() {
 		    setMarkers(null);    
 		} */
 		
 		
 		/////////////////////////////////////////////////
 		

		// 키워드 검색을 요청하는 함수입니다
		function searchPlaces() {

		    var keyword = document.getElementById('keyword').value;

		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }

		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    ps.keywordSearch( keyword, placesSearchCB); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === daum.maps.services.Status.OK) {

		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);

		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);

		    } else if (status === daum.maps.services.Status.ZERO_RESULT) {

		        alert('검색 결과가 존재하지 않습니다.');
		        return;

		    } else if (status === daum.maps.services.Status.ERROR) {

		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;

		    }
		}

		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {

		    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new daum.maps.LatLngBounds(), 
		    listStr = '';
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);

		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker(1);
		    
		    for ( var i=0; i<places.length; i++ ) {

		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new daum.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);

		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            daum.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });

		            daum.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });

		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };

		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);

		        fragment.appendChild(itemEl);
		    }

		    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;

		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    //map.setBounds(bounds);
		}

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {

		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';

		    if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
		                '</div>';           

		    el.innerHTML = itemStr;
		    el.className = 'item';

		    return el;
		}
		

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new daum.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });

		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    searchMarkers.push(marker);  // 배열에 생성된 마커를 추가합니다

		    return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker(type) {
			//alert("type : " + type);
			if(type==1){
				for ( var i = 0; i < searchMarkers.length; i++ ) {
					searchMarkers[i].setMap(null);
			    }   
				searchMarkers = [];	
			}else{
				for ( var i = 0; i < markers.length; i++ ) {
					markers[i].setMap(null);
			    }   
				markers = [];	
			}
		    
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 

		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }

		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;

		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }

		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}

		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
		   
		////////////////////////////////////////////
		
		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayKisa(positions) {


	    	var listEl = document.getElementById('kisaList')
	    	menuEl = document.getElementById('menu_wrap1'),
	    	fragment = document.createDocumentFragment(), 
		    bounds = new daum.maps.LatLngBounds(), 
		    listStr = '';
		    
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
		    removeAllChildNods(listEl);

		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker(2);
		    
		    
		    //alert(positions.length);
		    for ( var i=0; i<positions.length; i++ ) {

		    	
		        // 마커를 생성하고 지도에 표시합니다
		        var placePosition = new daum.maps.LatLng(positions[i].wk_Lat, positions[i].wk_Lon),
		            marker = addKisaMarker(placePosition, i), 
		            itemEl = getKisaListItem(i, positions[i]); // 검색 결과 항목 Element를 생성합니다

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        //bounds.extend(placePosition);

		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, kisaInfo) {
		            /* daum.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, kisaInfo.wk_Name);
		            });

		            daum.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            }); */

		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, kisaInfo.wk_Name);
		            };

		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		            
		            daum.maps.event.addListener(marker, 'click', function() {
		            	displayKisaInfowindow(marker, kisaInfo);
					  });
		            
		        })(marker, positions[i]);

		        fragment.appendChild(itemEl);
		    }

		    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;

		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    //map.setBounds(bounds);
		}
		
		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayKisaInfowindow(marker, kisaInfo) {
		    //var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		    var CustomOverlay = new daum.maps.CustomOverlay({
	 		    //content: content,
	 		    map: map,
	 		    position: marker.getPosition()     
	 		   
	 		});
 			if (clickedOverlay) {
		        clickedOverlay.setMap(null);
		    }
		    CustomOverlay.setMap(map);
		    clickedOverlay = CustomOverlay;
		    
		    
		    var sMode = null;
	    		if(kisaInfo.wk_Mode == 0){
	    			sMode = "(배송모드[대기중])";
	    		} else if(kisaInfo.wk_Mode == 1){
	    			sMode = "(배송모드[배송중])";
	    		} else if(kisaInfo.wk_Mode == 2){
	    			sMode = "(휴식모드)";
	    		}
	    		
 			 //마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 시작
			var Customcontent = document.createElement('div');
			Customcontent.className = "wrap";

			var info = document.createElement('div');
			info.className = "info"			
			Customcontent.appendChild(info);

			//커스텀오버레이 타이틀
			var contentTitle = document.createElement("div");
			contentTitle.className = "title"
			contentTitle.appendChild(document.createTextNode(kisaInfo.wk_Name + " " + sMode));
			info.appendChild(contentTitle);

			//커스텀오버레이 닫기 버튼
			var closeBtn = document.createElement("div");
			closeBtn.className = "close";
			closeBtn.setAttribute("title","닫기");
			closeBtn.onclick = function() { CustomOverlay.setMap(null); };
			contentTitle.appendChild(closeBtn);

			var bodyContent = document.createElement("div");
			bodyContent.className = "body";
			info.appendChild(bodyContent);

			var imgDiv = document.createElement("div");
			imgDiv.className = "img";
			bodyContent.appendChild(imgDiv);

			//커스텀오버레이 이미지
			var imgContent = document.createElement("img");
			imgContent.setAttribute("src", "http://localhost:8081/spring/resources/upload/"+kisaInfo.wk_Picture);
			//imgContent.setAttribute("src", "http://cfile181.uf.daum.net/image/250649365602043421936D");
			imgContent.setAttribute("width", "73");
			imgContent.setAttribute("heigth", "70");
			imgDiv.appendChild(imgContent);

			var descContent = document.createElement("div");
			descContent.className = "desc"
			bodyContent.appendChild(descContent);

			//커스텀오버레이 주소			
			var addressContent = document.createElement("div");
			addressContent.className = "ellipsis";
			addressContent.appendChild(document.createTextNode(kisaInfo.wk_Phone));
			descContent.appendChild(addressContent);

			//커스텀오버레이 지번주소
			var address2Content = document.createElement("div");
			address2Content.className = "jibun ellipsis";
			address2Content.appendChild(document.createTextNode(kisaInfo.wk_Phone));
			descContent.appendChild(address2Content);

			var LinkDiv = document.createElement("div");
			descContent.appendChild(LinkDiv);

			//커스텀오버레이 링크
			var LinkContent = document.createElement("a");
/* 						if (url == "")
			{
				url = "javascript:"
			}
			LinkContent.setAttribute("href", url);
			if (url != "javascript:")
			{
				LinkContent.setAttribute("target", "_blank");
			} */
			
			LinkContent.setAttribute("href", "javascript:sendMessage(\'"+kisaInfo.wk_Token+"\')");
			LinkContent.className = "link";
			LinkContent.appendChild(document.createTextNode("메시지"));
			LinkDiv.appendChild(LinkContent);
			//마커 위에 커스텀오버레이 콘텐츠 Dom으로 구현 끝

			CustomOverlay.setContent(Customcontent);
			 
			
			/* daum.maps.event.addListener(marker, 'click', function() {
			    if (clickedOverlay) {
			        clickedOverlay.setMap(null);
			    }
			    CustomOverlay.setMap(map);
			    clickedOverlay = CustomOverlay;
			  }); */
			  
			  
			  
		    //infowindow.setContent(Customcontent);
		    //infowindow.open(map, marker);
		}
		
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addKisaMarker(position, idx, title) {
		    var imageSrc = './resources/map/kisaMarker.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new daum.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });

		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

		    return marker;
		}
		
		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getKisaListItem(index, position) {

		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + position.wk_Name + '</h5>';

		    /* if (places.road_address_name) {
		        itemStr += '    <span>' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>' +  places.address_name  + '</span>'; 
		    } */
		                 
		      itemStr += '  <span class="tel">' + position.wk_Phone  + '</span>' +
		                '</div>';           

		    el.innerHTML = itemStr;
		    el.className = 'item';

		    return el;
		}
		//////
		
		// 키워드 검색을 요청하는 함수입니다
		function searchKisa() {

		    var keyword = document.getElementById('keywordKisa').value;

		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }

		    alert(keyword);
		    
		    /* for(var i=0; i<searchKisaMarkers.length; i++){
		    	if(searchKisaMarkers[i].equals(keyword)){
		    		alert("일치");
		    		break;
		    	}
		    } */
		    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		    //ps.keywordSearch( keyword, placesSearchCB); 
		}
		
		/* // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === daum.maps.services.Status.OK) {

		        // 정상적으로 검색이 완료됐으면
		        // 검색 목록과 마커를 표출합니다
		        displayPlaces(data);

		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);

		    } else if (status === daum.maps.services.Status.ZERO_RESULT) {

		        alert('검색 결과가 존재하지 않습니다.');
		        return;

		    } else if (status === daum.maps.services.Status.ERROR) {

		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;

		    }
		} */
	</script>
	
	<!-- Modal -->
	<div id="sendMessageModal" class="modal fade" id="exampleModalLong" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLongTitle"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">메시지 보내기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				
				 <form id="messageForm" name="messageForm">
				          <div class="form-group">
				          	<input type="hidden" id="tokens" name="tokens" value="tokenValue">
				            <label for="recipient-name" class="col-form-label">보낼 메시지를 적어주세요</label>
							<div>
							<input type="text" class="form-control" id="messageBody" name="messageBody" placeholder="메시지">
				          </div>
				          </div>
		        </form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" onclick="sendMessagesave();" class="btn btn-secondary">전송하기</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	
</body>
</html>
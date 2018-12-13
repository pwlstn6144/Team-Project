<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="./resources/map/map.css" type="text/css" />
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0272a5541ea760d1155d14ce7723f0b7&libraries=services,LIBRARY,clusterer,drawing"></script>
<script src="http://code.jquery.com/jquery.js"></script>

</head>
<body>
	
	
	<div class="map_wrap">
	    <div id="map" style="width:1000px;height:730px;position:relative;overflow:hidden;"></div>
	
	    <div id="menu_wrap" class="bg_white">
	        <div class="option">
	            <div>
	                <form onsubmit="searchPlaces(); return false;">
	                    키워드 : <input type="text" value="서울 지하철" id="keyword" size="15"> 
	                    <button type="submit">검색하기</button> 
	                </form>
	            </div>
	        </div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
		</div>
		
		<div class="category">
	        <ul>
	            <li id="coffeeMenu" onclick="changeMarker('coffee')">
	                <span class="ico_comm ico_coffee"></span>
	                커피숍
	            </li>
	            <li id="storeMenu" onclick="changeMarker('store')">
	                <span class="ico_comm ico_store"></span>
	                편의점
	            </li>
	            <li id="carparkMenu" onclick="changeMarker('carpark')">
	                <span class="ico_comm ico_carpark"></span>
	                주차장
	            </li>
	        </ul>
    	</div>
    	
    	
	</div>
	

	<script>
 	
		// 커피숍 마커가 표시될 좌표 배열입니다
		var coffeePositions = [ 
		    new daum.maps.LatLng(37.499590490909185, 127.0263723554437),
		    new daum.maps.LatLng(37.499427948430814, 127.02794423197847),
		    new daum.maps.LatLng(37.498553760499505, 127.02882598822454),
		    new daum.maps.LatLng(37.497625593121384, 127.02935713582038),
		    new daum.maps.LatLng(37.49646391248451, 127.02675574250912),
		    new daum.maps.LatLng(37.49629291770947, 127.02587362608637),
		    new daum.maps.LatLng(37.49754540521486, 127.02546694890695)                
		];
	
		// 편의점 마커가 표시될 좌표 배열입니다
		var storePositions = [
		    new daum.maps.LatLng(37.497535461505684, 127.02948149502778),
		    new daum.maps.LatLng(37.49671536281186, 127.03020491448352),
		    new daum.maps.LatLng(37.496201943633714, 127.02959405469642),
		    new daum.maps.LatLng(37.49640072567703, 127.02726459882308),
		    new daum.maps.LatLng(37.49640098874988, 127.02609983175294),
		    new daum.maps.LatLng(37.49932849491523, 127.02935780247945),
		    new daum.maps.LatLng(37.49996818951873, 127.02943721562295)
		];
	
		// 주차장 마커가 표시될 좌표 배열입니다
		var carparkPositions = [
		    new daum.maps.LatLng(37.49966168796031, 127.03007039430118),
		    new daum.maps.LatLng(37.499463762912974, 127.0288828824399),
		    new daum.maps.LatLng(37.49896834100913, 127.02833986892401),
		    new daum.maps.LatLng(37.49893267508434, 127.02673400572665),
		    new daum.maps.LatLng(37.49872543597439, 127.02676785815386),
		    new daum.maps.LatLng(37.49813096097184, 127.02591949495914),
		    new daum.maps.LatLng(37.497680616783086, 127.02518427952202)                       
		];    
		
		var markerImageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png';  // 마커이미지의 주소입니다. 스프라이트 이미지 입니다
	    coffeeMarkers = [], // 커피숍 마커 객체를 가지고 있을 배열입니다
	    storeMarkers = [], // 편의점 마커 객체를 가지고 있을 배열입니다
	    carparkMarkers = []; // 주차장 마커 객체를 가지고 있을 배열입니다
	
	    
		createCoffeeMarkers(); // 커피숍 마커를 생성하고 커피숍 마커 배열에 추가합니다
		createStoreMarkers(); // 편의점 마커를 생성하고 편의점 마커 배열에 추가합니다
		createCarparkMarkers(); // 주차장 마커를 생성하고 주차장 마커 배열에 추가합니다
		
		changeMarker('coffee'); // 지도에 커피숍 마커가 보이도록 설정합니다    

		//////////////////////////////////////////////////
		
		// 마커를 담을 배열입니다
		var markers = [];
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new daum.maps.LatLng(37.57811, 126.98044), // 지도의 중심좌표
		        level: 9, // 지도의 확대 레벨
		        mapTypeId : daum.maps.MapTypeId.ROADMAP // 지도종류
		    }; 

		// 지도를 생성한다 
		var map = new daum.maps.Map(mapContainer, mapOption); 

 		// 장소 검색 객체를 생성합니다
		var ps = new daum.maps.services.Places();  
		
 		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new daum.maps.InfoWindow({zIndex:1});
		
		// 지도에 마커를 생성하고 표시한다
		var marker = new daum.maps.Marker({
		    position: new daum.maps.LatLng(37.478933, 126.878906), // 마커의 좌표
		    map: map // 마커를 표시할 지도 객체
		});
 		
		// 키워드로 장소를 검색합니다
		searchPlaces();

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
		    removeMarker();
		    
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
		    map.setBounds(bounds);
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
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

		    return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
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

		////////////////////////////////////////////
 
		// 마커 클러스터러를 생성합니다 
	    var clusterer = new daum.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        minLevel: 9 // 클러스터 할 최소 지도 레벨 
	    });
	 
	    // 데이터를 가져오기 위해 jQuery를 사용합니다
	    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	    $.get("./resources/sample_data/chicken.json", function(data) {
	        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	        
	        
	        var markers = $(data.positions).map(function(i, position) {
	            return new daum.maps.Marker({
	                position : new daum.maps.LatLng(position.lat, position.lng)
	            });
	        });

	        // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers);
	    });
	     
	    ////////////////////////////////////////////
 	    
	    // 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
		function createMarkerImage(src, size, options) {
		    var markerImage = new daum.maps.MarkerImage(src, size, options);
		    return markerImage;            
		}
		
		// 좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
		function createMarker(position, image) {
		    var marker = new daum.maps.Marker({
		        position: position,
		        image: image
		    });
		    
		    return marker;  
		}   
		   
		// 커피숍 마커를 생성하고 커피숍 마커 배열에 추가하는 함수입니다
		function createCoffeeMarkers() {
		    
		    for (var i = 0; i < coffeePositions.length; i++) {  
		        
		        var imageSize = new daum.maps.Size(22, 26),
		            imageOptions = {  
		                spriteOrigin: new daum.maps.Point(10, 0),    
		                spriteSize: new daum.maps.Size(36, 98)  
		            };     
		        
		        // 마커이미지와 마커를 생성합니다
		        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
		            marker = createMarker(coffeePositions[i], markerImage);  
		        
		        // 생성된 마커를 커피숍 마커 배열에 추가합니다
		        coffeeMarkers.push(marker);
		    }     
		}
		
		// 커피숍 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setCoffeeMarkers(map) {        
		    for (var i = 0; i < coffeeMarkers.length; i++) {  
		        coffeeMarkers[i].setMap(map);
		    }        
		}
		
		// 편의점 마커를 생성하고 편의점 마커 배열에 추가하는 함수입니다
		function createStoreMarkers() {
		    for (var i = 0; i < storePositions.length; i++) {
		        
		        var imageSize = new daum.maps.Size(22, 26),
		            imageOptions = {   
		                spriteOrigin: new daum.maps.Point(10, 36),    
		                spriteSize: new daum.maps.Size(36, 98)  
		            };       
		     
		        // 마커이미지와 마커를 생성합니다
		        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
		            marker = createMarker(storePositions[i], markerImage);  
		
		        // 생성된 마커를 편의점 마커 배열에 추가합니다
		        storeMarkers.push(marker);    
		    }        
		}
		
		// 편의점 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setStoreMarkers(map) {        
		    for (var i = 0; i < storeMarkers.length; i++) {  
		        storeMarkers[i].setMap(map);
		    }        
		}
		
		// 주차장 마커를 생성하고 주차장 마커 배열에 추가하는 함수입니다
		function createCarparkMarkers() {
		    for (var i = 0; i < carparkPositions.length; i++) {
		        
		        var imageSize = new daum.maps.Size(22, 26),
		            imageOptions = {   
		                spriteOrigin: new daum.maps.Point(10, 72),    
		                spriteSize: new daum.maps.Size(36, 98)  
		            };       
		     
		        // 마커이미지와 마커를 생성합니다
		        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
		            marker = createMarker(carparkPositions[i], markerImage);  
		
		        // 생성된 마커를 주차장 마커 배열에 추가합니다
		        carparkMarkers.push(marker);        
		    }                
		}
		
		// 주차장 마커들의 지도 표시 여부를 설정하는 함수입니다
		function setCarparkMarkers(map) {        
		    for (var i = 0; i < carparkMarkers.length; i++) {  
		        carparkMarkers[i].setMap(map);
		    }        
		}
		
		// 카테고리를 클릭했을 때 type에 따라 카테고리의 스타일과 지도에 표시되는 마커를 변경합니다
		function changeMarker(type){
		    
		    var coffeeMenu = document.getElementById('coffeeMenu');
		    var storeMenu = document.getElementById('storeMenu');
		    var carparkMenu = document.getElementById('carparkMenu');
		    
		    // 커피숍 카테고리가 클릭됐을 때
		    if (type === 'coffee') {
		    
		        // 커피숍 카테고리를 선택된 스타일로 변경하고
		        coffeeMenu.className = 'menu_selected';
		        
		        // 편의점과 주차장 카테고리는 선택되지 않은 스타일로 바꿉니다
		        storeMenu.className = '';
		        carparkMenu.className = '';
		        
		        // 커피숍 마커들만 지도에 표시하도록 설정합니다
		        setCoffeeMarkers(map);
		        setStoreMarkers(null);
		        setCarparkMarkers(null);
		        
		    } else if (type === 'store') { // 편의점 카테고리가 클릭됐을 때
		    
		        // 편의점 카테고리를 선택된 스타일로 변경하고
		        coffeeMenu.className = '';
		        storeMenu.className = 'menu_selected';
		        carparkMenu.className = '';
		        
		        // 편의점 마커들만 지도에 표시하도록 설정합니다
		        setCoffeeMarkers(null);
		        setStoreMarkers(map);
		        setCarparkMarkers(null);
		        
		    } else if (type === 'carpark') { // 주차장 카테고리가 클릭됐을 때
		     
		        // 주차장 카테고리를 선택된 스타일로 변경하고
		        coffeeMenu.className = '';
		        storeMenu.className = '';
		        carparkMenu.className = 'menu_selected';
		        
		        // 주차장 마커들만 지도에 표시하도록 설정합니다
		        setCoffeeMarkers(null);
		        setStoreMarkers(null);
		        setCarparkMarkers(map);  
		    }    
		}  
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.setAttribute("bUrl", "deliveryRequest"); 
String member = (String)session.getAttribute("member");
if(session.getAttribute("id") == null) {%>
	<jsp:forward page="/LoginForm" />
<%} %>
<%String id = (String)session.getAttribute("id");%>
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


<title>JibaeIn 지하철 택배</title>
 <script src="http://code.jquery.com/jquery.js"></script>

<script type="text/javascript" src="./naver_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDkOYoOUAA5i93hagnc47sOmK2eYFCVIrM&callback=geo"
  type="text/javascript"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false""></script>
</head>
<body class="bg-light">
<script>  
	function openChatt(){  
	    window.open("http://ec2-54-180-109-151.ap-northeast-2.compute.amazonaws.com:8081/spring/chatt", "관리자 대화방", "width=1200, height=850, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}  
 
</script>
<script type="text/javascript">
	function geo(startFull, endFull){
		var geocoder = new google.maps.Geocoder();
        var geocoder2 = new google.maps.Geocoder();
		
        var start_Lat = document.getElementById("start_Lat");
    	var start_Lon = document.getElementById("start_Lon");
    	var arrive_Lat = document.getElementById("arrive_Lat");
    	var arrive_Lon = document.getElementById("arrive_Lon");
        var start_zip = document.getElementById('start');
        var end_zip = document.getElementById('arrive');
        var address;


        geocoder.geocode({'address': startFull}, function(results, status) {
          if (status === google.maps.GeocoderStatus.OK) {
            start_Lat.value=results[0].geometry.location.lat();
    	    start_Lon.value=results[0].geometry.location.lng();
			
          } else {

          }
        });
        
        geocoder2.geocode({'address': endFull}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
            	arrive_Lat.value=results[0].geometry.location.lat();
            	arrive_Lon.value=results[0].geometry.location.lng();
	        	document.deliveryRequest.submit();
            } else {

            }
            
          });

	}
	
	function form_check(){
		var start_address = document.getElementById("start_address");
		var start_details = document.getElementById("start_details");
        var start_Lat = document.getElementById("start_Lat");
    	var start_Lon = document.getElementById("start_Lon");
    	
    	var arrive_address = document.getElementById("arrive_address");
		var arrive_details = document.getElementById("arrive_details");
    	var arrive_Lat = document.getElementById("arrive_Lat");
    	var arrive_Lon = document.getElementById("arrive_Lon");
    	
        var start = document.getElementById('start');
        var arrive = document.getElementById('arrive');
        
		var kind = document.getElementsByName("kind");
		var cstName = document.getElementById("cstName");
		var cstPhone = document.getElementById("cstPhone");
		var arriveName = document.getElementById("arriveName");
		var arrivePhone = document.getElementById("arrivePhone");
		var orderKind = document.getElementById("orderKind");
		var direction = document.getElementsByName("direction");
		var direct = document.getElementById("direct");
		var endName = document.getElementById("endName");
		var endPhone = document.getElementById("endPhone");
		var ir1 = document.getElementById("ir1");
		var bContent = document.getElementById("bContent");
		
		for(var i = 0; i < kind.length; i++){
			if(kind[i].checked == true){
				orderKind.value = kind[i].value;
			}
		}
		for(var i = 0; i < direction.length; i++){
			if(direction[i].checked == true){
				direct.value = direction[i].value;
			}
		}

	    if(cstName.value == ""){
	    	alert("보내는 분을 입력하세요.");
	    	cstName.focus();
	    	return;
	    }
	    else if(start_address.value == ""){
	    	alert("정확한 주소를 입력하세요");
	    	start_address.focus();
	    	return;
	    }
	    else if(arrive_address.value == ""){
	    	alert("정확한 주소를 입력하세요");
	    	arrive_address.focus();
	    	return;
	    }
	    else if(arrive_details.value == ""){
	    	alert("정확한 주소를 입력하세요");
	    	arrive_address.focus();
	    	return;
	    }
	    else if(start_details.value == ""){
	    	alert("정확한 주소를 입력하세요");
	    	start_details.focus();
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
		bContent.value = ir1.value;
		start.value = start_address.value + " " + start_details.value;
		arrive.value = arrive_address.value + " " + arrive_details.value;
		endName.value = arriveName.value;
		endPhone.value = arrivePhone.value;
		var startFull = start.value;
		var strArray = startFull.split(" ");
		
		var endFull = arrive.value;
		var endArray = endFull.split(" ");
		
		if(strArray[0] == "서울특별시" || strArray[0] == "경기도" || strArray[0] == "경기" || strArray[0] == "서울"){

			if(endArray[0] == "서울특별시" || endArray[0] == "경기도" || strArray[0] == "경기" || strArray[0] == "서울"){

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

		geo(start.value, arrive.value);
		
	}
	
	
	
	function startLocation(){
		var cst_Id = document.getElementById("cst_Id");
		var firstStart = document.getElementById("firstStart");
		var firstStartDetails = document.getElementById("firstStartDetails");
		var secondStart = document.getElementById("secondStart");
		var secondStartDetails = document.getElementById("secondStartDetails");
		var thirdStart = document.getElementById("thirdStart");
		var thirdStartDetails = document.getElementById("thirdStartDetails");
		$.ajax({
			url:'./startLocation',
			type: 'POST',
			data : {cst_Id:cst_Id.value},
			dataType:'json',
			success : function(json){
				var results = eval(json);
				if(results.result=="ok"){
					firstStart.value = results.cst_zip1;
					firstStartDetails.value = results.cst_detail1;
					secondStart.value = results.cst_zip2;
					secondStartDetails.value = results.cst_detail2;
					thirdStart.value = results.cst_zip3
					thirdStartDetails.value = results.cst_detail3;
				}
				else{
						
				}
			}			
		});
		
			
	}
	
	function arriveLocation(){

		var cst_Id = document.getElementById("cst_Id");
		var firstEnd = document.getElementById("firstEnd");
		var firstEndDetails = document.getElementById("firstEndDetails");
		var secondEnd = document.getElementById("secondEnd");
		var secondEndDetails = document.getElementById("secondEndDetails");
		var thirdEnd = document.getElementById("thirdEnd");
		var thirdEndDetails = document.getElementById("thirdEndDetails");
		$.ajax({
			url:'./arriveLocation',
			type: 'POST',
			data : {cst_Id:cst_Id.value},
			dataType:'json',
			success : function(json){
				var results = eval(json);
				if(results.result=="ok"){
					firstEnd.value = results.arrive_zip1;
					firstEndDetails.value = results.arrive_detail1;
					secondEnd.value = results.arrive_zip2;
					secondEndDetails.value = results.arrive_detail2;
					thirdEnd.value = results.arrive_zip3
					thirdEndDetails.value = results.arrive_detail3;
				}
				else{
						
				}
			}			
		});
		
			
	}
	
	
	
</script>
<script>
	function zipSave(){
		var check;
		var address;
		var detail;
		var zip = document.getElementsByName("zip");
		var firstStart = document.getElementById("firstStart");
		var firstStartDetails = document.getElementById("firstStartDetails");
		var secondStart = document.getElementById("secondStart");
		var secondStartDetails = document.getElementById("secondStartDetails");
		var thirdStart = document.getElementById("thirdStart");
		var thirdStartDetails = document.getElementById("thirdStartDetails");
		var cst_Id = document.getElementById("cst_Id");
		for(var i = 0; i < zip.length; i++){
			if(zip[i].checked == true){
				if(zip[i].value == "first"){
					if(firstStart.value == "" || firstStartDetails.value == ""){
						alert("정확한 주소를 입력하세요");
					}
					else{
						check = zip[i].value;
						address = firstStart.value;
						detail = firstStartDetails.value;
					}
				}
				else if(zip[i].value == "second"){
					if(secondStart.value == "" || secondStartDetails.value == ""){
						alert("정확한 주소를 입력하세요");
					}
					else{
						check = zip[i].value;
						address = secondStart.value;
						detail = secondStartDetails.value;
					}
				}
				else if(zip[i].value == "third"){
					if(thirdStart.value == "" || thirdStartDetails.value == ""){
						alert("정확한 주소를 입력하세요");
					}
					else{
						check = zip[i].value;
						address = thirdStart.value;
						detail = thirdStartDetails.value;
					}
				}
			}
		}
		$.ajax({
			url:'./zipSaveCon',
			type: 'POST',
			data : {check:check, cst_Id:cst_Id.value, address:address, detail:detail},
			dataType:'json',
			success : function(json){			
				var results = eval(json);
				if(results.result=="ok"){
					alert("저장되었습니다.");
				}
				else{
					alert("aaaaa");
				}
			}			
		});

		
	}
	
	function arriveSave(){
		var check;
		var address;
		var detail;
		var zip2 = document.getElementsByName("zip2");
		var firstEnd = document.getElementById("firstEnd");
		var firstEndDetails = document.getElementById("firstEndDetails");
		var secondEnd = document.getElementById("secondEnd");
		var secondEndDetails = document.getElementById("secondEndDetails");
		var thirdEnd = document.getElementById("thirdEnd");
		var thirdEndDetails = document.getElementById("thirdEndDetails");
		var cst_Id = document.getElementById("cst_Id");
		for(var i = 0; i < zip2.length; i++){
			if(zip2[i].checked == true){
				if(zip2[i].value == "first"){
					if(firstEnd.value == "" || firstEndDetails.value == ""){
						alert("정확한 주소를 입력하세요");
					}
					else{
						check = zip2[i].value;
						address = firstEnd.value;
						detail = firstEndDetails.value;
					}
				}
				else if(zip2[i].value == "second"){
					if(secondEnd.value == "" || secondEndDetails.value == ""){
						alert("정확한 주소를 입력하세요");
					}
					else{
						check = zip2[i].value;
						address = secondEnd.value;
						detail = secondEndDetails.value;
					}
				}
				else if(zip2[i].value == "third"){
					if(thirdEnd.value == "" || thirdEndDetails.value == ""){
						alert("정확한 주소를 입력하세요");
					}
					else{
						check = zip2[i].value;
						address = thirdEnd.value;
						detail = thirdEndDetails.value;
					}
				}
			}
		}
		
		$.ajax({
			url:'./arriveSave',
			type: 'POST',
			data : {check:check, cst_Id:cst_Id.value, address:address, detail:detail},
			dataType:'json',
			success : function(json){			
				var results = eval(json);
				if(results.result=="ok"){
					alert("저장되었습니다.");
				}
				else{
					alert("bbbbbb");
				}
			}			
		});
		
		
	}

</script>
<script>
	function startInput() {
		new daum.Postcode({
			oncomplete: function(data) {			            	 
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수
				
				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				   fullAddr = data.roadAddress;
				
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
				   fullAddr = data.jibunAddress;
				}
				
				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if(data.userSelectedType === 'R'){
				//법정동명이 있을 경우 추가한다.
				  if(data.bname !== ''){
				  	extraAddr += data.bname;
				  }
				  // 건물명이 있을 경우 추가한다.
				  if(data.buildingName !== ''){
				     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				  }
				  // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				  fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
				}
				
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('start_address').value = fullAddr;
				
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById('start_details').focus();
				}
			}).open();
		}
</script>
<script>
	function arriveInput() {
		new daum.Postcode({
			oncomplete: function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수
				
				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				   fullAddr = data.roadAddress;
				
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
				  fullAddr = data.jibunAddress;
				}
				
				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if(data.userSelectedType === 'R'){
				   //법정동명이 있을 경우 추가한다.
				   if(data.bname !== ''){
				      extraAddr += data.bname;
				   }
				      // 건물명이 있을 경우 추가한다.
				   if(data.buildingName !== ''){
				     extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				   }
				    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
				   fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
				}
				
				 // 우편번호와 주소 정보를 해당 필드에 넣는다.

				 document.getElementById('arrive_address').value = fullAddr;
				
				// 커서를 상세주소 필드로 이동한다.
				 document.getElementById('arrive_details').focus();
			}
		}).open();
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function startFavorites() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
				var zip = document.getElementsByName("zip");
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				for(var i = 0; i < zip.length; i++){
					if(zip[i].checked == true){
						if(zip[i].value == "first"){
							document.getElementById('firstStart').value = fullAddr;
				            // 커서를 상세주소 필드로 이동한다.
				            document.getElementById('firstStartDetails').focus();
						}
						else if(zip[i].value == "second"){
							document.getElementById('secondStart').value = fullAddr;
				            // 커서를 상세주소 필드로 이동한다.
				            document.getElementById('secondStartDetails').focus();
						}
						else if(zip[i].value == "third"){
							document.getElementById('thirdStart').value = fullAddr;
				            // 커서를 상세주소 필드로 이동한다.
				            document.getElementById('thirdStartDetails').focus();
						}
					}
				}

            }
        }).open();
    }
    function endFavorites() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
                var zip2 = document.getElementsByName("zip2");
                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
				for(var i = 0; i < zip2.length; i++){
					if(zip2[i].checked == true){
						if(zip2[i].value == "first"){
							document.getElementById('firstEnd').value = fullAddr;
				            // 커서를 상세주소 필드로 이동한다.
				            document.getElementById('firstEndDetails').focus();
						}
						else if(zip2[i].value == "second"){
							document.getElementById('secondEnd').value = fullAddr;
				            // 커서를 상세주소 필드로 이동한다.
				            document.getElementById('secondEndDetails').focus();
						}
						else if(zip2[i].value == "third"){
							document.getElementById('thirdEnd').value = fullAddr;
				            // 커서를 상세주소 필드로 이동한다.
				            document.getElementById('thirdEndDetails').focus();
						}
					}
				}
  
            }
        }).open();
    }
</script>	
<script>
	function btnAbled(){
		var firstStart = document.getElementById("firstStart");
		var firstStartDetails = document.getElementById("firstStartDetails");
		var secondStart = document.getElementById("secondStart");
		var secondStartDetails = document.getElementById("secondStartDetails");
		var thirdStart = document.getElementById("thirdStart");
		var thirdStartDetails = document.getElementById("thirdStartDetails");
		
		var firstEnd = document.getElementById("firstEnd");
		var firstEndDetails = document.getElementById("firstEndDetails");
		var secondEnd = document.getElementById("secondEnd");
		var secondEndDetails = document.getElementById("secondEndDetails");
		var thirdEnd = document.getElementById("thirdEnd");
		var thirdEndDetails = document.getElementById("thirdEndDetails");
		
		var startModify1 = document.getElementById("startModify1");
		var startModify2 = document.getElementById("startModify2");
		var startModify3 = document.getElementById("startModify3");
		
		var arriveModify3 = document.getElementById("arriveModify3");
		var arriveModify2 = document.getElementById("arriveModify2");
		var arriveModify1 = document.getElementById("arriveModify1");
		
		var addressSelect1 = document.getElementById("addressSelect1");
		var addressSelect2 = document.getElementById("addressSelect2");
		
		var startSave1 = document.getElementById("startSave1");
		var startSave2 = document.getElementById("startSave2");
		var startSave3 = document.getElementById("startSave3");
		
		var endSave1 = document.getElementById("endSave1");
		var endSave2 = document.getElementById("endSave2");
		var endSave3 = document.getElementById("endSave3");
		
		var zip1 = document.getElementsByName("zip");
		var zip2 = document.getElementsByName("zip2");
		
		for(var i = 0; i <zip1.length; i++){
			if(zip1[i].checked == true){
				if(zip1[i].value == "first"){
					startModify1.disabled = false;
					startModify2.disabled = "disabled";
					startModify3.disabled = "disabled";
					startSave1.disabled = false;
					startSave2.disabled = "disabled";
					startSave3.disabled = "disabled";
					firstStart.disabled = false;
					firstStartDetails.disabled = false;
					secondStart.disabled = "disabled";
					secondStartDetails.disabled = "disabled";
					thirdStart.disabled = "disabled";
					thirdStartDetails.disabled = "disabled";
					addressSelect1.disabled = false;
				}
				else if(zip1[i].value == "second"){
					startModify2.disabled = false;
					startModify1.disabled = "disabled";
					startModify3.disabled = "disabled";
					startSave2.disabled = false;
					startSave3.disabled = "disabled";
					startSave1.disabled = "disabled";
					firstStart.disabled = "disabled";
					firstStartDetails.disabled = "disabled";
					secondStart.disabled = false;
					secondStartDetails.disabled = false;
					thirdStart.disabled = "disabled";
					thirdStartDetails.disabled = "disabled";
					addressSelect1.disabled = false;
				}
				else if(zip1[i].value == "third"){
					startModify3.disabled = false;
					startModify2.disabled = "disabled";
					startModify1.disabled = "disabled";
					startSave3.disabled = false;
					startSave2.disabled = "disabled";
					startSave1.disabled = "disabled";
					firstStart.disabled = "disabled";
					firstStartDetails.disabled = "disabled";
					secondStart.disabled = "disabled";
					secondStartDetails.disabled = "disabled";
					thirdStart.disabled = false;
					thirdStartDetails.disabled = false;
					addressSelect1.disabled = false;
				}
			}
		}
		for(var i = 0; i < zip2.length; i++){
			if(zip2[i].checked == true){
				if(zip2[i].value == "first"){
					arriveModify1.disabled = false;
					arriveModify2.disabled = "disabled";
					arriveModify3.disabled = "disabled";
					endSave1.disabled = false;
					endSave2.disabled = "disabled";
					endSave3.disabled = "disabled";
					firstEnd.disabled = false;
					firstEndDetails.disabled = false;
					secondEnd.disabled = "disabled";
					secondEndDetails.disabled = "disabled";
					thirdEnd.disabled = "disabled";
					thirdEndDetails.disabled = "disabled";
					addressSelect2.disabled = false;
				}
				else if(zip2[i].value == "second"){
					arriveModify2.disabled = false;
					arriveModify3.disabled = "disabled";
					arriveModify1.disabled = "disabled";
					endSave2.disabled = false;
					endSave3.disabled = "disabled";
					endSave1.disabled = "disabled";
					firstEnd.disabled = "disabled";
					firstEndDetails.disabled = "disabled";
					secondEnd.disabled = false;
					secondEndDetails.disabled = false;
					thirdEnd.disabled = "disabled";
					thirdEndDetails.disabled = "disabled";
					addressSelect2.disabled = false;
				}
				else if(zip2[i].value == "third"){
					arriveModify3.disabled = false;
					arriveModify2.disabled = "disabled";
					arriveModify1.disabled = "disabled";
					endSave3.disabled = false;
					endSave2.disabled = "disabled";
					endSave1.disabled = "disabled";
					firstEnd.disabled = "disabled";
					firstEndDetails.disabled = "disabled";
					secondEnd.disabled = "disabled";
					secondEndDetails.disabled = "disabled";
					thirdEnd.disabled = false;
					thirdEndDetails.disabled = false;
					addressSelect2.disabled = false;
				}
			}
		}
	}
</script>
<script>
	function selectStart(){
		var zip = document.getElementsByName("zip");
		var start_address = document.getElementById("start_address");
		var start_details = document.getElementById("start_details");
		var firstStart = document.getElementById("firstStart");
		var firstStartDetails = document.getElementById("firstStartDetails");
		var secondStart = document.getElementById("secondStart");
		var secondStartDetails = document.getElementById("secondStartDetails");
		var thirdStart = document.getElementById("thirdStart");
		var thirdStartDetails = document.getElementById("thirdStartDetails");
		for(var i = 0; i < zip.length; i++){
			if(zip[i].checked == true){
				if(zip[i].value == "first"){
					if(firstStart.value == "" || firstStartDetails.value == ""){
						alert("정확한 주소를 입력하세요");
						return;
					}
					else{
						start_address.value = firstStart.value;
						start_details.value = firstStartDetails.value;
					}
					
				}
				else if(zip[i].value == "second"){
					if(secondStart.value == "" || secondStartDetails.value == ""){
						alert("정확한 주소를 입력하세요");
						return;
					}
					else{
						start_address.value = secondStart.value;
						start_details.value = secondStartDetails.value;
					}
					

				}
				else if(zip[i].value == "third"){
					if(thirdStart.value == "" || thirdStartDetails.value == ""){
						alert("정확한 주소를 입력하세요");
						return;
					}
					else {
						start_address.value = thirdStart.value;
						start_details.value = thirdStartDetails.value;
					}
					
				}
			}
		}
	}
	
	function selectAddress(){
		var zip2 = document.getElementsByName("zip2");
		var firstEnd = document.getElementById("firstEnd");
		var firstEndDetails = document.getElementById("firstEndDetails");
		var secondEnd = document.getElementById("secondEnd");
		var secondEndDetails = document.getElementById("secondEndDetails");
		var thirdEnd = document.getElementById("thirdEnd");
		var thirdEndDetails = document.getElementById("thirdEndDetails");
		var arrive_address = document.getElementById("arrive_address");
		var arrive_details = document.getElementById("arrive_details");
		
		for(var i = 0; i < zip2.length; i++){
			if(zip2[i].checked == true){
				if(zip2[i].value == "first"){
					if(firstEnd.value == "" || firstEndDetails.value == ""){
						alert("정확한 주소를 입력하세요");
						return;
					}
					else {
						arrive_address.value = firstEnd.value;
						arrive_details.value = firstEndDetails.value;
					}
					
				}
				else if(zip2[i].value == "second"){
					if(secondEnd.value == "" || secondEndDetails.value == ""){
						alert("정확한 주소를 입력하세요");
						return;
					}
					else {
						arrive_address.value = secondEnd.value;
						arrive_details.value = secondEndDetails.value;
					}
					

				}
				else if(zip2[i].value == "third"){
					if(thirdEnd.value == "" || thirdEndDetails.value == ""){
						alert("정확한 주소를 입력하세요");
						return;
					}
					else{
						arrive_address.value = thirdEnd.value;
						arrive_details.value = thirdEndDetails.value;
					}
					
				}
			}
		}
	}
	
</script>

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
          		
          	</div>
       		<div class="col-4 text-center">
            	<a class="blog-header-logo text-dark" href="deliveryRequest">배송 신청</a>
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
		<button type="button" class="btn btn-outline-secondary btn-lg"  onclick="javascript:window.location='pay_info'" aria-haspopup="true" aria-expanded="false">
		   요금표
		</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%if(member == null || member.equals("customer")){%>
		<div class="btn-group">
		  <button type="button" class="btn btn-outline-secondary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		 	배송
		  </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="deliveryRequest">배송 신청</a>
		    <a class="dropdown-item" href="tracking">배송 조회</a>
		  </div>
		</div>
		<%} else if(member.equals("worker") || member.equals("master")) {%>
		 <button type="button" class="btn btn-outline-secondary btn-lg" aria-haspopup="true"  onclick="javascript:window.location='tracking'" aria-expanded="false">
		   배송 조회
		 </button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <%} %>
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
        <br />

	<div class="row">
		<div class="col-md-12 order-md-1">
		<form name="deliveryRequest" class="needs-validation" action="delivery_View" method="post" novalidate>
			<input type="hidden" id="cst_Id" name="cst_id" value="<%=id %>">
			<input type="hidden" id="start_Lat" name="start_Lat">
			<input type="hidden" id="start_Lon" name="start_Lon">
			<input type="hidden" id="arrive_Lat" name="arrive_Lat">
			<input type="hidden" id="arrive_Lon" name="arrive_Lon">
			<input type="hidden" id="orderKind" name="orderKind">
			<input type="hidden" id="direct" name="direct">
			<input type="hidden" name="start_zip" id="start">
			<input type="hidden" name="arrive_zip" id="arrive">
			<input type="hidden" name="endName" id="endName">
			<input type="hidden" name="endPhone" id="endPhone">
			<input type="hidden" name="bContent" id="bContent">
			<div class="row">
				<div class="col-md-6 mb-3">
					 <label for="startName">보내는 분(이름)</label><br>
					<input type="text" name="cst_Name" id=cstName required>
					<div class="invalid-feedback">
                  		이름을 입력하세요
                	</div>
                </div>
			</div>
			
			<div class="mb-3">
				<label for="startPhone">보내는 분(전화번호)</label><br>
				<input type="text" name="cst_Phone" id=cstPhone placeholder="-은 제외하세요." required>
				<div class="invalid-feedback">
                  	전화번호를 입력하세요
                </div>
            </div>
			

			<div class="mb-3">
              	<label for="startAddress">출발지</label>
              	 &nbsp;&nbsp;&nbsp;
              	<button type="button" class="btn btn-outline-primary" onclick="startInput()">주소 검색</button> &nbsp;&nbsp;&nbsp;
              	<button type="button" class="btn btn-outline-success" onclick="startLocation()" data-toggle="modal" data-target="#startModal" data-whatever="@mdo">즐겨찾기</button><br>
              	<div class="modal fade bd-example-modal-lg" id="startModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					 <div class="modal-dialog modal-lg" role="document">
					    <div class="modal-content">
					      	<div class="modal-header">
					        	<h3 class="modal-title" id="exampleModalLabel">등록된 출발지 주소</h3>
					        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          		<span aria-hidden="true">&times;</span>
					        	</button>
					      	</div>
					      	<div class="modal-body">
					      	<form>
					      		<div class="form-group">
									<div class="row">
						     			<div class="col-sm-12">
							            	<h3><label for="recipient-name" class="col-form-label"><input type="radio" name="zip" id="firstStartZip" value="first" onclick="btnAbled()"> &nbsp;첫번째 주소</label></h3>
							            	 <div class="row">
							            		<div class="col-6 col-sm-10">
							            			<input type="text" onclick="startFavorites()" class="form-control" id="firstStart" placeholder="주소" disabled='disabled'>
							            		</div>
							            	</div>
							            	<br />
							            	<div class="row">
							            		<div class="col-4 col-sm-10">
							            			<input type="text" class="form-control" id="firstStartDetails" placeholder="상세주소" disabled='disabled'>
							            		</div>
											</div>
											<br>
											<div class="row">
								            	<div class="col-1 col-sm-1">
								            		<button type="button" name="startModify" id="startModify1"class="btn btn-outline-primary" onclick="startFavorites()" disabled='disabled'>수정</button>
								            	</div>
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="startSave1" class="btn btn-outline-primary" onclick="zipSave()" disabled='disabled'>저장</button>
								            	</div>
											</div>
										</div>	
										<div class="col-sm-12">
											<h3><label for="recipient-name" class="col-form-label"><input type="radio" name="zip" id="secondStartZip" value="second" onclick="btnAbled()"> &nbsp;두번째 주소</label></h3>
							            	 <div class="row">
							            		<div class="col-6 col-sm-10">
							            			<input type="text" onclick="startFavorites()" class="form-control" id="secondStart" placeholder="주소" disabled='disabled'>
							            		</div>
							            	</div>
							            	<br />
							            	<div class="row">
							            		<div class="col-4 col-sm-10">
							            			<input type="text" class="form-control" id="secondStartDetails" placeholder="상세주소" disabled='disabled'>
							            		</div>
											</div>
											<br>
											<div class="row">
								            	<div class="col-1 col-sm-1">
								            		<button type="button" name="startModify" id="startModify2" class="btn btn-outline-primary" onclick="startFavorites()" disabled='disabled'>수정</button>
								            	</div>
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="startSave2" class="btn btn-outline-primary" onclick="zipSave()" disabled='disabled'>저장</button>
								            	</div>
											</div>
										</div>
										
										<div class="col-sm-12">
							            	<h3><label for="recipient-name" class="col-form-label"><input type="radio" name="zip" id="thirdStartZip" value="third" onclick="btnAbled()"> &nbsp;세번째 주소</label></h3>
							            	 <div class="row">
							            		<div class="col-6 col-sm-10">
							            			<input type="text" onclick="startFavorites()"class="form-control" id="thirdStart" placeholder="주소" disabled='disabled'>
							            		</div>
							            	</div>
							            	<br />
							            	<div class="row">
							            		<div class="col-4 col-sm-10">
							            			<input type="text" class="form-control" id="thirdStartDetails" placeholder="상세주소" disabled='disabled'>
							            		</div>
											</div>
											<br>
											<div class="row">
								            	<div class="col-1 col-sm-1">
								            		<button type="button" name="startModify" onclick="startFavorites()" id="startModify3" class="btn btn-outline-primary" onclick="startFavorites()" disabled='disabled'>수정</button>
								            	</div>
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="startSave3" class="btn btn-outline-primary" onclick="zipSave()" disabled='disabled'>저장</button>
								            	</div>
											</div>
										</div>
						          	</div>
						        </div>
							</form>
					      	</div>
					      	<div class="modal-footer">
					        	<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
					        	<button type="button" id="addressSelect1" class="btn btn-outline-primary" data-dismiss="modal" onclick="selectStart()" disabled='disabled'>주소 선택</button>
					      	</div>
					    </div>
					 </div>
				</div>
				<br>
				<input type="text" class="form-control"id="start_address" onclick="startInput()" placeholder="주소"> <br/>
				<input type="text" class="form-control"id="start_details" placeholder="상세주소">
				
				
				
            </div>

			<div class="row">
				<div class="col-md-6 mb-3">
					 <label for="endName">받는 분(이름)</label><br>
					<input type="text" name="arrive_Name" id="arriveName" required>
					<div class="invalid-feedback">
                  		이름을 입력하세요
                	</div>
                </div>
			</div>
			<div class="mb-3">
				<label for="endPhone">받는 분(전화번호)</label><br>
				<input type="text" name="arrive_Phone" id="arrivePhone" placeholder="-은 제외하세요." required>
				<div class="invalid-feedback">
                  	전화번호를 입력하세요
                </div>
            </div>
            <div class="mb-3">
              <label for="startAddress">도착지</label>
               &nbsp;&nbsp;&nbsp;
              <button type="button" class="btn btn-outline-primary" onclick="arriveInput()">주소 검색</button> &nbsp;&nbsp;&nbsp;
              	<button type="button" class="btn btn-outline-success" onclick="arriveLocation()"data-toggle="modal" data-target="#arriveModal" data-whatever="@mdo">즐겨찾기</button><br>
              	<div class="modal fade bd-example-modal-lg" id="arriveModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					 <div class="modal-dialog modal-lg" role="document">
					    <div class="modal-content">
					      	<div class="modal-header">
					        	<h3 class="modal-title" id="exampleModalLabel">등록된 도착지 주소</h3>
					        	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          		<span aria-hidden="true">&times;</span>
					        	</button>
					      	</div>
					      	<div class="modal-body">
					      	<form>
					      		<div class="form-group">
									<div class="row">
						     			<div class="col-sm-12">
							            	<h3><label for="recipient-name" class="col-form-label"><input type="radio" name="zip2" id="firstEndZip" value="first" onclick="btnAbled()"> &nbsp;첫번째 주소</label></h3>
							            	 <div class="row">
							            		<div class="col-6 col-sm-10">
							            			<input type="text" class="form-control" onclick="endFavorites()" id="firstEnd" placeholder="주소" disabled='disabled'>
							            		</div>
							            	</div>
							            	<br />
							            	<div class="row">
							            		<div class="col-4 col-sm-10">
							            			<input type="text" class="form-control" id="firstEndDetails" placeholder="상세주소" disabled='disabled'>
							            		</div>
											</div>
											<br>
											<div class="row">
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="arriveModify1" class="btn btn-outline-primary" onclick="endFavorites()" disabled='disabled'>수정</button>
								            	</div>
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="endSave1" class="btn btn-outline-primary" onclick="arriveSave()" disabled='disabled'>저장</button>
								            	</div>
											</div>
										</div>	
										<div class="col-sm-12">
											<h3><label for="recipient-name" class="col-form-label"><input type="radio" name="zip2" id="secondEndZip" value="second" onclick="btnAbled()"> &nbsp;두번째 주소</label></h3>
							            	 <div class="row">
							            		<div class="col-6 col-sm-10">
							            			<input type="text" onclick="endFavorites()" class="form-control" id="secondEnd" placeholder="주소" disabled='disabled'>
							            		</div>
							            	</div>
							            	<br />
							            	<div class="row">
							            		<div class="col-4 col-sm-10">
							            			<input type="text" class="form-control" id="secondEndDetails" placeholder="상세주소" disabled='disabled'>
							            		</div>
											</div>
											<br>
											<div class="row">
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="arriveModify2"  class="btn btn-outline-primary" onclick="endFavorites()" disabled='disabled'>수정</button>
								            	</div>
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="endSave2" class="btn btn-outline-primary" onclick="arriveSave()" disabled='disabled'>저장</button>
								            	</div>
											</div>
										</div>
										
										<div class="col-sm-12">
							            	<h3><label for="recipient-name" class="col-form-label"><input type="radio" name="zip2" id="thirdEndZip" value="third" onclick="btnAbled()"> &nbsp;세번째 주소</label></h3>
							            	 <div class="row">
							            		<div class="col-6 col-sm-10">
							            			<input type="text" onclick="endFavorites()" class="form-control" id="thirdEnd" placeholder="주소" disabled='disabled'>
							            		</div>
							            	</div>
							            	<br />
							            	<div class="row">
							            		<div class="col-4 col-sm-10">
							            			<input type="text" class="form-control" id="thirdEndDetails" placeholder="상세주소" disabled='disabled'>
							            		</div>
											</div>
											<br>
											<div class="row">
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="arriveModify3"  class="btn btn-outline-primary" onclick="endFavorites()" disabled='disabled'>수정</button>
								            	</div>
								            	<div class="col-1 col-sm-1">
								            		<button type="button" id="endSave3" class="btn btn-outline-primary" onclick="arriveSave()" disabled='disabled'>저장</button>
								            	</div>
											</div>
										</div>
						          	</div>
						        </div>
							</form>
					      	</div>
					      	<br>
					      	<div class="modal-footer">
					        	<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
					        	<button type="button" id="addressSelect2"class="btn btn-outline-primary" data-dismiss="modal" onclick="selectAddress()" disabled='disabled'>주소 선택</button>
					      	</div>
					    </div>
					 </div>
				</div>
				<br>
				<input type="text" class="form-control" id="arrive_address" onclick="arriveInput()" placeholder="주소"><br>
				<input type="text" class="form-control" id="arrive_details" placeholder="상세주소">
				
            </div>
			<div class="mb-3">
              	<label for="kinds">물품 종류</label>
              	<input type="radio" name="kind" value="1" checked>간단(1kg)
			  	<input type="radio" name="kind" value="2" >서류(2kg)
				<input type="radio" name="kind" value="3"> 박스(5kg)         
            </div>
            <div class="mb-3">
              	<label for="direct">방향</label>
              	<input type="radio" name="direction" value="1" checked required>편도
				<input type="radio" name="direction" value="2" required>왕복       
            </div>
            <div class="mb-3">
              	<label for="direct">요청사항</label>
              	<div class="container">
				<div class="input-group">
	  				<textarea class="form-control" rows="10" name="bcontent" id="ir1" aria-label="With textarea"></textarea>
					
				</div>
				</div>      
            </div>
			<div class="mb-3">
			<nav aria-label="..." class="nav justify-content-center">
				<button class="btn btn-outline-success" id="next" type="button" onclick="form_check()">다음</button>
            </nav>
            </div>
		</form>
		</div>
	</div>

	<footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">&copy; JibaeIn 지하철 택배</p>
      </footer>
</div>



<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>

function infoConfirm(){
	var payResult = document.getElementById("payResult");
	if(document.deliveryRequest.start.value ==""){
		alert("출발지를 선택하세요");
		return;
	}
	
	if(document.deliveryRequest.end.value == "") {
		alert("도착지를 선택하세요");
		return;
	}
	if(document.deliveryRequest.start.value == "강남") {
		if(document.deliveryRequest.end.value == "강남")payResult.innerHTML = "5000";
		
	}
	
	document.reg_frm.submit();
}

function updateInfoConfirm() {
	if(document.deliveryRequest.start_zip.value ==""){
		alert("출발지를 선택하세요");
		return;
	}
	
	if(document.deliveryRequest.end_zip.value == "") {
		alert("도착지를 선택하세요");
		return;
	}
	var payResult = document.getElementById("payResult");
	var start_zip = document.getElementById("start_zip");
	var end_zip = document.getElementById("end_zip");
	
	var start = start_zip.value;
	var strArray = start.split(" ");
	
	var end = end_zip.value;
	var endArray = end.split(" ");
	
	if(strArray[0] == "서울특별시") {
		if(endArray[0] == "서울특별시"){
			if(strArray[1] == "강남구") {
				if(endArray[1] == "강남구") payResult.innerHTML = "5000";
				else if(endArray[1] == "강동구")payResult.innerHTML = "7000";
				else if(endArray[1] == "강북구")payResult.innerHTML = "8000";
				else if(endArray[1] == "강서구")payResult.innerHTML = "9000";
				else if(endArray[1] == "관악구")payResult.innerHTML = "7000";
				else if(endArray[1] == "광진구")payResult.innerHTML = "7000";
				else if(endArray[1] == "구로구")payResult.innerHTML = "7000";
				else if(endArray[1] == "강북구")payResult.innerHTML = "9000";
			}
		}
		else if(endArray[0] == "경기도"){
				
		}
		else{
			alert("수도권 지역만 가능합니다.");
			return;
		}
		
	}
	else if(strArray[0] == "경기도") {
		
	}
	else{
		alert("수도권 지역만 가능합니다.");
		return;
	}
}

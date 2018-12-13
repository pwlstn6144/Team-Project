
function infoConfirm() {
	if(document.addWorker.wk_Name.value == 0) {
		alert("이름을 입력하세요.");
		addWorker.wk_Name.focus();
		return;
	}
	
	if(document.addWorker.wk_Id.value.length < 5) {
		alert("아이디를 입력하세요.");
		addWorker.wk_Id.focus();
		return;
	}
	
	if(document.addWorker.wk_Password.value == 0) {
		alert("비밀번호는 필수사항입니다.");
		addWorker.wk_Password.focus();
		return;
	}
	
	if(document.addWorker.wk_Password.value != document.addWorker.wk_Password2.value) {
		alert("비밀번호가 일치하지 않습니다.");
		addWorker.wk_Password2.focus();
		return;
	}

	if(document.addWorker.wk_Phone.value.length== 0) {
		alert("휴대폰 번호는 필수사항입니다.");
		addWorker.wk_Phone.focus();
		return;
	}
	
	if(document.addWorker.userfile1.value.length== 0) {
		alert("사진을 넣어주세요.");
		return;
	}
	
	document.addWorker.submit();
}

function updateInfoConfirm() {

	if(document.reg_frm.cst_PASSWORD.value == "") {
		alert("패스워드를 입력하세요.");
		document.reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PASSWORD.value != document.reg_frm.cst_PASSWORD_check.value) {
		alert("패스워드가 일치하지 않습니다.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PASSWORD.value.length < 8) {
		alert("비밀번호는 8~16자 영문 대 소문자, 숫자, 특수문자만 사용 가능합니다.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PHONE.value == 0) {
		alert("휴대폰 번호는 필수사항입니다..");
		reg_frm.cst_PHONE.focus();
		return;
	}
	
	document.addWorker.submit();
}
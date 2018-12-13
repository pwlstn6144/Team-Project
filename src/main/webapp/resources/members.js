
function infoConfirm() {
	if(document.reg_frm.cst_ID.value == 0) {
		alert("아이디는 필수사항입니다.");
		reg_frm.cst_ID.focus();
		return;
	}
	
	 if(document.reg_frm.value != "idCheck"){
          alert("아이디 중복체크를 해주세요.");
          reg_frm.cst_ID.focus();
          return false;
     }
	
	if(document.reg_frm.cst_ID.value.length < 5) {
		alert("아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
		reg_frm.cst_ID.focus();
		return;
	}
	
	if(!document.reg_frm.cst_ID.value.match(/([a-zA-Z0-9].*[_,-])|([_,-].*[a-zA-Z0-9])/)) {
		alert("아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
		reg_frm.cst_ID.focus();
		return;
	}
	
	if(document.reg_frm.cst_PASSWORD.value == 0) {
		alert("비밀번호는 필수사항입니다.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PASSWORD.value != document.reg_frm.cst_PASSWORD_check.value) {
		alert("비밀번호가 일치하지 않습니다.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PASSWORD.value.length < 8) {
		alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(!document.reg_frm.cst_PASSWORD.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
	      alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_NAME.value == 0) {
		alert("이름은 필수사항입니다.");
		reg_frm.cst_NAME.focus();
		return;
	}
		
	if(document.reg_frm.cst_PHONE.value.length== 0) {
		alert("휴대폰 번호는 필수사항입니다.");
		reg_frm.cst_PHONE.focus();
		return;
	}
	
	if(isNaN(document.reg_frm.cst_PHONE.value.length== 0)) {
		alert("전화번호는 - 제외한 숫자만 입력해주세요.");
		reg_frm.cst_PHONE.focus();
		return;
	}
	
//	 // 아이디 중복체크 화면open
//    function openIdChk(){
//    
//        window.name = "parentForm";
//        window.open("member/IdCheckForm.jsp",
//                "chkForm", "width=500, height=300, resizable = no, scrollbars = no");    
//    }
//
//    // 아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
//    // 이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
//    // 다시 중복체크를 하도록 한다.
//    function inputIdChk(){
//        document.userInfo.idDuplication.value ="idUncheck";
//    }
	
	document.reg_frm.submit();
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
	
	if(!document.reg_frm.cst_PASSWORD.value.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)) {
	      alert("비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.");
		reg_frm.cst_PASSWORD.focus();
		return;
	}
	
	if(document.reg_frm.cst_PHONE.value == 0) {
		alert("휴대폰 번호는 필수사항입니다..");
		reg_frm.cst_PHONE.focus();
		return;
	}
	
	if(isNaN(document.reg_frm.cst_PHONE.value.length== 0)) {
		alert("전화번호는 - 제외한 숫자만 입력해주세요.");
		reg_frm.cst_PHONE.focus();
		return;
	}
	
	document.reg_frm.submit();
}
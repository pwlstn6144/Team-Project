package Member;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import com.study.spring.dto.BDto;
import com.study.spring.dto.masterDto;
import com.study.spring.dto.workerDto;

public interface MemberDao {
	
	// 회원등록
	public void insertMember(String cst_ID,  String cst_PASSWORD, String cst_NAME, 
	 		 String cst_PHONE, String cst_EMAIL);

	// 아이디 중복 검사
	public int idcheck(String cst_ID);

	// 고객 로그인
	public MemberDto userCheck(String cst_ID, String cst_PASSWORD);
	
	// 기사 로그인
	public workerDto WorkCheck(String wk_ID, String wk_PASSWORD);
	
	// 관리자 로그인
	public masterDto MasterCheck(String master_Id, String master_password);
	
	// 회원 정보 보기
	public MemberDto getMember(String cst_ID);
	
	// 회원정보수정
	public void updateMember(String cst_ID, String cst_PASSWORD, String cst_PHONE, String cst_EMAIL);

	// 회원삭제
	public void deleteMember(String cst_ID, String cst_PASSWORD);
	
	//로그아웃
	public void Logout(HttpSession session);
	
	//아이디 찾기
	public String find_id(String cst_EMAIL);
	
	//비밀번호 찾기
	public String find_pw(String cst_ID, String cst_EMAIL);

	public ArrayList<BDto> bestNotice(int bCheck); //메인화면 왼쪽 공지사항
	
	public ArrayList<BDto> noticeBest(int bCheck); //메인화면 오른쪽 고객의 소리
	
	public int adminLogin(String id, String pwd); // 고객 로그인 체크
	
	public int adminManagerLogin(String id, String pwd); // 기사 로그인 체크
	
	public int adminmasterLogin(String id, String pwd); // 관리자 로그인 체크

}

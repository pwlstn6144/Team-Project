package com.study.spring;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.study.spring.dao.IDao;
import com.study.spring.dto.masterDto;
import com.study.spring.dto.workerDto;

import Member.MemberDao;
import Member.MemberDto;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MailSender mailSender;
	
	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
     
	@RequestMapping("/JoinForm") // 회원가입 페이지
	public String JoinForm(Model model) {
		return "/member/JoinForm";
	}

	@RequestMapping("/Join_View") // 회원가입 폼으로 이동
	public String insertMember(HttpServletRequest request, RedirectAttributes rttr, Model model) {
		System.out.println("::::::::::::::::::::::::::::::::::::::::: insertMember start");
		MemberDao dao = sqlSession.getMapper(MemberDao.class);
		
		String cst_ID = request.getParameter("cst_ID");
		String cst_PASSWORD = request.getParameter("cst_PASSWORD");
		String cst_NAME = request.getParameter("cst_NAME");
		String cst_PHONE = request.getParameter("cst_PHONE");
		String cst_EMAIL = request.getParameter("cst_EMAIL");

		System.out.println("");
		System.out.println(":::::::::::::::::::::::: cst_ID : " + cst_ID);
		System.out.println(":::::::::::::::::::::::: cst_PASSWORD : " + cst_PASSWORD);
		System.out.println(":::::::::::::::::::::::: cst_NAME : " + cst_NAME);
		System.out.println(":::::::::::::::::::::::: cst_PHONE : " + cst_PHONE);
		System.out.println(":::::::::::::::::::::::: cst_EMAIL : " + cst_EMAIL);
		System.out.println("");

		dao.insertMember(cst_ID, cst_PASSWORD, cst_NAME, cst_PHONE, cst_EMAIL);
		MemberDto dto = dao.getMember(cst_ID);
		model.addAttribute("dto", dto);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: insertMember end");
		return "/member/Join_View";
	}

	@RequestMapping("/idcheck") // 아이디 중복 체크
	public void idcheck(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		MemberDao dao = sqlSession.getMapper(MemberDao.class);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		request.setCharacterEncoding("UTF-8");

		JSONObject obj = new JSONObject();
		String cst_ID = request.getParameter("cst_ID");

		int idcheck = dao.idcheck(cst_ID);
		System.out.println("idcheck : " + idcheck);
		int i = 0;

		if (idcheck > 0) {
			i = 1;
		} else {
			i = 0;
		}
		obj.put("i", i);
		writer.println(obj);
	}
	
	
	@ResponseBody	// 이메일 번호 인증
	@RequestMapping("/emailAuth")
	public String emailAuth(HttpServletRequest request, Model model) {
	  
		MemberDto dto = new MemberDto();
	    String cst_EMAIL = request.getParameter("cst_EMAIL");
	    String cst_KEY = "";
	        
	    System.out.println(cst_EMAIL);
	    cst_KEY = randomNum();
	    //가입승인에 사용될 인증키 난수 발생    
	    sendEmail(cst_EMAIL, cst_KEY);
	    //이메일전송
	    String str = cst_KEY;
	        
	    return str;
	}
	    
	private String randomNum() { // 이메일 번호 인증 키 7자리 생성
	    StringBuffer buffer = new StringBuffer();
	        
	    for( int i = 0 ; i <= 6; i++) {
	        int n = (int)(Math.random()*10);
	        buffer.append(n);
	    }
	        
	    return buffer.toString();
	}
	 
	public void sendEmail(String cst_EMAIL , String cst_KEY ) {   //이메일 발송 메서드
	    SimpleMailMessage mailMessage = new SimpleMailMessage();
	    mailMessage.setSubject("지배人회원인증 번호입니다.");
	    mailMessage.setFrom("niljungsang@gmail.com");
	    mailMessage.setText("[지배人]회원가입을 환영합니다. 인증번호를 확인해주세요. [ "+cst_KEY+" ]");
	    mailMessage.setTo(cst_EMAIL);
	    
	    try {
	        mailSender.send(mailMessage);
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	}

	// 로그인 첫 화면 요청 메소드
	@RequestMapping("/LoginForm") // 로그인화면
	public String LoginForm(HttpServletRequest request, HttpSession session, Model model) {

		// /* 구글code 발행 */
		// oauthOperations = googleConnectionFactory.getOAuthOperations();
		// String url =
		// oauthOperations.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE,
		// googleOAuth2Parameters);
		// System.out.println("/googleLogin, url : " + url);
		// model.addAttribute("google_url", url);
		//
		// /* 생성한 인증 URL을 View로 전달 */

		return "/member/LoginForm";
	}

	@RequestMapping("/logout.do") // 로그아웃
	public String logout(HttpSession session, Model model) {
		IDao dao = sqlSession.getMapper(IDao.class);
		session.invalidate();

		int bestCheck = 2;
		int qanda = 1;

		model.addAttribute("best", dao.bestNotice(bestCheck));
		model.addAttribute("notice", dao.noticeBest(qanda));

		return "web/main";
	}
	
	@RequestMapping("/userCheck") // 로그인모드 - 로그인처리 - 수정모드1111
	public String userCheck(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {

		System.out.println("::::::::::::::::::::::::::::::::::::::::: userCheckstart");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();

		int check = 0;
		String bUrl = (String)session.getAttribute("bUrl");

		String LoginMode = request.getParameter("LoginMode");
		System.out.println(":::::::::::::::::::::::: LoginMode : " + LoginMode);
		String input_ID = request.getParameter("input_ID");
		System.out.println(":::::::::::::::::::::::: input_ID : " + input_ID);
		String input_PASSWORD = request.getParameter("input_PASSWORD");

		MemberDao dao = sqlSession.getMapper(MemberDao.class);
		MemberDto dto = new MemberDto();
		workerDto dto1 = new workerDto();
		masterDto dto2 = new masterDto();


		if (LoginMode.equals("admin")) {
			session.setAttribute("member", "customer");
			session.setAttribute("id", input_ID);
			dto = dao.userCheck(input_ID, input_PASSWORD);
		} else if (LoginMode.equals("adminmanager")) {
			session.setAttribute("member", "worker");
			session.setAttribute("id", input_ID);
			dto1 = dao.WorkCheck(input_ID, input_PASSWORD);
		} else if (LoginMode.equals("adminmaster")) {
			session.setAttribute("member", "master");
			session.setAttribute("id", input_ID);
			dto2 = dao.MasterCheck(input_ID, input_PASSWORD);
		}
		model.addAttribute("dto", dto);
		model.addAttribute("dto1", dto1);
		model.addAttribute("dto2", dto2);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: userCheckend");

		String member = (String) session.getAttribute("member");
		int bestCheck = 0;
		int qanda = 1;
		if (member == null || member.equals("customer") || member.equals("master")) {
			bestCheck = 2;
			model.addAttribute("best", dao.bestNotice(bestCheck));
			model.addAttribute("notice", dao.noticeBest(qanda));
		} else if (member.equals("worker")) {
			bestCheck = 3;
			model.addAttribute("best", dao.bestNotice(bestCheck));
			model.addAttribute("notice", dao.noticeBest(qanda));
		}

		System.out.println("::::::::::::::::::::::::::::::::::::::::: userCheckend");

		if(LoginMode.equals("admin")) check = dao.adminLogin(input_ID, input_PASSWORD);	
		else if(LoginMode.equals("adminmanager")) check = dao.adminManagerLogin(input_ID, input_PASSWORD);	
		else if(LoginMode.equals("adminmaster")) check = dao.adminmasterLogin(input_ID, input_PASSWORD);
		
		if(check == 1)
		{
			if (LoginMode.equals("admin")) {
				session.setAttribute("member", "customer");
				session.setAttribute("id", input_ID);
				dto = dao.userCheck(input_ID, input_PASSWORD);
			} else if (LoginMode.equals("adminmanager")) {
				session.setAttribute("member", "worker");
				session.setAttribute("id", input_ID);
				dto1 = dao.WorkCheck(input_ID, input_PASSWORD);
			} else if (LoginMode.equals("adminmaster")) {
				session.setAttribute("member", "master");
				session.setAttribute("id", input_ID);
				dto2 = dao.MasterCheck(input_ID, input_PASSWORD);
			}
			model.addAttribute("dto", dto);
			model.addAttribute("dto1", dto1);
			model.addAttribute("dto2", dto2);
			System.out.println("::::::::::::::::::::::::::::::::::::::::: userCheckend");
	
			if(member == null || member.equals("customer") || member.equals("master"))
			{
				bestCheck = 2;
				model.addAttribute("best", dao.bestNotice(bestCheck));
				model.addAttribute("notice", dao.noticeBest(qanda));
			}
			else if(member.equals("worker"))
			{
				bestCheck = 3;
				model.addAttribute("best", dao.bestNotice(bestCheck));
				model.addAttribute("notice", dao.noticeBest(qanda));
			}

			return "web/main";
		}
		else if(check == 0)
		{
			writer.println("<html><head><body>");
			writer.println("<script language=\"javascript\">\r\n" + 
					"alert(\"아이디 및 비밀번호가 다릅니다.\");\r\n" + 
					"history.go(-1);\r\n" + 
					"</script>");
			writer.println("</body></html>");
			writer.close();


		return "web/main";

		}
		
		return "home";

	}

	@RequestMapping("/ModifyForm") // 회원정보 수정화면
	public String ModifyForm(HttpServletRequest request, Model model) {
		System.out.println("::::::::::::::::::::::::::::::::::::::::: ModifyForm start");
		MemberDao dao = sqlSession.getMapper(MemberDao.class);

//		String cst_ID = request.getParameter("cst_ID");

		HttpSession session = request.getSession();
		if(session.getAttribute("id") == null)
		{
			return "/member/LoginForm";
		}
		String cst_ID = (String)session.getAttribute("id");


		System.out.println(":::::::::::::::::::::::: cst_ID : " + cst_ID);

		MemberDto dto = dao.getMember(cst_ID);

		model.addAttribute("dto", dto);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: ModifyForm end");
		return "/member/ModifyForm";
	}

	@RequestMapping("/updateMember") // 회원정보 수정처리
	public String updateMember(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {
		System.out.println("::::::::::::::::::::::::::::::::::::::::: updateMember start");
		MemberDao dao = sqlSession.getMapper(MemberDao.class);

		String cst_ID = request.getParameter("cst_ID");
		String cst_PASSWORD = request.getParameter("cst_PASSWORD");
		String cst_PHONE = request.getParameter("cst_PHONE");
		String cst_EMAIL = request.getParameter("cst_EMAIL");

		System.out.println("");
		System.out.println(":::::::::::::::::::::::: cst_ID : " + cst_ID);
		System.out.println(":::::::::::::::::::::::: cst_PASSWORD : " + cst_PASSWORD);
		System.out.println(":::::::::::::::::::::::: cst_PHONE : " + cst_PHONE);
		System.out.println(":::::::::::::::::::::::: cst_EMAIL : " + cst_EMAIL);
		System.out.println("");
		MemberDto dto = dao.getMember(cst_ID);
		dao.updateMember(cst_ID, cst_PASSWORD, cst_PHONE, cst_EMAIL);
		model.addAttribute("dto", dto);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: updateMember end");
		return "/web/main";
	}

	@RequestMapping("/DeleteForm") // 회원탈퇴 화면
	public String DeleteForm(HttpServletRequest request, Model model) {
		MemberDao dao = sqlSession.getMapper(MemberDao.class);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: DeleteForm start");

		String cst_ID = request.getParameter("cst_ID");
		System.out.println(":::::::::::::::::::::::: cst_ID : " + cst_ID);

		MemberDto dto = dao.getMember(cst_ID);

		model.addAttribute("dto", dto);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: DeleteForm end");
		return "/member/DeleteForm";
	}

	@RequestMapping("/deleteMember") // 회원탈퇴 처리
	public String deleteMember(HttpServletRequest request, Model model) {
		MemberDao dao = sqlSession.getMapper(MemberDao.class);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: deleteMember start");

		String cst_ID = request.getParameter("cst_ID");
		System.out.println(":::::::::::::::::::::::: cst_ID : " + cst_ID);

		String cst_PASSWORD = request.getParameter("cst_PASSWORD");
		System.out.println(":::::::::::::::::::::::: cst_PASSWORD : " + cst_PASSWORD);

		dao.deleteMember(cst_ID, cst_PASSWORD);
		MemberDto dto = new MemberDto();
		model.addAttribute("dto", dto);
		System.out.println("::::::::::::::::::::::::::::::::::::::::: deleteMember end");

		return "/member/DeleteEnd";
	}

	// 아이디 찾기 폼
	@RequestMapping("/find_id_form")
	public String find_id_form(Model model) {
		return "/member/find_id_form";
	}

	// 아이디 찾기
	@RequestMapping("/find_id")
	public String find_id(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {

		MemberDao dao = sqlSession.getMapper(MemberDao.class);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();

		String cst_EMAIL = request.getParameter("cst_EMAIL");
		String cst_ID = dao.find_id(cst_EMAIL);

		if (cst_ID == null) {
			writer.println("<script>");
			writer.println("alert('가입된 아이디가 없습니다.');");
			writer.println("history.go(-1);");
			writer.println("</script>");
			writer.close();
			return null;
		}

		model.addAttribute("cst_ID", cst_ID);
		return "/member/find_id";
	}

	// 비밀번호 찾기 폼
	@RequestMapping("/find_pw_form")
	public String find_pw_form(Model model) {
		return "/member/find_pw_form";
	}
	
	@ResponseBody
	@RequestMapping("/find_pw")
	public String find_pw(HttpServletRequest request, HttpServletResponse response, Model model)
			throws ServletException, IOException {

		MemberDao dao = sqlSession.getMapper(MemberDao.class);
		MemberDto dto = new MemberDto();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();

		String cst_ID = request.getParameter("cst_ID");
		String cst_EMAIL = request.getParameter("cst_EMAIL");
		String cst_PASSWORD = dao.find_pw(cst_ID, cst_EMAIL);
		System.out.println(cst_EMAIL);
		//
		sendEmailPw(cst_EMAIL, cst_PASSWORD);
		
		String str = cst_PASSWORD;
		return "/member/find_pw";
	}
	
	public void sendEmailPw(String cst_EMAIL , String cst_PASSWORD ) {   //이메일 발송 메서드
	    SimpleMailMessage mailMessage = new SimpleMailMessage();
	    mailMessage.setSubject("지배人 비밀번호 발송 메일입니다.");
	    mailMessage.setFrom("niljungsang@gmail.com");
	    mailMessage.setText("[지배人]비밀번호 찾기입니다. 비밀번호는 [ "+cst_PASSWORD+" ]입니다.");
	    mailMessage.setTo(cst_EMAIL);
	    
	    try {
	        mailSender.send(mailMessage);
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	}

}
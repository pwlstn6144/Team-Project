package com.study.spring;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.spring.dao.chatt;

@Controller
public class ChattController {
	private static final Logger logger = LoggerFactory.getLogger(ChattController.class);


	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/chatt")
	public String chatt(HttpServletRequest request, HttpServletResponse response, Model model)throws ServletException, IOException { // 대화방 입장
		HttpSession session = request.getSession();
		chatt dao = sqlSession.getMapper(chatt.class);
		
		String id = (String)session.getAttribute("id");
		System.out.println("id:" + id);
		String name = dao.myMasterName(id);
		String depart = dao.myDepartmentId(id);
		
		if(depart.equals("인사부")) dao.insertRoom1(name);
		else if(depart.equals("개발부")) dao.insertRoom2(name);
		else if(depart.equals("상담부")) dao.insertRoom3(name);
		
		model.addAttribute("masterName", name);
		session.setAttribute("rn", depart);
		model.addAttribute("rn",depart);
		
		
		return "chatting/chattClient";
	}
	
	
}

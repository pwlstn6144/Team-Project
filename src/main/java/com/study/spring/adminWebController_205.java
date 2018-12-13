package com.study.spring;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.study.spring.dao.IDao_205;
import com.study.spring.dto.orderDto2;

/**
 * Handles requests for the application home page.
 */
@Controller
public class adminWebController_205 {
	
	private static final Logger logger = LoggerFactory.getLogger(adminWebController_205.class);
	
	@Autowired
	private SqlSession sqlSession;
	

	@RequestMapping("/msg") // 
	public String msg(HttpServletRequest request, Model model)
	{
		return "./push/msg";
	}
	
	@RequestMapping("/map")
	public String map(Model model)
	{
		System.out.println("map");
		return "./map/adminmap";
	}
	
	@RequestMapping("/wkChart")
	public String wkChart(HttpServletRequest request, Model model)
	{
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String wk_id = request.getParameter("wk_id");

		System.out.println("wkChart wk_id : " + wk_id);

		ArrayList<orderDto2> dtos = new ArrayList<orderDto2>();

		System.out.println("wkChart");
		
		request.setAttribute("wk_id", wk_id);

		return "./chart/wk_chart";
	}
	
	@RequestMapping("/cstChart")
	public String cstChart(HttpServletRequest request, Model model)
	{
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String cst_id = request.getParameter("cst_id");

		System.out.println("cstChart cst_id : " + cst_id);

		ArrayList<orderDto2> dtos = new ArrayList<orderDto2>();

		System.out.println("charttest");
		
		request.setAttribute("cst_id", cst_id);

		return "./chart/cst_chart";
	}
	
	@RequestMapping("/daum_address") // 
	public String daum_address(HttpServletRequest request, Model model)
	{
		return "./cstApp/daum_address";
	}
	
	@RequestMapping("/firebaseChat") // 
	public String firebaseTest(HttpServletRequest request, Model model)
	{
		return "./firebaseWeb/firebaseTest";
	}
	
	@RequestMapping("/newWinFirebase") // 
	public String newWinFirebase(HttpServletRequest request, Model model)
	{
		String childKey = request.getParameter("childKey");
		String childDataId = request.getParameter("childDataId");
		String childDataTitle = request.getParameter("childDataTitle");
		String childDataMessage = request.getParameter("childDataMessage");
		String masterId = request.getParameter("masterId");
		
		System.out.println("childKey : " + childKey);
		System.out.println("childDataId : " + childDataId);
		System.out.println("childDataTitle : " + childDataTitle);
		System.out.println("childDataMessage : " + childDataMessage);
		System.out.println("masterId : " + masterId);
		
		request.setAttribute("childKey", childKey);
		request.setAttribute("childDataId", childDataId);
		request.setAttribute("childDataTitle", childDataTitle);
		request.setAttribute("childDataMessage", childDataMessage);
		request.setAttribute("masterId", masterId);
		
		return "./firebaseWeb/newWinFirebase";
	}
	

}

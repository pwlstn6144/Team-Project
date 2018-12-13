package com.study.spring;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.study.spring.dao.IDao_205;
import com.study.spring.dto.kisaDto_205;
import com.study.spring.dto.orderDto2;
import com.study.spring.dto.wkRecodeDto;

/**
 * Handles requests for the application home page.
 */
@RestController
public class adminWebRestController_205 {
	
	private static final Logger logger = LoggerFactory.getLogger(adminWebRestController_205.class);
	
	@Autowired
	private SqlSession sqlSession;

	
	
	
	/////////////////////////////////////////////////////////////
	// admin Map
	
	
	@RequestMapping(value = "/findKisa") // 
	public JSONObject findKisa(HttpServletRequest request, Model model)
	{
		System.out.println("findKisa");
		
		JSONObject obj = new JSONObject();
		//JSONArray jsonArray = new JSONArray();
		//JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		int mode = Integer.parseInt(request.getParameter("mode"));
//		String userid = request.getParameter("userid");
//		String userpwd = request.getParameter("userpwd");
		
//		System.out.println("userid : " + userid);
//		System.out.println("userpwd : " + userpwd);
		
		// mode
		// 0 - 배송모드(대기중)
		// 1 - 배송모드(배송중)
		// 2 - 휴식모드
		// 3 - 퇴근모드
		
		System.out.println("mode : " + mode);
		
		ArrayList<kisaDto_205> dtos = new ArrayList<kisaDto_205>();
		
		dtos = dao.findKisa(mode);
		
		

		
		//jsonObject.clear();
		
		
//		jsonObject.put("wk_id", dto.getWk_Id());
//		jsonObject.put("wk_name", dto.getWk_Name());
//		jsonObject.put("wk_token", dto.getWk_Token());
//		jsonObject.put("wk_phone", dto.getWk_Phone());
//		
//		jsonObject.put("wk_lat", dto.getWk_Lat());
//		jsonObject.put("wk_lon", dto.getWk_Lon());
//		jsonObject.put("wk_mode", dto.getWk_Mode());
//		
//		jsonObject.put("wk_penalty", dto.getWk_Penalty());
//		jsonObject.put("wk_picture", dto.getWk_Picture());
		

		//jsonArray.add(jsonObject);
		
		obj.put("positions", dtos);
		
		System.out.println("결과 : " + obj.toJSONString());
		request.setAttribute("result", dtos);
		
		
		return obj;
	}
	
	@RequestMapping(value = "/findLocation") // 
	public JSONObject findLocation(HttpServletRequest request, Model model)
	{
		System.out.println("findLocation");
		
		JSONObject obj = new JSONObject();
		//JSONArray jsonArray = new JSONArray();
		//JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		int mode = Integer.parseInt(request.getParameter("mode"));
//		String userid = request.getParameter("userid");
//		String userpwd = request.getParameter("userpwd");
		
//		System.out.println("userid : " + userid);
//		System.out.println("userpwd : " + userpwd);
		
		// mode
		// 0 - 출발지
		// 1 - 도착지
		
		System.out.println("mode : " + mode);
		
		// dto 바꿔서 해야함
		ArrayList<orderDto2> dtos = new ArrayList<orderDto2>();
		
		dtos = dao.findLocation(mode);
		
		

		
		//jsonObject.clear();
		
		
//		jsonObject.put("wk_id", dto.getWk_Id());
//		jsonObject.put("wk_name", dto.getWk_Name());
//		jsonObject.put("wk_token", dto.getWk_Token());
//		jsonObject.put("wk_phone", dto.getWk_Phone());
//		
//		jsonObject.put("wk_lat", dto.getWk_Lat());
//		jsonObject.put("wk_lon", dto.getWk_Lon());
//		jsonObject.put("wk_mode", dto.getWk_Mode());
//		
//		jsonObject.put("wk_penalty", dto.getWk_Penalty());
//		jsonObject.put("wk_picture", dto.getWk_Picture());
		

		//jsonArray.add(jsonObject);
		
		obj.put("positions", dtos);
		
		System.out.println("결과 : " + obj.toJSONString());
		request.setAttribute("result", dtos);
		
		
		return obj;
	}
	
	
}

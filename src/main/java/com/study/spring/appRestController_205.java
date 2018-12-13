package com.study.spring;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.study.spring.dao.IDao;
import com.study.spring.dao.IDao_205;
import com.study.spring.dto.cstDto_205;
import com.study.spring.dto.kisaDto_205;
import com.study.spring.dto.wkRecodeDto;
import com.study.spring.FCMController_205;

/**
 * Handles requests for the application home page.
 */
@RestController
public class appRestController_205 {
	
	public static final int MEMBER_LOGIN_PW_NO_GOOD = 0;
	public static final int MEMBER_LOGIN_SUCCESS = 1;
	public static final int MEMBER_LOGIN_IS_NOT = -1;
	
	private static final Logger logger = LoggerFactory.getLogger(appRestController_205.class);
	
	@Autowired
	private SqlSession sqlSession;

	
	@RequestMapping(value = "/kisaLoginOk") // 
	public JSONObject loginOk(HttpServletRequest request, Model model)
	{
		
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String userid = request.getParameter("userid");
		String tokens = request.getParameter("tokens");
		String userpwd = request.getParameter("userpwd");
		//Double Lat = Double.valueOf(request.getParameter("Lat"));
		//Double Lon = Double.valueOf(request.getParameter("Lon"));
		
		System.out.println("userid : " + userid);
		System.out.println("tokens : " + tokens);
		System.out.println("userpwd : " + userpwd);
		//System.out.println("Lat : " + Lat);
		//System.out.println("Lon : " + Lon);
		
		String dbidChk = dao.confirmId(userid);
		
		
		System.out.println("dbidChk : " + dbidChk);
		
		
		if(dbidChk != null) {
			if(dbidChk.equals(userpwd)) {
				//result = MEMBER_LOGIN_SUCCESS;
				dao.updateToken(tokens, userid);
				
				kisaDto_205 dto = dao.userCheck(userid, userpwd);
				
				dao.updateToken(tokens, userid);
				//dao.updateLocation(Lat, Lon, tokens);
				
				System.out.println(dto.getWk_Id());
				System.out.println(dto.getWk_Name());
				System.out.println(dto.getWk_Password());
				
				obj.put("success", new Integer(1));
				jsonObject.clear();
				
				jsonObject.put("result", new Integer(1));
				
				jsonObject.put("userid", dto.getWk_Id());
				jsonObject.put("username", dto.getWk_Name());
				jsonObject.put("userpwd", dto.getWk_Password());
				//request.setAttribute("wk_info", dto);
				
			} else {
				obj.put("success", new Integer(3));
				jsonObject.clear();
				
				jsonObject.put("result", new Integer(3));
			}
		} else {
			obj.put("success", new Integer(2));
			jsonObject.clear();
			
			jsonObject.put("result", new Integer(2));
		}
		
		//System.out.println("result : " + result);
		
		//request.setAttribute("result", result);
		//System.out.println("resultMap : " + resultMap.toString());
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		return obj;
	}
	
	
	@RequestMapping("/updateLocation") // 
	public JSONObject updateLocation(HttpServletRequest request, Model model)
	{
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String tokens = request.getParameter("tokens");
		Double Lat = Double.valueOf(request.getParameter("Lat"));
		Double Lon = Double.valueOf(request.getParameter("Lon"));
		
		System.out.println("tokens : " + tokens);
		
		System.out.println("Lat : " + Lat);
		System.out.println("Lon : " + Lon);
		
		dao.updateLocation(Lat, Lon, tokens);
		
		obj.put("success", new Integer(1));
		jsonObject.clear();
		
		jsonObject.put("result", new Integer(1));
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		
		return obj;
	}
	
	@RequestMapping("/kisaMode") // 
	public JSONObject kisaMode(HttpServletRequest request, Model model)
	{
		
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String tokens = request.getParameter("tokens");
		int mode = Integer.parseInt(request.getParameter("mode"));
		
		
		System.out.println("tokens : " + tokens);
		System.out.println("mode : " + mode);
		
		dao.updateMode(tokens, mode);
		
		obj.put("success", new Integer(1));
		jsonObject.clear();
		
		jsonObject.put("result", new Integer(1));
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		
		return obj;
	}
	
	@RequestMapping("/deliveryClicked") // 
	public JSONObject deliveryClicked(HttpServletRequest request, Model model)
	{
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String id = request.getParameter("id");
		String tokens = request.getParameter("tokens");
		String request_number = request.getParameter("request_number");
		String orderinvoicenumber = request.getParameter("orderinvoicenumber");
		
		System.out.println("id : " + id);
		System.out.println("request_number : " + request_number);
		System.out.println("orderinvoicenumber : " + orderinvoicenumber);
		
		dao.updateDelivery(id, request_number, orderinvoicenumber);
		dao.updateMode(tokens, 1);
		
		obj.put("success", new Integer(1));
		jsonObject.clear();
		
		jsonObject.put("result", new Integer(1));
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		return obj;
	}
	
	@RequestMapping("/deliveryFinished") // 
	public JSONObject deliveryFinished(HttpServletRequest request, Model model)
	{
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String id = request.getParameter("id");
		String tokens = request.getParameter("tokens");
		String orderinvoicenumber = request.getParameter("orderinvoicenumber");
		
		System.out.println("id : " + id);
		System.out.println("orderinvoicenumber : " + orderinvoicenumber);
		
		dao.finishDelivery(id, orderinvoicenumber);
		dao.updateMode(tokens, 0);
		
		obj.put("success", new Integer(1));
		jsonObject.clear();
		
		jsonObject.put("result", new Integer(1));
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		return obj;
	}
	
	
	//////
	@RequestMapping(value = "/cstLoginOk") // 
	public JSONObject cstloginOk(HttpServletRequest request, Model model)
	{
		
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String userid = request.getParameter("userid");
		String tokens = request.getParameter("tokens");
		String userpwd = request.getParameter("userpwd");
		
		System.out.println("userid : " + userid);
		System.out.println("tokens : " + tokens);
		System.out.println("userpwd : " + userpwd);
		
		String dbidChk = dao.cstconfirmId(userid);
		
		
		System.out.println("dbidChk : " + dbidChk);
		
		
		if(dbidChk != null) {
			if(dbidChk.equals(userpwd)) {
				//result = MEMBER_LOGIN_SUCCESS;
				dao.updateToken(tokens, userid);
				
				cstDto_205 dto = dao.cstuserCheck(userid, userpwd);
				
				
				System.out.println(dto.getCst_Id());
				System.out.println(dto.getCst_Name());
				System.out.println(dto.getCst_Password());
				
				obj.put("success", new Integer(1));
				jsonObject.clear();
				
				jsonObject.put("result", new Integer(1));
				
				jsonObject.put("userid", dto.getCst_Id());
				jsonObject.put("username", dto.getCst_Name());
				jsonObject.put("userpwd", dto.getCst_Password());
				//request.setAttribute("wk_info", dto);
				
			} else {
				obj.put("success", new Integer(3));
				jsonObject.clear();
				
				jsonObject.put("result", new Integer(3));
			}
		} else {
			obj.put("success", new Integer(2));
			jsonObject.clear();
			
			jsonObject.put("result", new Integer(2));
		}
		
		//System.out.println("result : " + result);
		
		//request.setAttribute("result", result);
		//System.out.println("resultMap : " + resultMap.toString());
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		return obj;
	}
	
	@RequestMapping(value = "/cstOrderPayChk") // 
	public JSONObject cstOrderPayChk(HttpServletRequest request, Model model)
	{
		
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String start_zip = request.getParameter("start_Zip");
		String end_zip = request.getParameter("end_Zip");

		System.out.println("start_zip : " + start_zip);
		System.out.println("end_zip : " + end_zip);

		StringTokenizer start = new StringTokenizer(start_zip, " ");
		String start1 = start.nextToken();
		String start2 = start.nextToken();
		
		StringTokenizer end = new StringTokenizer(end_zip, " ");
		String end1 = end.nextToken();
		String end2 = end.nextToken();
		int orderPrices = dao.orderPrice(start2, end2);
		
		
		obj.put("success", new Integer(1));
		jsonObject.clear();
			
		jsonObject.put("result", orderPrices);
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		return obj;
	}
	
	
	@RequestMapping(value = "/cstOrderFinish") // 
	public JSONObject cstOrderFinish(HttpServletRequest request, Model model)
	{
		
		JSONObject obj = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String cst_id = request.getParameter("cst_id");
		String cst_name = request.getParameter("cst_name");
		String cst_phone = request.getParameter("cst_phone");
		String start_zip = request.getParameter("start_zip");
		String arrive_name = request.getParameter("arrive_name");
		String arrive_phone = request.getParameter("arrive_phone");
		String end_zip = request.getParameter("end_zip");
		String bContent = request.getParameter("bContent");
		int orderkinds = Integer.parseInt(request.getParameter("orderkinds"));
		int direction = Integer.parseInt(request.getParameter("direction"));
		int payment_info = Integer.parseInt(request.getParameter("payment_info"));
		int orderPrices = Integer.parseInt(request.getParameter("orderPrices"));
		String request_number = request.getParameter("request_number");
		float start_Lat = Float.parseFloat(request.getParameter("start_Lat"));
		float start_Lon = Float.parseFloat(request.getParameter("start_Lon"));
		float arrive_Lat = Float.parseFloat(request.getParameter("arrive_Lat"));
		float arrive_Lon = Float.parseFloat(request.getParameter("arrive_Lon"));
		
		dao.deliveryResult(cst_id, cst_name, cst_phone, start_zip, arrive_name, arrive_phone, end_zip, orderkinds, direction, payment_info, bContent, orderPrices, request_number, start_Lat, start_Lon, arrive_Lat, arrive_Lon);
		
		obj.put("success", new Integer(1));
		jsonObject.clear();
			
		jsonObject.put("result", new Integer(1));
		
		jsonArray.add(jsonObject);
		
		obj.put("desc", jsonArray);
		
		System.out.println("결과 : " + obj.toJSONString());
		
		
		
		return obj;
	}
	
	@RequestMapping("/wkChartResult")
	public JSONObject chartResult(HttpServletRequest request, Model model) throws ServletException, IOException 
	{
		
		//response.setContentType("text/html; charset=UTF-8");
		//PrintWriter writer = response.getWriter();		
		//request.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String wk_id = request.getParameter("wk_id");
		String fromDate = null;
		String toDate = null;
		
//		fromDate = request.getParameter("fromDate");
//		toDate = request.getParameter("toDate");
		
		try {
		fromDate = URLDecoder.decode(request.getParameter("fromDate"), "UTF-8");
		toDate = URLDecoder.decode(request.getParameter("toDate"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
		
		Date fDate = null;
		Date tDate = null;
		String foldstring = fromDate;
		String toldstring = toDate;
		
		java.sql.Date sfDate = null;
		java.sql.Date stDate = null;
		try {
			fDate = new SimpleDateFormat("yyyy/MM/dd").parse(foldstring);
			tDate = new SimpleDateFormat("yyyy/MM/dd").parse(toldstring);
			
			System.out.println("chartResult fDate : " + fDate);
			System.out.println("chartResult tDate : " + tDate);
			
			sfDate = convertUtilToSql(fDate);
			stDate = convertUtilToSql(tDate);
			
			System.out.println("chartResult sfDate : " + sfDate);
			System.out.println("chartResult stDate : " + stDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		
		
		
		System.out.println("chartResult wk_id : " + wk_id);
		System.out.println("chartResult fromDate : " + fromDate);
		System.out.println("chartResult toDate : " + toDate);
		

		ArrayList<wkRecodeDto> dtos = new ArrayList<wkRecodeDto>();
		
		dtos = dao.workerRecode(wk_id, sfDate, stDate);
		System.out.println("chartResult");
		
		request.setAttribute("wk_id", wk_id);
		request.setAttribute("fromDate", fromDate);
		request.setAttribute("toDate", toDate);


		obj.put("result", dtos);
		System.out.println("결과 : " + obj.toJSONString());
		request.setAttribute("result", dtos);
		
		//writer.println(obj);
		return obj;
	}
	
	private static java.sql.Date convertUtilToSql(java.util.Date uDate) {
		java.sql.Date sDate = new java.sql.Date(uDate.getTime());
		return sDate;
	}
	
	@RequestMapping("/cstChartResult")
	public JSONObject cstChartResult(HttpServletRequest request, Model model) throws ServletException, IOException 
	{
		
		//response.setContentType("text/html; charset=UTF-8");
		//PrintWriter writer = response.getWriter();		
		//request.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		
		String cst_id = request.getParameter("cst_id");
		String fromDate = null;
		String toDate = null;
		
//		fromDate = request.getParameter("fromDate");
//		toDate = request.getParameter("toDate");
		
		try {
		fromDate = URLDecoder.decode(request.getParameter("fromDate"), "UTF-8");
		toDate = URLDecoder.decode(request.getParameter("toDate"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
		
		Date fDate = null;
		Date tDate = null;
		String foldstring = fromDate;
		String toldstring = toDate;
		
		java.sql.Date sfDate = null;
		java.sql.Date stDate = null;
		try {
			fDate = new SimpleDateFormat("yyyy/MM/dd").parse(foldstring);
			tDate = new SimpleDateFormat("yyyy/MM/dd").parse(toldstring);
			
			System.out.println("chartResult fDate : " + fDate);
			System.out.println("chartResult tDate : " + tDate);
			
			sfDate = convertUtilToSql(fDate);
			stDate = convertUtilToSql(tDate);
			
			System.out.println("chartResult sfDate : " + sfDate);
			System.out.println("chartResult stDate : " + stDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		
		
		
		System.out.println("chartResult cst_id : " + cst_id);
		System.out.println("chartResult fromDate : " + fromDate);
		System.out.println("chartResult toDate : " + toDate);
		

		ArrayList<wkRecodeDto> dtos = new ArrayList<wkRecodeDto>();
		
		dtos = dao.workerRecode(cst_id, sfDate, stDate);
		System.out.println("chartResult");
		
		request.setAttribute("cst_id", cst_id);
		request.setAttribute("fromDate", fromDate);
		request.setAttribute("toDate", toDate);


		obj.put("result", dtos);
		System.out.println("결과 : " + obj.toJSONString());
		request.setAttribute("result", dtos);
		
		//writer.println(obj);
		return obj;
	}
	
}

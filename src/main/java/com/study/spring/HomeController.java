package com.study.spring;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.study.spring.dao.IDao;
import com.study.spring.dao.articlePage;
import com.study.spring.dto.BDto;
import com.study.spring.dto.BPageInfo;
import com.study.spring.dto.cst_zip;
import com.study.spring.dto.orderDto;
import com.study.spring.dto.orderDto2;
import com.study.spring.dto.pictureUpload;
import com.study.spring.dto.workerDto;
import com.study.spring.kakaopay.KakaoPayRequest;
import com.study.spring.kakaopay.KakaoPayResponse;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
//	ContentDao dao;

	@Autowired
	private SqlSession sqlSession;
	
//	@Autowired
//	public void setDao(ContentDao dao) {
//		this.dao = dao;
//	}

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, HttpServletRequest request, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		String member = (String)session.getAttribute("member");
		int bestCheck = 0;
		int qanda = 1;
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
	
	@RequestMapping("/deliveryRequest") 
	public String deliveryRequest(Model model)// 배송 신청
	{
		return "web/deliveryRequest";
	}
	
	@RequestMapping("/main")
	public String main(HttpServletRequest request,  HttpServletResponse response, Model model)throws ServletException, IOException{ // 메인 화면
		HttpSession session = request.getSession();
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String member = (String)session.getAttribute("member");
		int bestCheck = 0;
		int qanda = 1;
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
	
	@RequestMapping("/test")
	public void test(HttpServletRequest request,  HttpServletResponse response, Model model)throws ServletException, IOException
	{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		String check = request.getParameter("check");
		System.out.println(check);
		JSONObject obj = new JSONObject();
		
		obj.put("result", "ok");
		writer.println(obj);
		
	}
	
	@RequestMapping("/test001")
	public String test001() {
		return "web/test001";
	}
	
	@RequestMapping("/web_android")
	public String web_android(Model model)
	{
		return "web/web_android";
	}
		
	@RequestMapping("/delivery_View")
	public String delivery_View(HttpServletRequest request, Model model)  //신청 확인
	{
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String cst_ID = request.getParameter("cst_id");
		String cst_Name = request.getParameter("cst_Name");
		String cst_Phone = request.getParameter("cst_Phone");
		String arrive_Name = request.getParameter("endName");
		String arrive_Phone = request.getParameter("endPhone");
		String start_zip = request.getParameter("start_zip");
		String end_zip = request.getParameter("arrive_zip");
		int orderkinds = Integer.parseInt(request.getParameter("orderKind"));
		int direction = Integer.parseInt(request.getParameter("direct"));

		String bContent = request.getParameter("bContent");
		double start_Lat = Float.parseFloat(request.getParameter("start_Lat"));
		double start_Lon = Float.parseFloat(request.getParameter("start_Lon"));
		double arrive_Lat = Float.parseFloat(request.getParameter("arrive_Lat"));
		double arrive_Lon = Float.parseFloat(request.getParameter("arrive_Lon"));
		
		
		System.out.println("start_Lat:"+start_Lat+", start_Lon:" +start_Lon+", arrive_Lat:"+arrive_Lat+". arrive_Lon:"+arrive_Lon);
		System.out.println("arrive_Name:"+arrive_Name +", arrive_Phone:"+arrive_Phone);

		StringTokenizer start = new StringTokenizer(start_zip, " ");
		String start1 = start.nextToken();
		String start2 = start.nextToken();
		
		StringTokenizer end = new StringTokenizer(end_zip," ");
		String end1 = end.nextToken();
		String end2 = end.nextToken();
		int orderPrices = dao.orderPrice(start2, end2);
		
		orderDto dto2 = new orderDto(cst_ID, cst_Name, cst_Phone, start_zip, arrive_Name, arrive_Phone, end_zip, orderkinds, direction, bContent, orderPrices, start_Lat, start_Lon, arrive_Lat, arrive_Lon); 
		
		request.setAttribute("order", dto2);
		
		return "web/delivery_View";
	}
	
	@RequestMapping("/deliveryResult") 
	public String deliveryResult(HttpServletRequest request, Model model) throws Exception { // 신청결과
		IDao dao = sqlSession.getMapper(IDao.class);
		
		HttpClient httpClient = new DefaultHttpClient();
		String url = "https://kapi.kakao.com/v1/payment/ready";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/x-www-form-urlencoded");
		httpPost.setHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		httpPost.setHeader("Authorization", "KakaoAK e7849ae126b8706702b0452443b5e7d9");

		String cst_ID = request.getParameter("cst_id");
		String cst_Name = request.getParameter("cst_Name");
		String cst_Phone = request.getParameter("cst_Phone");
		String start_Zip = request.getParameter("start_Zip");
		String arrive_Name = request.getParameter("arrive_Name");
		String arrive_Phone = request.getParameter("arrive_Phone");
		String end_Zip = request.getParameter("end_Zip");
		int orderkinds = Integer.parseInt(request.getParameter("orderkinds"));
		int direction = Integer.parseInt(request.getParameter("direction"));
		int payment_info = Integer.parseInt(request.getParameter("payment_info"));
		String bContent = request.getParameter("bContent");
		int orderPrices = Integer.parseInt(request.getParameter("orderPrices"));
		String request_number = request.getParameter("request_number");
		float start_Lat = Float.parseFloat(request.getParameter("start_Lat"));
		float start_Lon = Float.parseFloat(request.getParameter("start_Lon"));
		float arrive_Lat = Float.parseFloat(request.getParameter("arrive_Lat"));
		float arrive_Lon = Float.parseFloat(request.getParameter("arrive_Lon"));
		System.out.println("start_zip : " + start_Zip+", end_zip : " + end_Zip);
		System.out.println("request_number : " + request_number);
		System.out.println("start_Lat:"+start_Lat+", start_Lon:" +start_Lon+", arrive_Lat:"+arrive_Lat+". arrive_Lon:"+arrive_Lon);
		
		if(payment_info == 1)
		{
			String cid = request.getParameter("cid");
			String partner_order_id = request.getParameter("partner_order_id");
			String partner_user_id = request.getParameter("partner_user_id");
			String item_name = request.getParameter("item_name");
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			int total_amount = Integer.parseInt(request.getParameter("total_amount"));
			int vat_amount = Integer.parseInt(request.getParameter("vat_amount"));
			String approval_url = request.getParameter("approval_url");
			String cancel_url = request.getParameter("cancel_url");
			String fail_url = request.getParameter("fail_url");
			
			KakaoPayRequest sendObject = new KakaoPayRequest();
			sendObject.setCid(cid);
			sendObject.setPartner_order_id(partner_order_id);
			sendObject.setPartner_user_id(partner_user_id);
			sendObject.setItem_name(item_name);
			sendObject.setQuantity(quantity);
			sendObject.setTotal_amount(total_amount);
			sendObject.setVat_amount(vat_amount);
			sendObject.setApproval_url(approval_url);
			sendObject.setFail_url(fail_url);
			sendObject.setCancel_url(cancel_url);
			
			String strURL = "https://kapi.kakao.com/v1/payment/ready"; //이곳에 Server URL을 적자

			byte[] postBodyByte; //Entity로 보낼 려면 우선은 byte로 바꿔야 함
			String postBody=""; //Entity로 보낼 값

			postBody = sendObject.toString();
			System.out.println("postBody : " + postBody);
			postBodyByte=postBody.getBytes(); //Entity를 Byte로 바꿔준다

		
			
			HttpEntity httpBody = new ByteArrayEntity(postBodyByte); //Byte로 바뀐 Entity를 HttpEntity로 바꿔준다.
			httpPost.setEntity(httpBody);
			HttpResponse httpResponse = httpClient.execute(httpPost);

			System.out.println("httpResponse : " + httpResponse);
			System.out.println();

			HttpEntity httpEntity01 = httpResponse.getEntity();

			InputStream is = httpEntity01.getContent();
			BufferedReader br = new BufferedReader(new InputStreamReader(is, "utf-8"));

			JSONObject resObject = (JSONObject)JSONValue.parse(br);
			System.out.println("resObject : " + resObject);
			ObjectMapper objectMapper01 = new ObjectMapper();
			KakaoPayResponse responseDomain = objectMapper01.readValue(resObject.toString(), KakaoPayResponse.class);
			System.out.println("responseDomain : " + responseDomain);

			
			//responseDomain.getNext_redirect_pc_url()
			request.setAttribute("responseDomain", responseDomain);
			dao.deliveryResult(cst_ID, cst_Name, cst_Phone, start_Zip, arrive_Name, arrive_Phone, end_Zip, orderkinds, direction, payment_info, bContent, orderPrices, request_number, start_Lat, start_Lon, arrive_Lat, arrive_Lon);
			return "./payment/pay1";
		}
		else 
		{
			dao.deliveryResult(cst_ID, cst_Name, cst_Phone, start_Zip, arrive_Name, arrive_Phone, end_Zip, orderkinds, direction, payment_info, bContent, orderPrices, request_number, start_Lat, start_Lon, arrive_Lat, arrive_Lon);
			return "web/deliveryResult";
		}
		
		
	}
	
	@RequestMapping("/tracking") 
	public String tracking(HttpServletRequest request, Model model) { //조회
		HttpSession session = request.getSession();
		IDao dao = sqlSession.getMapper(IDao.class);

		String id = (String)session.getAttribute("id");
		
		ArrayList<orderDto2> dtos = new ArrayList<orderDto2>();
		
		int totalCount = 0; // 총 게시물의 갯수
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {
			
		}
		
		
		if(session.getAttribute("member") == null) {
			return "web/nonMemberTracking";
		}
		else if(session.getAttribute("member").equals("customer")) {
			
			totalCount = dao.memberCount(id);
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			request.setAttribute("page", pInfo);
			
			String search = request.getParameter("search");
			request.setAttribute("search", search);
			
			String searchInfo = request.getParameter("info");
			request.setAttribute("info", searchInfo);
			
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			dtos = dao.memberTrack(nStart, nEnd, id);
			
			request.setAttribute("track", dtos);
			System.out.println("search: " + search);
			if(search == null || search.equals("")) {
				System.out.println("cccc");
				return "web/memberTracking";
				
			}
			else {
				return search(request,model);
			}

		}
		else if(session.getAttribute("member").equals("worker")) {
			
			totalCount = dao.workerCount(id);
			System.out.println("totalCount : " + totalCount);
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			request.setAttribute("page", pInfo);
			
			String search = request.getParameter("search");
			System.out.println("search : " + search );
			request.setAttribute("search", search);
			
			String searchInfo = request.getParameter("info");
			System.out.println("searchzzz : " + searchInfo);
			request.setAttribute("info", searchInfo);
			
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			dtos = dao.workTrack(nStart, nEnd, id);
			
			request.setAttribute("track", dtos);
			
			if(search == null || search.equals("")) {
				
				return "web/workTracking";
				
			}
			else {
				return search(request,model);
			}
		}
		else if(session.getAttribute("member").equals("master")) {
			String wk_Id = request.getParameter("wk_Id");
	
			if(wk_Id == null) {
				totalCount = dao.masterCount2();
			}
			else {
				session.setAttribute("wk_Id", wk_Id);
				totalCount = dao.masterCount(wk_Id);
			}
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			request.setAttribute("page", pInfo);
			
			String search = request.getParameter("search");
			request.setAttribute("search", search);
			
			String searchInfo = request.getParameter("info");
			request.setAttribute("info", searchInfo);
			
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			if(wk_Id == null) {
				model.addAttribute("track", dao.masterTrack2(nStart, nEnd));
			}
			else {
				model.addAttribute("track", dao.masterTrack(nStart, nEnd, wk_Id));
			}
		
			if(search == null || search.equals("")) {
				
				return "web/workTracking";
				
			}
			else {
				return search(request,model);
			}
		}
		
		return "home";
	}
	
	@RequestMapping("/trackingView") 
	public String trackingView(HttpServletRequest request, Model model) { // 조회 확인
		IDao dao = sqlSession.getMapper(IDao.class);
		
		orderDto2 dto = dao.tracking_View(Integer.parseInt(request.getParameter("cst_orderid")));
		String wk_Id = dto.getWk_ID();
		System.out.println("wk_Id : " + wk_Id);
		if(wk_Id != null)
		{
			workerDto dto2 = dao.tracking_Picture(wk_Id);
			model.addAttribute("picture", dto2);
		}
		
		request.setAttribute("order", dto);
		return "web/trackingView";
	}

	@RequestMapping("/search") 
	public String search(HttpServletRequest request, Model model) { // 검색
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		String wk_Id = (String)session.getAttribute("wk_Id");
		
		String id = (String)session.getAttribute("id");
		
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {}
		
		ArrayList<orderDto2> dtos = new ArrayList<orderDto2>();
		
		String searchInfo = request.getParameter("info");
		System.out.println("searchInfo : " + searchInfo);
		
		String searchText = request.getParameter("search");
		System.out.println("searchText : " +searchText);
		
		String check = (String)session.getAttribute("member");
		
		System.out.println("check : " + check);
	
		int totalCount = 0;
		
		String testDatepicker = request.getParameter("testDatepicker");
		String testDatepicker2 = request.getParameter("testDatepicker2");
			
		if(searchInfo.equals("orderRequestNumber"))
		{
			totalCount = dao.RequestNumberCount(searchText);
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			if(check == null) 
			{
				System.out.println("bbbb");
				dtos = dao.RequestNumberSearch(nStart, nEnd, searchText);
			}
			else if(check.equals("customer")){
				dtos = dao.RequestNumberSearch2(nStart, nEnd, searchText, id);
			}
			else if(check.equals("worker")) 
			{
				totalCount = dao.RequestNumberCount2(searchText,id);
				
				page = new articlePage();
				pInfo = page.aPage(nPage,totalCount);
				
				request.setAttribute("page", pInfo);
				session.setAttribute("cpage", nPage);
				
				nStart = pInfo.getnStart();
				nEnd = pInfo.getnEnd();
				
				if(testDatepicker.equals("") && testDatepicker2.equals(""))
				{
					dtos = dao.RequestNumberSearch3(nStart, nEnd,searchText, id);
				}
				else if(!(testDatepicker.equals("")) && testDatepicker2.equals(""))
				{
					dtos = dao.RequestNumberSearchDate1(nStart, nEnd, searchText, id, testDatepicker);
				}
				else if(testDatepicker.equals("") && !(testDatepicker2.equals("")))
				{
					dtos = dao.RequestNumberSearchDate2(nStart, nEnd, searchText, id, testDatepicker2);
				}
				else if(!(testDatepicker.equals("")) && !(testDatepicker2.equals("")))
				{
					dtos = dao.RequestNumberSearchDate3(nStart, nEnd, searchText, id, testDatepicker, testDatepicker2);
				}
				
			}
			else if(check.equals("master")) {
				
				if(wk_Id == null) totalCount = dao.masterRequestCount2(searchText);			
				else totalCount = dao.masterRequestCount(searchText, wk_Id);
											
				page = new articlePage();
				pInfo = page.aPage(nPage,totalCount);
				
				request.setAttribute("page", pInfo);
				session.setAttribute("cpage", nPage);
				
				nStart = pInfo.getnStart();
				nEnd = pInfo.getnEnd();
				
				if(testDatepicker.equals("") && testDatepicker2.equals(""))
				{
					if(wk_Id == null) dtos = dao.masterRequestSearch(nStart, nEnd,searchText, wk_Id);
					
					else dtos = dao.masterRequestSearch(nStart, nEnd,searchText, wk_Id);
					
					
				}
				else if(!(testDatepicker.equals("")) && testDatepicker2.equals(""))
				{
					if(wk_Id == null) dtos = dao.masterRequestSearchDate1_2(nStart, nEnd, searchText, testDatepicker);
					
					else dtos = dao.masterRequestSearchDate1(nStart, nEnd, searchText, wk_Id, testDatepicker);
					
					
				}
				else if(testDatepicker.equals("") && !(testDatepicker2.equals("")))
				{
					if(wk_Id == null) dtos = dao.masterRequestSearchDate2_2(nStart, nEnd, searchText, testDatepicker2);
					
					else dtos = dao.masterRequestSearchDate2(nStart, nEnd, searchText, wk_Id, testDatepicker2);
				}
				else if(!(testDatepicker.equals("")) && !(testDatepicker2.equals("")))
				{
					if(wk_Id == null) dtos = dao.masterRequestSearchDate3_2(nStart, nEnd, searchText, testDatepicker, testDatepicker2);
						
					else dtos = dao.masterRequestSearchDate3(nStart, nEnd, searchText, wk_Id, testDatepicker, testDatepicker2);
				}
			}
			
			
			
			request.setAttribute("track", dtos);
			request.setAttribute("search", searchText);
			request.setAttribute("info", searchInfo);
			request.setAttribute("testDatepicker", testDatepicker);
			request.setAttribute("testDatepicker2", testDatepicker2);
			
			if(check == null){
				System.out.println("aaaa");
				return "web/nonMemberTracking";
			}
			else if(check.equals("customer")) {
				System.out.println("bbbb");
				return "web/memberTracking";
			}
			else if(check.equals("worker")) {
				System.out.println("cccc");
				return "web/workTracking";
			}
			else if(check.equals("master")) {
				return "web/workTracking";
			}
			
			
		}
		else if(searchInfo.equals("cstName")) {
			
			totalCount = dao.cstNameCount(searchText);
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();

			if(check.equals("customer")){
				dtos = dao.cstName(nStart, nEnd, searchText, id);
			}
			else if(check.equals("worker")) {
				totalCount = dao.cstNameCount2(searchText,id);
				System.out.println("testDatepicker : " + testDatepicker);
				page = new articlePage();
				pInfo = page.aPage(nPage,totalCount);
				
				request.setAttribute("page", pInfo);
				session.setAttribute("cpage", nPage);
				
				nStart = pInfo.getnStart();
				nEnd = pInfo.getnEnd();
				
				if(testDatepicker.equals("") && testDatepicker2.equals(""))
				{
					dtos = dao.cstName2(nStart, nEnd, searchText, id);
				}
				else if(!(testDatepicker.equals("")) && testDatepicker2.equals(""))
				{
					dtos = dao.cstNameDate1(nStart, nEnd, searchText, id, testDatepicker);
				}
				else if(testDatepicker.equals("") && !(testDatepicker2.equals("")))
				{
					dtos = dao.cstNameDate2(nStart, nEnd, searchText, id, testDatepicker2);
				}
				else if(!(testDatepicker.equals("")) && !(testDatepicker2.equals("")))
				{
					dtos = dao.cstNameDate3(nStart, nEnd, searchText, id, testDatepicker, testDatepicker2);
				}

			}
			else if(check.equals("master")) {
				if(wk_Id == null) totalCount = dao.masterCstNameCount2(searchText);			
				else totalCount = dao.masterCstNameCount(searchText,wk_Id);
				
				System.out.println("testDatepicker : " + testDatepicker);
				page = new articlePage();
				pInfo = page.aPage(nPage,totalCount);
				
				request.setAttribute("page", pInfo);
				session.setAttribute("cpage", nPage);
				
				nStart = pInfo.getnStart();
				nEnd = pInfo.getnEnd();
				
				if(testDatepicker.equals("") && testDatepicker2.equals(""))
				{
					if(wk_Id == null) dtos = dao.masterCstName2(nStart, nEnd, searchText);				
					else dtos = dao.masterCstName(nStart, nEnd, searchText, wk_Id);				
				}
				else if(!(testDatepicker.equals("")) && testDatepicker2.equals(""))
				{
					if(wk_Id == null) dtos = dao.masterCstNameDate1_2(nStart, nEnd, searchText, testDatepicker);				
					else dtos = dao.masterCstNameDate1(nStart, nEnd, searchText, wk_Id, testDatepicker);
					
				}
				else if(testDatepicker.equals("") && !(testDatepicker2.equals("")))
				{
					if(wk_Id == null) dtos = dao.masterCstNameDate2_2(nStart, nEnd, searchText, testDatepicker2);				
					else dtos = dao.masterCstNameDate2(nStart, nEnd, searchText, wk_Id, testDatepicker2);
					
				}
				else if(!(testDatepicker.equals("")) && !(testDatepicker2.equals("")))
				{			
					if(wk_Id == null) dtos = dao.masterCstNameDate3_2(nStart, nEnd, searchText,testDatepicker, testDatepicker2);			
					else dtos = dao.masterCstNameDate3(nStart, nEnd, searchText, wk_Id, testDatepicker, testDatepicker2);
					
				}
			}

			request.setAttribute("track", dtos);
			request.setAttribute("search", searchText);
			request.setAttribute("info", searchInfo);
			request.setAttribute("testDatepicker", testDatepicker);
			request.setAttribute("testDatepicker2", testDatepicker2);
			
			if(check.equals("customer")) {
				return "web/memberTracking";
			}
			else if(check.equals("worker")) {
				return "web/workTracking";
			}
			else if(check.equals("master")) {
				return "web/workTracking";
			}

		}
		else if(searchInfo.equals("arriveName")) {
			totalCount = dao.arriveNameCount(searchText);
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			if(check.equals("customer")){
				dtos = dao.arriveName(nStart, nEnd, searchText,id);
			}
			else if(check.equals("worker")) {
				totalCount = dao.arriveNameCount2(searchText, id);
				
				page = new articlePage();
				pInfo = page.aPage(nPage,totalCount);
				
				request.setAttribute("page", pInfo);
				session.setAttribute("cpage", nPage);
				
				nStart = pInfo.getnStart();
				nEnd = pInfo.getnEnd();
				
				if(testDatepicker.equals("") && testDatepicker2.equals(""))
				{
					dtos = dao.arriveName2(nStart, nEnd, searchText,id);
				}
				else if(!(testDatepicker.equals("")) && testDatepicker2.equals(""))
				{
					dtos = dao.arriveNameDate1(nStart, nEnd, searchText, id, testDatepicker);
				}
				else if(testDatepicker.equals("") && !(testDatepicker2.equals("")))
				{
					dtos = dao.arriveNameDate2(nStart, nEnd, searchText, id, testDatepicker2);
				}
				else if(!(testDatepicker.equals("")) && !(testDatepicker2.equals("")))
				{
					dtos = dao.arriveNameDate3(nStart, nEnd, searchText, id, testDatepicker, testDatepicker2);
				}
			}	
			else if(check.equals("master")) {
				if(wk_Id == null) totalCount = dao.masterArriveNameCount2(searchText);		
				else totalCount = dao.masterArriveNameCount(searchText,wk_Id);
				
				System.out.println("testDatepicker : " + testDatepicker);
				page = new articlePage();
				pInfo = page.aPage(nPage,totalCount);
				
				request.setAttribute("page", pInfo);
				session.setAttribute("cpage", nPage);
				
				nStart = pInfo.getnStart();
				nEnd = pInfo.getnEnd();
				
				if(testDatepicker.equals("") && testDatepicker2.equals(""))
				{
					if(wk_Id == null) dtos = dao.masterArriveName2(nStart, nEnd, searchText);					
					else dtos = dao.masterArriveName(nStart, nEnd, searchText, wk_Id);			
				}
				else if(!(testDatepicker.equals("")) && testDatepicker2.equals(""))
				{
					if(wk_Id == null) dtos = dao.masterArriveNameDate1_2(nStart, nEnd, searchText, testDatepicker);					
					else dtos = dao.masterArriveNameDate1(nStart, nEnd, searchText, wk_Id, testDatepicker);			
				}
				else if(testDatepicker.equals("") && !(testDatepicker2.equals("")))
				{
					if(wk_Id == null) dtos = dao.masterArriveNameDate2_2(nStart, nEnd, searchText, testDatepicker2);			
					else dtos = dao.masterArriveNameDate2(nStart, nEnd, searchText, wk_Id, testDatepicker2);				
				}
				else if(!(testDatepicker.equals("")) && !(testDatepicker2.equals("")))
				{
					if(wk_Id == null) dtos = dao.masterArriveNameDate3_2(nStart, nEnd, searchText, testDatepicker, testDatepicker2);				
					else dtos = dao.masterArriveNameDate3(nStart, nEnd, searchText, wk_Id, testDatepicker, testDatepicker2);				
				}
			}
			request.setAttribute("track", dtos);
			request.setAttribute("search", searchText);
			request.setAttribute("info", searchInfo);
			request.setAttribute("testDatepicker", testDatepicker);
			request.setAttribute("testDatepicker2", testDatepicker2);
			
			if(check.equals("customer")) {
				return "web/memberTracking";
			}
			else if(check.equals("worker")) {
				return "web/workTracking";
			}
			else if(check.equals("master")) {
				return "web/workTracking";
			}
		}
		else if(searchInfo.equals("workerName"))
		{		
			totalCount = dao.wk_NameCount(searchText); 
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			page = new articlePage();
			pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			nStart = pInfo.getnStart();
			nEnd = pInfo.getnEnd();
			
			model.addAttribute("search", searchText);
			model.addAttribute("info", searchInfo);
			model.addAttribute("list", dao.wk_NameSearch(nEnd, nStart, searchText));
			
			return "web/workerList";
		}
		else if(searchInfo.equals("workerPhone"))
		{
			totalCount = dao.wk_PhoneCount(searchText);
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			page = new articlePage();
			pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			model.addAttribute("search", searchText);
			model.addAttribute("info", searchInfo);
			model.addAttribute("list", dao.wk_PhoneSearch(nEnd, nStart, searchText));
			
			return "web/workerList";
		}
		else if(searchInfo.equals("workerId"))
		{
			totalCount = dao.wk_IdCount(searchText);
			
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			page = new articlePage();
			pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			model.addAttribute("search", searchText);
			model.addAttribute("info", searchInfo);
			model.addAttribute("list", dao.wk_IdSearch(nEnd, nStart, searchText));
			
			return "web/workerList";
		}
		else if(searchInfo.equals("writerId"))
		{
			int bCheck = (int)session.getAttribute("bCheck");
			totalCount = dao.wt_IdCount(searchText, bCheck);
					
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			page = new articlePage();
			pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			
			model.addAttribute("search", searchText);
			model.addAttribute("info", searchInfo);
			model.addAttribute("list", dao.wt_IdSearch(nEnd, nStart, searchText, bCheck));
			
			return "web/QandA";
			
		}
		else if(searchInfo.equals("writerTitle"))
		{
			int bCheck = (int)session.getAttribute("bCheck");
			System.out.println("bCheck : " + bCheck);
			totalCount= dao.wt_TitleCount(searchText, bCheck);
			System.out.println("cccc");
			articlePage page = new articlePage();
			BPageInfo pInfo = page.aPage(nPage,totalCount);
			page = new articlePage();
			pInfo = page.aPage(nPage,totalCount);
			
			request.setAttribute("page", pInfo);
			session.setAttribute("cpage", nPage);
			
			int nStart = pInfo.getnStart();
			int nEnd = pInfo.getnEnd();
			System.out.println("dddd");
			model.addAttribute("search", searchText);
			model.addAttribute("info", searchInfo);
			model.addAttribute("list", dao.wt_TitleSearch(nEnd, nStart, searchText, bCheck));
			
			if(bCheck == 1) return "web/QandA";
			else if(bCheck == 2) return "web/customerNotice";
			else if(bCheck == 3) return "web/workerNotice";
		}
		return "home";
	}
	
	@RequestMapping("/QandA")
	public String list(HttpServletRequest request, Model model) { //고객 센터
//		ArrayList<ContentDto> dtos = dao.listDao();
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		session.setAttribute("url", "service"); // 고객센터는 service, 게시판은 상준이 맘대로
		
		session.setAttribute("bCheck", 1); // 게시판 구분.
		int bCheck = (int)session.getAttribute("bCheck");
		
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {}
		
		int totalCount = dao.listCount(bCheck);
		
		articlePage page = new articlePage();
		BPageInfo pInfo = page.aPage(nPage,totalCount);
		
		request.setAttribute("page", pInfo);
		session.setAttribute("cpage", nPage);
		
		int nStart = pInfo.getnStart();
		int nEnd = pInfo.getnEnd();
			
		model.addAttribute("list", dao.list(nStart, nEnd, bCheck));
		
		return "web/QandA";
	}
	
	@RequestMapping("/service_write") 
	public String writeForm(HttpServletRequest request, Model model) { // 고객 센터 글 작성 페이지
		
		model.addAttribute("bName", request.getParameter("bName"));
		return "web/service_write";
	}
	
	@RequestMapping("/serviceWrite")
	public String write(HttpServletRequest request, Model model) { // 고객 센터 글 작성
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		int bCheck = (int)session.getAttribute("bCheck");
		dao.write(request.getParameter("bName"), request.getParameter("bTitle"), request.getParameter("bContent"),bCheck);
		String bUrl = (String)session.getAttribute("bUrl");
		
		System.out.println("bUrl : " + bUrl);
		
		if(bUrl.equals("notice"))
		{
			return "redirect:notice";		
		}
		else if(bUrl.equals("QandA"))
		{
			return "redirect:QandA";
		}
		
		return "home";
		
	}
	
	@RequestMapping("notice_View")
	public String notice_View(HttpServletRequest request, Model model) { // 안드로이드 공지사항 내용 보기
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		session.removeAttribute("check");
		
		BDto dto = dao.contentView(Integer.parseInt(request.getParameter("bId")));
		
		request.setAttribute("content_view", dto);
		
		dao.upHit(Integer.parseInt(request.getParameter("bId")));
		return "android/notice_View";
	}
	
	@RequestMapping("/service_view") 
	public String contentView(HttpServletRequest request, Model model) { // 고객 센터 상세 게시물 보기
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		session.removeAttribute("check");
		BDto dto = dao.contentView(Integer.parseInt(request.getParameter("bId")));
		String id = (String)session.getAttribute("id");
		String member = (String)session.getAttribute("member");
		String bName = dto.getbName();
		System.out.println("bName : " + bName);
		if(member == null)
		{
			session.setAttribute("check", "non");
		}
		else if((member.equals("customer")) || member.equals("worker"))
		{
			if(id.equals(bName))
			session.setAttribute("check", "yes");
			else
			session.setAttribute("check", "no");
		}
		else if(member.equals("master"))
		{
			session.setAttribute("check", "master");
		}
		
		request.setAttribute("content_view", dto);
		
		dao.upHit(Integer.parseInt(request.getParameter("bId")));
		System.out.println("aaa");
		return "web/service_view";
	}
	
	@RequestMapping("/serviceModify_view") 
	public String modifyView(HttpServletRequest request, Model model) { // 고객 센터 게시물 수정 폼 보기
		IDao dao = sqlSession.getMapper(IDao.class);
		BDto dto = dao.contentView(Integer.parseInt(request.getParameter("bId")));

		request.setAttribute("content_view", dto);
		return "web/serviceModify_view";
	}
	
	@RequestMapping("/modify")
	public String modify(HttpServletRequest request, Model model) { // 게시물 수정
		IDao dao = sqlSession.getMapper(IDao.class);
		dao.modify(Integer.parseInt(request.getParameter("bId")), request.getParameter("bName"), request.getParameter("bTitle"), request.getParameter("bContent"));
		
		BDto dto = dao.contentView(Integer.parseInt(request.getParameter("bId")));
		
		request.setAttribute("content_view", dto);
		return "web/service_view";
	}
		
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request, Model model) { // 게시물 삭제
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		
		String bUrl = (String)session.getAttribute("bUrl");
		dao.delete(Integer.parseInt(request.getParameter("bId")));
		
		if(bUrl.equals("QandA")) return "redirect:QandA";
		else if(bUrl.equals("notice")) return "redirect:notice";
		else return "home";
		
		
		
	}
	
	@RequestMapping("/reply_view")
	public String replyView(HttpServletRequest request, Model model) { // 답변 뷰
		IDao dao = sqlSession.getMapper(IDao.class);
		BDto dto = dao.replyView(Integer.parseInt(request.getParameter("bId")));
		
		request.setAttribute("reply_view", dto);
		return "web/reply_view";
	}
	
	@RequestMapping("/reply")
	public String reply(HttpServletRequest request, Model model) { // 답변 적기
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();		
		
		String bName = request.getParameter("bName");
		String bTitle = request.getParameter("bTitle");
		String bContent = request.getParameter("bContent");
		int bGroup = Integer.parseInt(request.getParameter("bGroup"));
		int bStep = Integer.parseInt(request.getParameter("bStep"));
		int bIndent = Integer.parseInt( request.getParameter("bIndent"));
		int bCheck = (int)session.getAttribute("bCheck");
		
		dao.replyShape(bGroup, bStep);
		System.out.println("bname : " + bName + ", bTitle : " + bTitle +", bContent : " + bContent + ", bGroup :" + bGroup +", bStep : " + bStep + ", bIndent : " + bIndent + ", bCheck : " + bCheck);
		dao.reply(bName, bTitle, bContent, bGroup, bStep, bIndent, bCheck);

		return "redirect:QandA";
	}
	
	@RequestMapping("/consulting")
	public String chatt(HttpServletRequest request, Model model) { // 1 대 1 고객 상담
		HttpSession session = request.getSession();	
		String member = (String)session.getAttribute("member");
		String id = (String)session.getAttribute("id");
		
		model.addAttribute("member", member);
		model.addAttribute("id", id);
		return "web/consulting";
	}

	@RequestMapping("/workerList")
	public String workerList(HttpServletRequest request, Model model) { // 관리자 기사 리스트
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {}

		int totalCount = dao.workCount();
			
		articlePage page = new articlePage();
		BPageInfo pInfo = page.aPage(nPage,totalCount);
			
		request.setAttribute("page", pInfo);
		session.setAttribute("cpage", nPage);
			
		int nStart = pInfo.getnStart();
		int nEnd = pInfo.getnEnd();
		
		String search = request.getParameter("search");
		request.setAttribute("search", search);
		
		model.addAttribute("list", dao.workerList(nStart, nEnd));
					
		if(search == null || search.equals("")) {
			
			return "web/workerList";
			
		}
		else {
			return search(request,model);
		}

	}
	
	@RequestMapping("/work_view")
	public String work_view(HttpServletRequest request, Model model) { //기사 상세 정보
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String id = request.getParameter("wk_Id");
		model.addAttribute("content_view", dao.workerInfo(id));
		
		return "web/work_view";
	}
	
	@RequestMapping("/totalCount")
	public void totalCount(HttpServletRequest request, HttpServletResponse response, Model model) throws ServletException, IOException { // 기간별 배송 횟수
		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		
		int count = 0;
		String wk_Id = request.getParameter("wk_Id");
		String testDatepicker = request.getParameter("testDatepicker");
		String testDatepicker2 = request.getParameter("testDatepicker2");
		System.out.println("testDatepicker : " + testDatepicker + ", testDatepicker2 : "+testDatepicker2);
		if(testDatepicker.equals("") && testDatepicker2.equals(""))
		{
			count = dao.workCount1(wk_Id);
			obj.put("result", "ok");
		}
		else if(!(testDatepicker.equals("")) && testDatepicker2.equals(""))
		{
			count = dao.workCount2(wk_Id, testDatepicker);
			obj.put("result", "ok");
		}
		else if(testDatepicker.equals("") && !(testDatepicker2.equals("")))
		{
			count = dao.workCount3(wk_Id, testDatepicker2);
			obj.put("result", "ok");
		}
		else if(!(testDatepicker.equals("")) && !(testDatepicker2.equals("")))
		{
			count = dao.workCount4(wk_Id, testDatepicker, testDatepicker2);
			obj.put("result", "ok");
		}
		String str = count+"회";
		obj.put("desc", str);
		System.out.println("obj : "+obj);
		writer.println(obj);
	}

	@RequestMapping("/addWorkerWrite")
	public String addWorker(Model model) { //기사 추가 폼
		
		return "web/addWorkerWrite";
	}
	
	@RequestMapping("/addView")
	public String addView(HttpServletRequest request, Model model) { //입력한 기사정보 보기
		
		pictureUpload picture = new pictureUpload();
		model.addAttribute("returnObj", picture.upload(request));			
	// uuid 생성할 메소드 선언
	/*
	 * UUID(Universally unique identifier), 범용 고유 식별자.
	 * UUID.randomUUID().toString() 으로 생성하면 
	 * b7389ffc-eca7-40cc-b09b-d46cfdc095bd
	 * 와 같이 4개의 하이픈과 32개의 문자로 이루어진 문자열을 반환한다.
	 */
		
		return "web/addView";
	}
	
	@RequestMapping("/addResult")
	public String addResult(HttpServletRequest request, Model model) { // 입력한 기사정보 마지막 확인
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String wk_Picture = request.getParameter("saveFileName");
		String wk_Name = request.getParameter("wk_Name");
		String wk_Id = request.getParameter("wk_Id");
		String wk_Password = request.getParameter("wk_Password");
		String wk_Phone = request.getParameter("wk_Phone");
		
		dao.addWorker(wk_Id, wk_Name, wk_Password, wk_Phone, wk_Picture);
		
		return "redirect:workerList";
	}
	
	@RequestMapping("/revoke")
	public String cancel(HttpServletRequest request, Model model) { //배송 요청 취소
		IDao dao = sqlSession.getMapper(IDao.class);
		
		int cst_orderId = Integer.parseInt(request.getParameter("cst_orderid"));
		System.out.println("cst_orderid : " + cst_orderId);
		
		dao.cancel(cst_orderId);
		
		return "redirect:tracking";
	}
	
	@RequestMapping("/deleteWorker")
	public void deleteWorker(HttpServletRequest request, HttpServletResponse response, Model model)throws ServletException, IOException  { //기사 삭제(ajax)
		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		System.out.println("abc");
		JSONObject obj = new JSONObject();
		String[] wk_Id = request.getParameterValues("wk_Id");
		System.out.println("wk_Id : " + wk_Id);
		for(int i = 0; i < wk_Id.length; i++)
		{
			dao.deleteWorker(wk_Id[i]);
		}
	
		System.out.println("ghi");
		obj.put("result", "ok");
		System.out.println("obj : " + obj);
		writer.println(obj);
	}
	
	@RequestMapping("/deleteWorker2")
	public String deleteWorker2(HttpServletRequest request, Model model) { //기사 삭제(개인)
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String wk_Id = request.getParameter("wk_Id");
		dao.deleteWorker(wk_Id);
		
		return "redirect:workerList";
	}
	
	@RequestMapping("/workerModify")
	public String workerModify(HttpServletRequest request, Model model) { //기사 정보 수정
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String wk_Id = request.getParameter("wk_Id");
		workerDto dto = dao.workerInfo(wk_Id);
		
		model.addAttribute("dto", dto);
		
		return "web/workerModify";
	}
	
	@RequestMapping("/workerModifyView")
	public String workerModifyView(HttpServletRequest request, Model model) {
		pictureUpload picture = new pictureUpload();
		model.addAttribute("returnObj", picture.upload(request));	
		
		return "web/workerModifyView";
	}
	
	@RequestMapping("/modifyResult")
	public String modifyResult(HttpServletRequest request, Model model) {
		IDao dao = sqlSession.getMapper(IDao.class);

		String wk_Id = request.getParameter("wk_Id");
		String wk_Name = request.getParameter("wk_Name");
		String wk_Password = request.getParameter("wk_Password");
		String wk_Phone = request.getParameter("wk_Phone");
		String wk_Picture = request.getParameter("saveFileName");
		dao.modifyWorker(wk_Id, wk_Name, wk_Password, wk_Phone, wk_Picture);
		
		model.addAttribute("content_view", dao.workerInfo(wk_Id));
		
		return "web/work_view";
	}
	
	@RequestMapping("/createId")
	public void createId(HttpServletRequest request, HttpServletResponse response, Model model)throws ServletException, IOException {
		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		
		String id = null;
	
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String location = request.getParameter("location");
		
		int count = dao.workerNumber();
		count = count + 1;
		String num = "";
		if(count < 10) {
			num ="00"+count;
		}
		else if(count < 100) {
			num = "0"+count;
		}
		id = location + year + month + num;
		
		JSONObject obj = new JSONObject();
		
		obj.put("result", "ok");
		obj.put("id", id);
		
		writer.println(obj);
	}
	
	@RequestMapping("/zipSaveCon")
	public void zipSave(HttpServletRequest request, HttpServletResponse response, Model model)throws ServletException, IOException{ // 즐겨찾기 출발지 저장
		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		
		System.out.println("aaaa");
		JSONObject obj = new JSONObject();
		String cst_Id = request.getParameter("cst_Id");
		String check = request.getParameter("check");
		String address = request.getParameter("address");
		String detail = request.getParameter("detail");
		
		int count = dao.customerCount(cst_Id);

		if(check.equals("first"))
		{
			if(count == 0) dao.insertCustomer1(cst_Id, address, detail);	
			else dao.updateCustomer1(cst_Id, address, detail);
			
			obj.put("result", "ok");
		}
		else if(check.equals("second"))
		{
			if(count == 0) dao.insertCustomer2(cst_Id, address, detail);		
			else dao.updateCustomer2(cst_Id, address, detail);
			
			obj.put("result", "ok");
		}
		else if(check.equals("third"))
		{
			if(count == 0) dao.insertCustomer3(cst_Id, address, detail);		
			else dao.updateCustomer3(cst_Id, address, detail);
			
			obj.put("result", "ok");
		}
		
		writer.println(obj);
	}
	
	@RequestMapping("/arriveSave")
	public void arriveSave(HttpServletRequest request, HttpServletResponse response, Model model)throws ServletException, IOException{ //즐겨찾기 도착지 저장
		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		String cst_Id = request.getParameter("cst_Id");
		String check = request.getParameter("check");
		String address = request.getParameter("address");
		String detail = request.getParameter("detail");
		
		int count = dao.customerCount(cst_Id);

		if(check.equals("first"))
		{
			if(count == 0) dao.insertArrive1(cst_Id, address, detail);	
			else dao.updateArrive1(cst_Id, address, detail);
			
			obj.put("result", "ok");
		}
		else if(check.equals("second"))
		{
			if(count == 0) dao.insertArrive2(cst_Id, address, detail);		
			else dao.updateArrive2(cst_Id, address, detail);
			
			obj.put("result", "ok");
		}
		else if(check.equals("third"))
		{
			if(count == 0) dao.insertArrive3(cst_Id, address, detail);		
			else dao.updateArrive3(cst_Id, address, detail);
			
			obj.put("result", "ok");
		}

		writer.println(obj);
	}
	
	@RequestMapping("/startLocation")
	public void startLocation(HttpServletRequest request, HttpServletResponse response, Model model)throws ServletException, IOException{ //즐겨찾기 출발지 호출
		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		
		String cst_Id = request.getParameter("cst_Id");
		
	
		cst_zip startZip = new cst_zip(); 
		startZip = dao.selectCustomer1(cst_Id);
		
		String cst_zip1 = startZip.getCst_zip1();
		String cst_detail1 = startZip.getCst_detail1();
		String cst_zip2 = startZip.getCst_zip2();
		String cst_detail2 = startZip.getCst_detail2();
		String cst_zip3 = startZip.getCst_zip3();
		String cst_detail3 = startZip.getCst_detail3();
		
		if(cst_zip1 == null && cst_detail1 == null)
		{
			cst_zip1 = ""; cst_detail1 = "";
		}
		if(cst_zip2 == null && cst_detail2 == null)
		{
			cst_zip2 = ""; cst_detail2 = "";
		}
		if(cst_zip3 == null && cst_detail3 == null)
		{
			cst_zip3 = ""; cst_detail3 = "";
		}
		
		obj.put("result", "ok");
		obj.put("cst_zip1", cst_zip1);
		obj.put("cst_detail1", cst_detail1);
		obj.put("cst_zip2", cst_zip2);
		obj.put("cst_detail2", cst_detail2);
		obj.put("cst_zip3", cst_zip3);
		obj.put("cst_detail3", cst_detail3);
		
		writer.println(obj);
		
	}
	
	@RequestMapping("/arriveLocation")
	public void arriveLocation(HttpServletRequest request, HttpServletResponse response, Model model)throws ServletException, IOException{ //즐겨찾기 도착지 호출
		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		
		String cst_Id = request.getParameter("cst_Id");
		
		cst_zip arriveZip = new cst_zip(); 
		arriveZip = dao.selectArrive1(cst_Id);

		String arrive_zip1 = arriveZip.getArrive_zip1();
		String arrive_detail1 = arriveZip.getArrive_detail1();
		String arrive_zip2 = arriveZip.getArrive_zip2();
		String arrive_detail2 = arriveZip.getArrive_detail2();
		String arrive_zip3 = arriveZip.getArrive_zip3();
		String arrive_detail3 = arriveZip.getArrive_detail3();
		
		if(arrive_zip1 == null && arrive_detail1 == null)
		{
			arrive_zip1 = ""; arrive_detail1 = "";
		}
		if(arrive_zip2 == null && arrive_detail2 == null)
		{
			arrive_zip2 = ""; arrive_detail2 = "";
		}
		if(arrive_zip3 == null && arrive_detail3 == null)
		{
			arrive_zip3 = ""; arrive_detail3 = "";
		}
		
		obj.put("result", "ok");
		obj.put("arrive_zip1", arrive_zip1);
		obj.put("arrive_detail1", arrive_detail1);
		obj.put("arrive_zip2", arrive_zip2);
		obj.put("arrive_detail2", arrive_detail2);
		obj.put("arrive_zip3", arrive_zip3);
		obj.put("arrive_detail3", arrive_detail3);

		writer.println(obj);
	}
	
	@RequestMapping("/cst_notice")
	public String cst_notice(HttpServletRequest request, Model model) {
		IDao dao = sqlSession.getMapper(IDao.class);
		int bCheck = 2;
		HttpSession session = request.getSession();
		session.setAttribute("bCheck", 2);
		
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {}
		
		int totalCount = dao.listCount(bCheck);
		articlePage page = new articlePage();
		BPageInfo pInfo = page.aPage(nPage,totalCount);
		
		request.setAttribute("page", pInfo);
		session.setAttribute("cpage", nPage);
		
		int nStart = pInfo.getnStart();
		int nEnd = pInfo.getnEnd();
		
		model.addAttribute("list", dao.list(nStart, nEnd, bCheck));
		
		return "android/cst_notice";
	}
	
	@RequestMapping("/wk_notice")
	public String wk_notice(HttpServletRequest request, Model model) {
		IDao dao = sqlSession.getMapper(IDao.class);
		int bCheck = 3;
		HttpSession session = request.getSession();
		session.setAttribute("bCheck", 3);
		
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {}
		
		int totalCount = dao.listCount(bCheck);
		articlePage page = new articlePage();
		BPageInfo pInfo = page.aPage(nPage,totalCount);
		
		request.setAttribute("page", pInfo);
		session.setAttribute("cpage", nPage);
		
		int nStart = pInfo.getnStart();
		int nEnd = pInfo.getnEnd();
		
		model.addAttribute("list", dao.list(nStart, nEnd, bCheck));
		
		return "android/wk_notice";
	}
	
	@RequestMapping("/notice")
	public String notice(HttpServletRequest request, Model model) { //고객 센터
//		ArrayList<ContentDto> dtos = dao.listDao();
		IDao dao = sqlSession.getMapper(IDao.class);
		HttpSession session = request.getSession();
		session.setAttribute("url", "notice"); // 고객센터는 service, 게시판은 상준이 맘대로
		String member = (String)session.getAttribute("member");
		int bCheck = 0;
		
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch(Exception e) {}
		
		if(member == null || member.equals("customer"))
		{
			bCheck = 2; // 게시판 구분.	
			session.setAttribute("bCheck", 2);
		}
		else if(member.equals("worker"))
		{
			bCheck = 3; // 게시판 구분.
			session.setAttribute("bCheck", 3);
		}
		else if(member.equals("master"))
		{
			String num = request.getParameter("bCheck");
			if(num == null)
			{
				bCheck = (int)session.getAttribute("bCheck");
			}
			else
			{
				bCheck = Integer.parseInt(request.getParameter("bCheck"));
			}
			
			session.setAttribute("bCheck", bCheck);
		}

		int totalCount = dao.listCount(bCheck);
		
		articlePage page = new articlePage();
		BPageInfo pInfo = page.aPage(nPage,totalCount);
		
		request.setAttribute("page", pInfo);
		session.setAttribute("cpage", nPage);
		
		int nStart = pInfo.getnStart();
		int nEnd = pInfo.getnEnd();
			
		model.addAttribute("list", dao.list(nStart, nEnd, bCheck));
		
		if(bCheck == 2)
		{
			return "web/customerNotice";
		}
		else if(bCheck == 3)
		{
			return "web/workerNotice";
		}
		
		return "web/home";
	}
	
	@RequestMapping("/pay_info")
	public String pay_info(Model model) // 요금 정보
	{
		return "web/pay_info";
	}
	
	@RequestMapping("payTracking")
	public String payTracking(Model model) // 요금 조회
	{
		return "web/payTracking";
	}
	
	@RequestMapping("payInfo")
	public void payTracking(HttpServletRequest request, HttpServletResponse response, Model model) throws ServletException, IOException  //요금 조회
	{

		IDao dao = sqlSession.getMapper(IDao.class);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		
		JSONObject obj = new JSONObject();
		
		String startZip = request.getParameter("startZip");
		String arriveZip = request.getParameter("arriveZip");
		
		int pay = dao.payTracking(startZip, arriveZip);
		
		obj.put("result", "ok");
		obj.put("pay", pay);
		
		writer.println(obj);
	}
	
	@RequestMapping("comeLoad")
	public String comeLoad(Model model)
	{
		return "web/comeLoad";
	}
	
	@RequestMapping("greeting")
	public String greeting(Model model) 
	{
		return "web/greeting";
	}
	
	@RequestMapping("/chart")
	public void chart(HttpServletRequest request, HttpServletResponse response, Model model) throws ServletException, IOException
	{
		IDao dao = sqlSession.getMapper(IDao.class);
		Calendar cal = Calendar.getInstance ();
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		String wk_Id = request.getParameter("wk_Id");
		JSONObject obj = new JSONObject();
		
		int day = 0;
		cal.add ( cal.MONTH, -2 );
		System.out.println(cal.get(cal.MONTH));
		int i = cal.get(cal.MONTH);
		day = dao.threeMonth(wk_Id);
		obj.put("three", i);
		obj.put("threeCount", day);
		
		
		
		System.out.println("cal.month -3 :"+i);
		
		cal.add(cal.MONTH,+1);
		i = cal.get(cal.MONTH);
		day = dao.twoMonth(wk_Id);
		obj.put("two", i);
		obj.put("twoCount", day);
		
		System.out.println("cal.month -2 :"+i);
		
		cal.add(cal.MONTH,+1);
		i = cal.get(cal.MONTH);
		day = dao.oneMonth(wk_Id);
		obj.put("one", i);
		obj.put("oneCount", day);
		
		System.out.println("cal.month -1 :"+i);
		
		cal.add(cal.MONTH,+1);
		i = cal.get(cal.MONTH);
		day = dao.nowMonth(wk_Id);
		obj.put("now", i);
		obj.put("nowCount", day);
		
		System.out.println("cal.month :"+i);
		
		obj.put("result", "ok");
		System.out.println(obj);
		writer.println(obj);
		
	}
	
	@RequestMapping("/allChart")
	public void allChart(HttpServletRequest request, HttpServletResponse response, Model model) throws ServletException, IOException
	{
		IDao dao = sqlSession.getMapper(IDao.class);
		
		String chooseMonth = "";
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();		
		request.setCharacterEncoding("UTF-8");
		JSONObject obj = new JSONObject();
		String month = request.getParameter("month");
		if(month == null || month.equals("choose"))
		{
			Calendar cal = Calendar.getInstance ();
			int day = 0;
			cal.add ( cal.MONTH, -2 );
			System.out.println(cal.get(cal.MONTH));
			int i = cal.get(cal.MONTH);
			day = dao.allThreeMonth();
			obj.put("three", i);
			obj.put("threeCount", day);
				
			cal.add(cal.MONTH,+1);
			i = cal.get(cal.MONTH);
			day = dao.allTwoMonth();
			obj.put("two", i);
			obj.put("twoCount", day);
			
			System.out.println("cal.month -2 :"+i);
			
			cal.add(cal.MONTH,+1);
			i = cal.get(cal.MONTH);
			day = dao.allOneMonth();
			obj.put("one", i);
			obj.put("oneCount", day);
			
			System.out.println("cal.month -1 :"+i);
			
			cal.add(cal.MONTH,+1);
			i = cal.get(cal.MONTH);
			day = dao.allNowMonth();
			obj.put("now", i);
			obj.put("nowCount", day);
			
			System.out.println("cal.month :"+i);
			
			obj.put("result", "ok");
			System.out.println(obj);
		}
		else
		{
			Calendar cal2 = Calendar.getInstance ();
			if(month.equals("one")) 
			{
				cal2.set(Calendar.MONTH, 0);
				chooseMonth = "20180103";
			}
			else if(month.equals("two")) 
			{ 
				cal2.set(Calendar.MONTH, 1);
				chooseMonth = "20180203";
			}
			else if(month.equals("three")) 
			{
				cal2.set(Calendar.MONTH, 2);
				chooseMonth = "20180303";
			}
			else if(month.equals("four")) 
			{
				cal2.set(Calendar.MONTH, 3);
				chooseMonth = "20180403";
			}
			else if(month.equals("five")) 
			{
				cal2.set(Calendar.MONTH, 4);
				chooseMonth = "20180503";
			}
			else if(month.equals("six")) 
			{
				cal2.set(Calendar.MONTH, 5);
				chooseMonth = "20180603";
			}
			else if(month.equals("seven")) 
			{
				cal2.set(Calendar.MONTH, 6);
				chooseMonth = "20180703";
			}
			else if(month.equals("eight")) 
			{
				cal2.set(Calendar.MONTH, 7);
				chooseMonth = "20180803";
			}
			else if(month.equals("nine")) 
			{
				cal2.set(Calendar.MONTH, 8);
				chooseMonth = "20180903";
			}
			else if(month.equals("ten")) 
			{
				cal2.set(Calendar.MONTH, 9);
				chooseMonth = "20181003";
			}
			else if(month.equals("eleven"))
			{
				cal2.set(Calendar.MONTH, 10);
				chooseMonth = "20181103";
			}
			else if(month.equals("twelve"))
			{
				cal2.set(Calendar.MONTH, 11);
				chooseMonth = "20181203";
			}
			
			int day = 0;
			int check = 0;
			cal2.add ( cal2.MONTH, -2 );
			System.out.println(cal2.get(cal2.MONTH));
			int i = cal2.get(cal2.MONTH);
			if(i == 0)i = 12;
			check = 3;
			day = dao.chooseMonth(check, chooseMonth);
			obj.put("three", i);
			obj.put("threeCount", day);
			
			System.out.println("cal.month -3 :"+i);
				
			cal2.add(cal2.MONTH,+1);
			i = cal2.get(cal2.MONTH);
			if(i == 0)i = 12;
			check = 2;
			day = dao.chooseMonth(check, chooseMonth);
			obj.put("two", i);
			obj.put("twoCount", day);
			
			System.out.println("cal.month -2 :"+i);
			
			cal2.add(cal2.MONTH,+1);
			i = cal2.get(cal2.MONTH);
			if(i == 0)i = 12;
			check = 1;
			day = dao.chooseMonth(check, chooseMonth);
			obj.put("one", i);
			obj.put("oneCount", day);
			
			System.out.println("cal.month -1 :"+i);
			
			cal2.add(cal2.MONTH,+1);
			i = cal2.get(cal2.MONTH);
			if(i == 0)i = 12;
			check = 0;
			day = dao.chooseMonth(check, chooseMonth);
			obj.put("now", i);
			obj.put("nowCount", day);
			
			System.out.println("cal.month :"+i);
			
			obj.put("result", "ok");
			System.out.println(obj);
		}
		
		writer.println(obj);
	}
	
	public static String getUuid(){
		String uuid = UUID.randomUUID().toString();
		//System.out.println(uuid);		
		uuid = uuid.replaceAll("-", "");
		//System.out.println("생성된UUID:"+ uuid);
		return uuid;
	}	
	
}

package com.study.spring;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
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
import com.study.spring.dao.IDao_205;
import com.study.spring.kakaopay.KakaoPayRequest;
import com.study.spring.kakaopay.KakaoPayResponse;

/**
 * Handles requests for the application home page.
 */
@Controller
public class KakaoPayController_205 {
	
	private static final Logger logger = LoggerFactory.getLogger(KakaoPayController_205.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@RequestMapping("/pay")
	public String pay0(Model model)
	{
		System.out.println("pay0");
		return "./payment/pay0";
	}
	
	@RequestMapping("/pay1")
	public String pay1(Model model)
	{
		System.out.println("pay1");
		return "./payment/pay1";
	}
	
	@RequestMapping("/pay2")
	public String pay2(Model model)
	{
		System.out.println("pay2");
		return "./payment/pay2";
	}
	
	@RequestMapping("/paysuccess")
	public String paysuccess(Model model)
	{
		System.out.println("paysuccess");
		return "./payment/success";
	}
	@RequestMapping("/paycancel")
	public String payTestcancel(Model model)
	{
		System.out.println("payTestcancel");
		return "./payment/cancel";
	}
	@RequestMapping("/payfail")
	public String payTestfail(Model model)
	{
		System.out.println("payTestfail");
		return "./payment/fail";
	}
	
	@RequestMapping("/payOk")
	public String payTestOk(HttpServletRequest request, Model model) throws Exception 
	{
		System.out.println("payTestOk");
		
		HttpClient httpClient = new DefaultHttpClient();
		String url = "https://kapi.kakao.com/v1/payment/ready";
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept", "application/x-www-form-urlencoded");
		httpPost.setHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		httpPost.setHeader("Authorization", "KakaoAK e7849ae126b8706702b0452443b5e7d9");

		
		String cid = request.getParameter("cid");
		String partner_order_id = request.getParameter("partner_order_id");
		String partner_user_id = request.getParameter("partner_user_id");
		String item_name = request.getParameter("item_name");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int total_amount = Integer.parseInt(request.getParameter("total_amount"));
		int vat_amount = Integer.parseInt(request.getParameter("vat_amount"));
		int tax_free_amount = Integer.parseInt(request.getParameter("tax_free_amount"));
		String approval_url = request.getParameter("approval_url");
		String cancel_url = request.getParameter("cancel_url");
		String fail_url = request.getParameter("fail_url");
		
		System.out.println("cid : " + cid);
		System.out.println("partner_order_id : " + partner_order_id);
		System.out.println("partner_user_id : " + partner_user_id);
		System.out.println("item_name : " + item_name);
		System.out.println("quantity : " + quantity);
		System.out.println("total_amount : " + total_amount);
		System.out.println("vat_amount : " + vat_amount);
		System.out.println("tax_free_amount : " + tax_free_amount);
		System.out.println("approval_url : " + approval_url);
		System.out.println("cancel_url : " + cancel_url);
		System.out.println("fail_url : " + fail_url);
		
		KakaoPayRequest sendObject = new KakaoPayRequest();
		sendObject.setCid(cid);
		sendObject.setPartner_order_id(partner_order_id);
		sendObject.setPartner_user_id(partner_user_id);
		sendObject.setItem_name(item_name);
		sendObject.setQuantity(quantity);
		sendObject.setTotal_amount(total_amount);
		sendObject.setVat_amount(vat_amount);
		sendObject.setTax_free_amount(tax_free_amount);
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
		
		
		return "./payment/pay1";
	}

	
	
}

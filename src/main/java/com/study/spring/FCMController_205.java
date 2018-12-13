package com.study.spring;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.study.spring.dao.IDao_205;
import com.study.spring.dto.kisaDto_205;
import com.study.spring.fcm.AndroidPushNotificationsService;

/**
 * Handles requests for the application home page.
 */
@RestController
public class FCMController_205 {
	
	private static final Logger logger = LoggerFactory.getLogger(FCMController_205.class);
	
	private final String TOPIC = "news";
	
	@Autowired
	AndroidPushNotificationsService androidPushNotificationsService;

	@Autowired
	private SqlSession sqlSession;

	
	@RequestMapping(value = "/sendMessage", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> sendMessage(HttpServletRequest request1)throws JSONException {
		Map<String, Object> retVal = new HashMap<String, Object>();
		
//		try {
//			request1.setCharacterEncoding("UTF-8");
//		} catch (UnsupportedEncodingException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
		
//		System.out.println("token : " + paramInfo.get("token"));
//		System.out.println("message : " + paramInfo.get("message"));
		
		
		String fromMem = request1.getParameter("fromMem");
		String title = request1.getParameter("title");
		String message = request1.getParameter("message");
		
		
		System.out.println("msg.jsp title : " + title);
		System.out.println("msg.jsp message : " + message);
		
//		// FCM 메시지 전송
		JSONObject body = new JSONObject();
		
		// 개별 전송
		//body.put("to", "dp5FkULhWTg:APA91bG5s8t8I2YPuT-XoN6dK5hEu9WtZbsrP4YZO_Nbx4Vdfvewo9l-jpk4uzWI8oUoNr7DKjYigdqPswEgBxvzlqK0_tOZM-lp48biaUf_fbmtNK2W7TX2exZzQAr1PVgHqC6Foo8J");
		// 토픽별 전송
		body.put("to", "/topics/" + TOPIC);
		
		// 우선순위
		body.put("priority", "high");
 
		// 여려명의 수신자에게 전송
		// DB에 저장된 여러개의 토큰(수신자)을 가져와서 설정할 수 있다.
		//List<String> tokenlist = new ArrayList<String>();
		// DB과정 생략(직접 대입)
		
		//tokenlist.add("token value 1");
		//tokenlist.add("dp5FkULhWTg:APA91bG5s8t8I2YPuT-XoN6dK5hEu9WtZbsrP4YZO_Nbx4Vdfvewo9l-jpk4uzWI8oUoNr7DKjYigdqPswEgBxvzlqK0_tOZM-lp48biaUf_fbmtNK2W7TX2exZzQAr1PVgHqC6Foo8J");
		//tokenlist.add("token value 2");
		//tokenlist.add("token value 3");
		
		//JSONArray array = new JSONArray();
		
		//for(int i=0; i<tokenlist.size(); i++) {
		//	array.put(tokenlist.get(i));
		//}
		
		//body.put("registration_ids", array); // 여러개의 메시지일 경우 registration_ids, 단일 메시지는 to사용
		
		try {
			JSONObject notification = new JSONObject();
//			notification.put("title", "New");		// 앱 끄고 있을 때 (background)
//			notification.put("body", "New");
			
//			notification.put("title", URLEncoder.encode(title, "UTF-8"));		// 앱 끄고 있을 때 (background)
//			notification.put("body", URLEncoder.encode(message, "UTF-8"));
			
			JSONObject data = new JSONObject();
			//data.put("Key-1", "JSA Data 1");
			//data.put("Key-2", "JSA Data 2");
			
			if(fromMem.equals("Web")) {
				
					data.put("title", URLEncoder.encode(title, "UTF-8"));// 앱 키고 있을 때 (foreground)
					data.put("message", URLEncoder.encode(message, "UTF-8"));
									
				
			}
			else {
				data.put("title", URLEncoder.encode(title, "UTF-8"));
				data.put("message", URLEncoder.encode(message, "UTF-8"));	
			}
			
			
			body.put("notification", notification);
			body.put("data", data);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(body.toString());
/**
		{
		   "notification": {
		      "title": "JSA Notification",
		      "body": "Happy Message!"
		   },
		   "data": {
		      "Key-1": "JSA Data 1",
		      "Key-2": "JSA Data 2"
		   },
		   "to": "/topics/JavaSampleApproach",
		   "priority": "high"
		}
*/
 
		HttpEntity<String> request = new HttpEntity<>(body.toString());
 
		CompletableFuture<String> pushNotification = androidPushNotificationsService.send(request);
		CompletableFuture.allOf(pushNotification).join();
 
		try {
			String firebaseResponse = pushNotification.get();
			
			return new ResponseEntity<>(firebaseResponse, HttpStatus.OK);
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
 
		return new ResponseEntity<>("Push Notification ERROR!", HttpStatus.BAD_REQUEST);
	}

	@RequestMapping(value = "/alertDelivery", method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json")
	public ResponseEntity<String> alertDelivery(HttpServletRequest request1)throws JSONException {
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		System.out.println("alertDelivery");
		
//		try {
//			request1.setCharacterEncoding("UTF-8");
//		} catch (UnsupportedEncodingException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
		
//		System.out.println("token : " + paramInfo.get("token"));
//		System.out.println("message : " + paramInfo.get("message"));
		
		
		//String tokens = request1.getParameter("tokens");
		
		Double Start_Lat = Double.valueOf(request1.getParameter("Lat"));
		Double Start_Lon = Double.valueOf(request1.getParameter("Lon"));
		
		String title = request1.getParameter("title");
		String message = request1.getParameter("messageBody");
		
		System.out.println("Start_Lat : " + Start_Lat);
		System.out.println("Start_Lon : " + Start_Lon);
		System.out.println("title : " + title);
		System.out.println("message : " + message);
		
//		// FCM 메시지 전송
		JSONObject body = new JSONObject();
		
		// 개별 전송
		//body.put("to", "dp5FkULhWTg:APA91bG5s8t8I2YPuT-XoN6dK5hEu9WtZbsrP4YZO_Nbx4Vdfvewo9l-jpk4uzWI8oUoNr7DKjYigdqPswEgBxvzlqK0_tOZM-lp48biaUf_fbmtNK2W7TX2exZzQAr1PVgHqC6Foo8J");
		// 토픽별 전송
		//body.put("to", "/topics/" + TOPIC);
		
		// 우선순위
		body.put("priority", "high");
 
		// 여려명의 수신자에게 전송
		// DB에 저장된 여러개의 토큰(수신자)을 가져와서 설정할 수 있다.
		List<String> tokenlist = new ArrayList<String>();
		// DB과정 생략(직접 대입)
		
		IDao_205 dao = sqlSession.getMapper(IDao_205.class);
		ArrayList<kisaDto_205> dtos = new ArrayList<kisaDto_205>();
		
		dtos = dao.findNearKisa(Start_Lat, Start_Lon, 1);
		//dtos = dao.findKisa(0);
		
		System.out.println("dtos.size() : " + dtos.size());
		for(int i=0; i<dtos.size(); i++) {
			System.out.println(dtos.get(i).getWk_Name());
			tokenlist.add(dtos.get(i).getWk_Token());
		}
		
		//tokenlist.add("token value 1");
		//tokenlist.add("dp5FkULhWTg:APA91bG5s8t8I2YPuT-XoN6dK5hEu9WtZbsrP4YZO_Nbx4Vdfvewo9l-jpk4uzWI8oUoNr7DKjYigdqPswEgBxvzlqK0_tOZM-lp48biaUf_fbmtNK2W7TX2exZzQAr1PVgHqC6Foo8J");
		//tokenlist.add("token value 2");
		//tokenlist.add("token value 3");
		
		JSONArray array = new JSONArray();
		
		for(int i=0; i<tokenlist.size(); i++) {
			array.put(tokenlist.get(i));
		}
		
		body.put("registration_ids", array); // 여러개의 메시지일 경우 registration_ids, 단일 메시지는 to사용
		
		try {
			JSONObject notification = new JSONObject();
//			notification.put("title", "New");		// 앱 끄고 있을 때 (background)
//			notification.put("body", "New");
			
//			notification.put("title", URLEncoder.encode(title, "UTF-8"));		// 앱 끄고 있을 때 (background)
//			notification.put("body", URLEncoder.encode(message, "UTF-8"));
			
			JSONObject data = new JSONObject();
			//data.put("Key-1", "JSA Data 1");
			//data.put("Key-2", "JSA Data 2");
			
			data.put("title", URLEncoder.encode(title, "UTF-8"));// 앱 키고 있을 때 (foreground)
			data.put("message", URLEncoder.encode(message, "UTF-8"));
			
			
			body.put("notification", notification);
			body.put("data", data);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(body.toString());
/**
		{
		   "notification": {
		      "title": "JSA Notification",
		      "body": "Happy Message!"
		   },
		   "data": {
		      "Key-1": "JSA Data 1",
		      "Key-2": "JSA Data 2"
		   },
		   "to": "/topics/JavaSampleApproach",
		   "priority": "high"
		}
*/
 
		HttpEntity<String> request = new HttpEntity<>(body.toString());
 
		CompletableFuture<String> pushNotification = androidPushNotificationsService.send(request);
		CompletableFuture.allOf(pushNotification).join();
 
		try {
			String firebaseResponse = pushNotification.get();
			
			return new ResponseEntity<>(firebaseResponse, HttpStatus.OK);
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
 
		return new ResponseEntity<>("Push Notification ERROR!", HttpStatus.BAD_REQUEST);
	}
	

	@RequestMapping(value = "/sendMessageAdmin", method = RequestMethod.GET, produces = "application/json")
	public ResponseEntity<String> sendMessageAdmin(HttpServletRequest request1)throws JSONException {
		Map<String, Object> retVal = new HashMap<String, Object>();
		
//		try {
//			request1.setCharacterEncoding("UTF-8");
//		} catch (UnsupportedEncodingException e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
		
//		System.out.println("token : " + paramInfo.get("token"));
//		System.out.println("message : " + paramInfo.get("message"));
		
		
		String tokens = request1.getParameter("tokens");
		//String title = request1.getParameter("title");
		String message = request1.getParameter("messageBody");
		
		
		
//		// FCM 메시지 전송
		JSONObject body = new JSONObject();
		
		// 개별 전송
		body.put("to", tokens);
		// 토픽별 전송
		//body.put("to", "/topics/" + TOPIC);
		
		// 우선순위
		body.put("priority", "high");
 
		
		try {
			JSONObject notification = new JSONObject();
//			notification.put("title", "New");		// 앱 끄고 있을 때 (background)
//			notification.put("body", "New");
			
//			notification.put("title", URLEncoder.encode(title, "UTF-8"));		// 앱 끄고 있을 때 (background)
//			notification.put("body", URLEncoder.encode(message, "UTF-8"));
			
			JSONObject data = new JSONObject();
			//data.put("Key-1", "JSA Data 1");
			//data.put("Key-2", "JSA Data 2");
			
			data.put("title", URLEncoder.encode("배송정보알림", "UTF-8"));// 앱 키고 있을 때 (foreground)
			data.put("message", URLEncoder.encode(message, "UTF-8"));
			
			
			body.put("notification", notification);
			body.put("data", data);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(body.toString());
/**
		{
		   "notification": {
		      "title": "JSA Notification",
		      "body": "Happy Message!"
		   },
		   "data": {
		      "Key-1": "JSA Data 1",
		      "Key-2": "JSA Data 2"
		   },
		   "to": "/topics/JavaSampleApproach",
		   "priority": "high"
		}
*/
 
		HttpEntity<String> request = new HttpEntity<>(body.toString());
 
		CompletableFuture<String> pushNotification = androidPushNotificationsService.send(request);
		CompletableFuture.allOf(pushNotification).join();
 
		try {
			String firebaseResponse = pushNotification.get();
			System.out.println("메시지 전송 성공");
			return new ResponseEntity<>(firebaseResponse, HttpStatus.OK);
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
 
		return new ResponseEntity<>("Push Notification ERROR!", HttpStatus.BAD_REQUEST);
	}
}

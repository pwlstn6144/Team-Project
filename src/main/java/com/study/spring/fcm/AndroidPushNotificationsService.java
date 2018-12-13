package com.study.spring.fcm;


import java.util.ArrayList;
import java.util.concurrent.CompletableFuture;
 
import org.springframework.http.HttpEntity;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class AndroidPushNotificationsService {
	private static final String FIREBASE_SERVER_KEY = "AAAAiWwQo7w:APA91bHX6MfzSlB4ErewZwyf9wVZbvLL76tD7J471_3mWRFtEmgkVxIswDdajLUcAWG9-UZ7ISbcpEmQBuywuvYjqfYT35i9gJ3p172WxYeR0CMNr1h2jCJl0Y_6QCt-SoWd2BE5gort";
	private static final String FIREBASE_API_URL = "https://fcm.googleapis.com/fcm/send";
	
	@Async
	public CompletableFuture<String> send(HttpEntity<String> entity) {
		RestTemplate restTemplate = new RestTemplate();
		
		ArrayList<ClientHttpRequestInterceptor> interceptors = new ArrayList<>();
		
		interceptors.add(new HeaderRequestInterceptor("Authorization", "key=" + FIREBASE_SERVER_KEY));
		interceptors.add(new HeaderRequestInterceptor("Content-Type", "application/json"));
		restTemplate.setInterceptors(interceptors);
		
		String firebaseResponse = restTemplate.postForObject(FIREBASE_API_URL, entity, String.class);
		
		return CompletableFuture.completedFuture(firebaseResponse);
	}
		
}

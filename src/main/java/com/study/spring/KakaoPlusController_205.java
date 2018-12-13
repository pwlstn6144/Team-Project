package com.study.spring;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.study.spring.kakaoplus.KeyboardVO;

import com.study.spring.kakaoplus.MessageButtonVO;
import com.study.spring.kakaoplus.MessageVO;
import com.study.spring.kakaoplus.PhotoVO;
import com.study.spring.kakaoplus.RequestMessageVO;
import com.study.spring.kakaoplus.ResponseMessageVO;

/**
 * Handles requests for the application home page.
 */
@RestController
public class KakaoPlusController_205 {
	
	private static final Logger logger = LoggerFactory.getLogger(KakaoPlusController_205.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value = "/keyboard", method = RequestMethod.GET) // 
	public KeyboardVO keyboard()
	{	
		System.out.println("/keyboard");
		
		MessageVO mes_vo=new MessageVO();
		
		KeyboardVO keyboard=new KeyboardVO(new String[] {"지배인이란?", "어플", "문의", "에코챗"});
		
		if(keyboard.equals("지배인이란?")) {
			PhotoVO photo=new PhotoVO();
			
			photo.setUrl("http://localhost:8081/spring/resources/upload/logo3.png");
			photo.setWidth(640);
			photo.setHeight(480);
			
			mes_vo.setPhoto(photo);
			
			mes_vo.setText("수도권 지하철 택배 업체입니다.");
		}
		
		return keyboard;
	}
	
	@RequestMapping(value = "/message", method = RequestMethod.POST)
	public ResponseMessageVO message(@RequestBody RequestMessageVO vo)
	{
		ResponseMessageVO res_vo=new ResponseMessageVO();
		MessageVO mes_vo=new MessageVO();
		
		if(vo.getContent().equals("쳇봇"))
		{
			//mes_vo.setText("쳇봇 메뉴를 호출합니다.");
			
			KeyboardVO keyboard=new KeyboardVO(new String[] {"지배인이란?", "어플", "문의", "에코챗"});
			
			res_vo.setKeyboard(keyboard);
		}
		
		else if(vo.getContent().equals("지배인이란?"))
		{
			PhotoVO photo=new PhotoVO();
			
			photo.setUrl("http://localhost:8081/spring/resources/upload/logo3.png");
			photo.setWidth(640);
			photo.setHeight(480);
			
			mes_vo.setPhoto(photo);
			mes_vo.setText(vo.getContent());
			
			mes_vo.setText("수도권 지하철 택배 업체입니다.");
			
		}
		
		else if(vo.getContent().equals("어플"))
		{
			MessageButtonVO messageButton=new MessageButtonVO();
			
			messageButton.setLabel("Play store 다운받기");
			messageButton.setUrl("https://www.naver.com");
			
			mes_vo.setMessage_button(messageButton);
			
		}
		
		else if(vo.getContent().equals("문의"))
		{
			PhotoVO photo=new PhotoVO();
			
			
			mes_vo.setText("문의");
		}
		
		else if(vo.getContent().equals("문의문의"))
		{
			PhotoVO photo=new PhotoVO();
			
			photo.setUrl("http://placehold.it/640x480.jpg");
			photo.setWidth(640);
			photo.setHeight(480);
			
			mes_vo.setPhoto(photo);
			mes_vo.setText(vo.getContent());
		}
		else if(vo.getContent().equals("상담"))
		{
			MessageButtonVO messageButton=new MessageButtonVO();
			
			messageButton.setLabel("GITHUB");
			messageButton.setUrl("https://www.naver.com");
			
			mes_vo.setMessage_button(messageButton);
			mes_vo.setText("하하하하ㅏ하!");
		}
		else //에코메시지
		{
			mes_vo.setText(vo.getContent());
		}
		
		res_vo.setMessage(mes_vo);
		return res_vo;
	}
}

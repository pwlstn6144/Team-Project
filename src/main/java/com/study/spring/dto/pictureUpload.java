package com.study.spring.dto;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class pictureUpload {
	
	public Map<String, String> upload(HttpServletRequest request){
		
		//서버의 물리적경로 가져오기
		String path = 
			request.getSession().getServletContext().getRealPath("/resources/upload");
				
		//뷰로 전달할 정보를 저장하기 위한 Map타입의 변수

		Map<String, String> file = new HashMap<>();
		try{
			/*
			 * 파일업로드 위한 MultipartHttpServletRequest객체 생성
			 * 객체 생성과 동시에 파일업로드 완료됨. 나머지 폼값은 Multipart가 
			 * 통째로 받아서 처리한다.
			 */
			MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
					
			//업로드폼의 file속성 필드의 이름을 모두 읽음
			Iterator itr = mhsr.getFileNames();
					
			MultipartFile mfile = null;			
			String fileName = "";		
										
			//폼값받기 : 제목
			String wk_Name = mhsr.getParameter("wk_Name");
			String wk_Id = mhsr.getParameter("wk_Id");
			String wk_Password = mhsr.getParameter("wk_Password");
			String wk_Phone = mhsr.getParameter("wk_Phone");
					
			File directory = new File(path);
			//업로드할 디렉토리가 있는지 확인후
			if(!directory.isDirectory()){
				//디렉토리가 없다면 생성함
				directory.mkdirs();
			}
					
			//업로드폼의 file속성의 필드의 갯수만큼 반복
			while(itr.hasNext()){
						
				//userfile1, userfile2....출력됨
				fileName = (String)itr.next();
				//System.out.println(fileName);	
						
				//서버로 업로드된 임시파일명 가져옴
				mfile = mhsr.getFile(fileName);
				//System.out.println(mfile);//CommonsMultipartFile@1366c0b 형태임
						
				//한글깨짐방지 처리후 업로드된 파일명을 가져온다.
				String originalName = 
					new String(mfile.getOriginalFilename().getBytes(),"UTF-8");
						
				//파일명이 공백이라면 while문의 처음으로 돌아간다.
				if("".equals(originalName)){
					continue;
				}
				//System.out.println("originalName:"+originalName);

				//파일명에서 확장자 가져오기
				String ext = originalName.substring(originalName.lastIndexOf('.'));
						
				//파일명을 UUID로 생성된값으로 변경함.
				String saveFileName = getUuid() + ext;
						
				//설정한 경로에 파일저장
				File serverFullName = new File(path + File.separator + saveFileName);
						
				//업로드한 파일을 지정한 파일에 저장한다.
				mfile.transferTo(serverFullName);
		
				file.put("originalName", originalName);//원본파일명
				file.put("saveFileName", saveFileName);//저장된파일명
//				file.put("serverFullName", serverFullName);//서버에 저장된 전체경로 및 파일명
				file.put("wk_Name", wk_Name);//기사 이름
				file.put("wk_Id", wk_Id);
				file.put("wk_Password", wk_Password);
				file.put("wk_Phone", wk_Phone);
				
			}

		}
		catch(UnsupportedEncodingException e){
			e.printStackTrace();
		}
		catch(IllegalStateException e){
			e.printStackTrace();
		}
		catch(IOException e){
			e.printStackTrace();
		}
		System.out.println("file.wk_Id:"+file.get("wk_Id")+", file.wk_Name:"+file.get("wk_Name"));
		return file;
	}
	
	public static String getUuid(){
		String uuid = UUID.randomUUID().toString();
		//System.out.println(uuid);		
		uuid = uuid.replaceAll("-", "");
		//System.out.println("생성된UUID:"+ uuid);
		return uuid;
	}	
}

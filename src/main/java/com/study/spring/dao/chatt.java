package com.study.spring.dao;

import java.util.ArrayList;

import com.study.spring.dto.chattDto;

public interface chatt {
	
	public int chattCount(); // 방 수
	
	public ArrayList<chattDto> roomList(int nEnd, int nStart); // 방 리스트
	
	public String myDepartmentId(String id); // 내 부서
	
	public String myDepartmentName(String name);
	
	public void insertRoom1(String id);
	
	public void insertRoom2(String id);
	
	public void insertRoom3(String id);

	public void deleteMember(String depart, String id);
	
	public ArrayList<String> roomMember1(String depart);
	
	public ArrayList<String> roomMember2(String depart);

	public ArrayList<String> roomMember3(String depart);
	
	public String myMasterName(String id);
	
	
}

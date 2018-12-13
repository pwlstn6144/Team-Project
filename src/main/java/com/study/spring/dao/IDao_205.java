package com.study.spring.dao;

import java.sql.Date;
import java.util.ArrayList;

import com.study.spring.dto.cstDto_205;
import com.study.spring.dto.kisaDto_205;
import com.study.spring.dto.orderDto2;
import com.study.spring.dto.wkRecodeDto;

public interface IDao_205 {

	public void updateToken(String token, String id);
	public void updateLocation(double Lat, double Lon, String token);
	public void updateMode(String token, int mode);
	public void updateDelivery(String id, String request_number, String orderinvoicenumber);
	public void finishDelivery(String id, String orderinvoicenumber);

	public String confirmId(String userid);
	public kisaDto_205 userCheck(String userid, String userpwd);
	
	public ArrayList<kisaDto_205> findKisa(int mode);
	public ArrayList<orderDto2> findLocation(int mode);
	
	public ArrayList<orderDto2> workerRecode(String id, String searchDate);
	public ArrayList<wkRecodeDto> workerRecode(String id, Date startDate, Date endDate);
	public ArrayList<wkRecodeDto> cstRecode(String id, Date startDate, Date endDate);
	
	public ArrayList<kisaDto_205> findNearKisa(double Lat, double Lon, int distance);
	
	
	public String cstconfirmId(String userid);
	public cstDto_205 cstuserCheck(String userid, String userpwd);

}

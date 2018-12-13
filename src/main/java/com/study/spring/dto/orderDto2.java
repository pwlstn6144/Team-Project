package com.study.spring.dto;

import java.sql.Timestamp;

public class orderDto2 {
	int cst_orderid;
	String cst_Id;
	String cst_Name;
	String cst_Phone;
	String start_Zip;
	String arrive_Name;
	String arrive_Phone;
	String end_Zip;
	Timestamp orderDate;
	int orderkinds;
	int direction;
	int payment_info;
	String bContent;
	int orderPrices;
	String wk_ID;
	String wk_Name;
	String wk_Phone;
	String orderInvoiceNumber;
	int orderMode;
	String orderRequestNumber;
	Timestamp finished_DeliveryTime;
	double start_Lat;
	double start_Lon;
	double arrive_Lat;
	double arrive_Lon;
	
	
	public orderDto2() {
		
	}

	public orderDto2(int cst_orderid, String cst_Id, String cst_Name, String cst_Phone, String start_Zip,
			String arrive_Name, String arrive_Phone, String end_Zip, Timestamp orderDate, int orderkinds, int direction,
			int payment_info, String bContent, int orderPrices, String wk_ID, String wk_Name, String wk_Phone,
			String orderInvoiceNumber, int orderMode) {

		this.cst_orderid = cst_orderid;
		this.cst_Id = cst_Id;
		this.cst_Name = cst_Name;
		this.cst_Phone = cst_Phone;
		this.start_Zip = start_Zip;
		this.arrive_Name = arrive_Name;
		this.arrive_Phone = arrive_Phone;
		this.end_Zip = end_Zip;
		this.orderDate = orderDate;
		this.orderkinds = orderkinds;
		this.direction = direction;
		this.payment_info = payment_info;
		this.bContent = bContent;
		this.orderPrices = orderPrices;
		this.wk_ID = wk_ID;
		this.wk_Name = wk_Name;
		this.wk_Phone = wk_Phone;
		this.orderInvoiceNumber = orderInvoiceNumber;
		this.orderMode = orderMode;
	}
	
	
	
	public orderDto2(int cst_orderid, String cst_Id, String cst_Name, String cst_Phone, String start_Zip,
			String arrive_Name, String arrive_Phone, String end_Zip, Timestamp orderDate, int orderkinds, int direction,
			int payment_info, String bContent, int orderPrices, String wk_ID, String wk_Name, String wk_Phone,
			String orderInvoiceNumber, int orderMode, String orderRequestNumber, Timestamp finished_DeliveryTime,
			double start_Lat, double start_Lon, double arrive_Lat, double arrive_Lon) {

		this.cst_orderid = cst_orderid;
		this.cst_Id = cst_Id;
		this.cst_Name = cst_Name;
		this.cst_Phone = cst_Phone;
		this.start_Zip = start_Zip;
		this.arrive_Name = arrive_Name;
		this.arrive_Phone = arrive_Phone;
		this.end_Zip = end_Zip;
		this.orderDate = orderDate;
		this.orderkinds = orderkinds;
		this.direction = direction;
		this.payment_info = payment_info;
		this.bContent = bContent;
		this.orderPrices = orderPrices;
		this.wk_ID = wk_ID;
		this.wk_Name = wk_Name;
		this.wk_Phone = wk_Phone;
		this.orderInvoiceNumber = orderInvoiceNumber;
		this.orderMode = orderMode;
		this.orderRequestNumber = orderRequestNumber;
		this.finished_DeliveryTime = finished_DeliveryTime;
		this.start_Lat = start_Lat;
		this.start_Lon = start_Lon;
		this.arrive_Lat = arrive_Lat;
		this.arrive_Lon = arrive_Lon;
	}

	public orderDto2(int cst_orderid) {
		this.cst_orderid = cst_orderid;
	}

	public int getCst_orderid() {
		return cst_orderid;
	}

	public void setCst_orderid(int cst_orderid) {
		this.cst_orderid = cst_orderid;
	}

	public String getCst_Id() {
		return cst_Id;
	}

	public void setCst_Id(String cst_Id) {
		this.cst_Id = cst_Id;
	}

	public String getCst_Name() {
		return cst_Name;
	}

	public void setCst_Name(String cst_Name) {
		this.cst_Name = cst_Name;
	}

	public String getCst_Phone() {
		return cst_Phone;
	}

	public void setCst_Phone(String cst_Phone) {
		this.cst_Phone = cst_Phone;
	}

	public String getStart_Zip() {
		return start_Zip;
	}

	public void setStart_Zip(String start_Zip) {
		this.start_Zip = start_Zip;
	}

	public String getArrive_Name() {
		return arrive_Name;
	}

	public void setArrive_Name(String arrive_Name) {
		this.arrive_Name = arrive_Name;
	}

	public String getArrive_Phone() {
		return arrive_Phone;
	}

	public void setArrive_Phone(String arrive_Phone) {
		this.arrive_Phone = arrive_Phone;
	}

	public String getEnd_Zip() {
		return end_Zip;
	}

	public void setEnd_Zip(String end_Zip) {
		this.end_Zip = end_Zip;
	}

	public Timestamp getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderkinds() {
		return orderkinds;
	}

	public void setOrderkinds(int orderkinds) {
		this.orderkinds = orderkinds;
	}

	public int getDirection() {
		return direction;
	}

	public void setDirection(int direction) {
		this.direction = direction;
	}

	public int getPayment_info() {
		return payment_info;
	}

	public void setPayment_info(int payment_info) {
		this.payment_info = payment_info;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public int getOrderPrices() {
		return orderPrices;
	}

	public void setOrderPrices(int orderPrices) {
		this.orderPrices = orderPrices;
	}

	public String getWk_ID() {
		return wk_ID;
	}

	public void setWk_ID(String wk_ID) {
		this.wk_ID = wk_ID;
	}

	public String getWk_Name() {
		return wk_Name;
	}

	public void setWk_Name(String wk_Name) {
		this.wk_Name = wk_Name;
	}

	public String getWk_Phone() {
		return wk_Phone;
	}

	public void setWk_Phone(String wk_Phone) {
		this.wk_Phone = wk_Phone;
	}

	public String getOrderInvoiceNumber() {
		return orderInvoiceNumber;
	}

	public void setOrderInvoiceNumber(String orderInvoiceNumber) {
		this.orderInvoiceNumber = orderInvoiceNumber;
	}

	public int getOrderMode() {
		return orderMode;
	}

	public void setOrderMode(int orderMode) {
		this.orderMode = orderMode;
	}

	public String getOrderRequestNumber() {
		return orderRequestNumber;
	}

	public void setOrderRequestNumber(String orderRequestNumber) {
		this.orderRequestNumber = orderRequestNumber;
	}

	public Timestamp getFinished_DeliveryTime() {
		return finished_DeliveryTime;
	}

	public void setFinished_DeliveryTime(Timestamp finished_DeliveryTime) {
		this.finished_DeliveryTime = finished_DeliveryTime;
	}

	public double getStart_Lat() {
		return start_Lat;
	}

	public void setStart_Lat(double start_Lat) {
		this.start_Lat = start_Lat;
	}

	public double getStart_Lon() {
		return start_Lon;
	}

	public void setStart_Lon(double start_Lon) {
		this.start_Lon = start_Lon;
	}

	public double getArrive_Lat() {
		return arrive_Lat;
	}

	public void setArrive_Lat(double arrive_Lat) {
		this.arrive_Lat = arrive_Lat;
	}

	public double getArrive_Lon() {
		return arrive_Lon;
	}

	public void setArrive_Lon(double arrive_Lon) {
		this.arrive_Lon = arrive_Lon;
	}

	
	
	
	
}

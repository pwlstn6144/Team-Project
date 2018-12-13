package com.study.spring.dto;

import java.sql.Timestamp;

/**
 * @author kosmo03
 *
 */
public class wkRecodeDto {
	
	String finished_DeliveryTime;
	String orderInvoiceNumber;
	int orderkinds;
	int direction;
	int payment_info;
	int orderPrices;

	public wkRecodeDto() {
		
	}

	public wkRecodeDto(String finished_DeliveryTime, String orderInvoiceNumber, int orderkinds, int direction,
			int payment_info, int orderPrices) {
		super();
		this.finished_DeliveryTime = finished_DeliveryTime;
		this.orderInvoiceNumber = orderInvoiceNumber;
		this.orderkinds = orderkinds;
		this.direction = direction;
		this.payment_info = payment_info;
		this.orderPrices = orderPrices;
	}

	public String getFinished_DeliveryTime() {
		return finished_DeliveryTime;
	}

	public void setFinished_DeliveryTime(String finished_DeliveryTime) {
		this.finished_DeliveryTime = finished_DeliveryTime;
	}

	public String getOrderInvoiceNumber() {
		return orderInvoiceNumber;
	}

	public void setOrderInvoiceNumber(String orderInvoiceNumber) {
		this.orderInvoiceNumber = orderInvoiceNumber;
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

	public int getOrderPrices() {
		return orderPrices;
	}

	public void setOrderPrices(int orderPrices) {
		this.orderPrices = orderPrices;
	}


	
	
}

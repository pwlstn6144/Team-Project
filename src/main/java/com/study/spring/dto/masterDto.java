package com.study.spring.dto;

public class masterDto {
	String master_id;
	String master_password;
	String master_depart;
	
	
	public masterDto() {

	}
	public masterDto(String master_id, String master_password, String master_depart) {

		this.master_id = master_id;
		this.master_password = master_password;
		this.master_depart = master_depart;
	}
	public String getMaster_id() {
		return master_id;
	}
	public void setMaster_id(String master_id) {
		this.master_id = master_id;
	}
	public String getMaster_password() {
		return master_password;
	}
	public void setMaster_password(String master_password) {
		this.master_password = master_password;
	}
	public String getMaster_depart() {
		return master_depart;
	}
	public void setMaster_depart(String master_depart) {
		this.master_depart = master_depart;
	}
}

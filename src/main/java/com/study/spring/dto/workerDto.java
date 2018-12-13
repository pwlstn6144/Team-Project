package com.study.spring.dto;

public class workerDto {
	String wk_Id;
	String wk_Token;
	String wk_Name;
	String wk_Password;
	String wk_Phone;
	int wk_Mode;
	int wk_Lat;
	int wk_Lon;
	int wk_Penalty;
	String wk_Picture;
	
	public workerDto() {
		
	}
	
	
	public workerDto(String wk_Id, String wk_Token, String wk_Name, String wk_Password, String wk_Phone, int wk_Mode,
			int wk_Lat, int wk_Lon, int wk_Penalty, String wk_Picture) {

		this.wk_Id = wk_Id;
		this.wk_Token = wk_Token;
		this.wk_Name = wk_Name;
		this.wk_Password = wk_Password;
		this.wk_Phone = wk_Phone;
		this.wk_Mode = wk_Mode;
		this.wk_Lat = wk_Lat;
		this.wk_Lon = wk_Lon;
		this.wk_Penalty = wk_Penalty;
		this.wk_Picture = wk_Picture;
	}


	public String getWk_Id() {
		return wk_Id;
	}

	public void setWk_Id(String wk_Id) {
		this.wk_Id = wk_Id;
	}

	public String getWk_Token() {
		return wk_Token;
	}

	public void setWk_Token(String wk_Token) {
		this.wk_Token = wk_Token;
	}

	public String getWk_Name() {
		return wk_Name;
	}

	public void setWk_Name(String wk_Name) {
		this.wk_Name = wk_Name;
	}

	public String getWk_Password() {
		return wk_Password;
	}

	public void setWk_Password(String wk_Password) {
		this.wk_Password = wk_Password;
	}

	public String getWk_Phone() {
		return wk_Phone;
	}

	public void setWk_Phone(String wk_Phone) {
		this.wk_Phone = wk_Phone;
	}

	public int getWk_Mode() {
		return wk_Mode;
	}

	public void setWk_Mode(int wk_Mode) {
		this.wk_Mode = wk_Mode;
	}

	public int getWk_Lat() {
		return wk_Lat;
	}

	public void setWk_Lat(int wk_Lat) {
		this.wk_Lat = wk_Lat;
	}

	public int getWk_Lon() {
		return wk_Lon;
	}

	public void setWk_Lon(int wk_Lon) {
		this.wk_Lon = wk_Lon;
	}

	public int getWk_Penalty() {
		return wk_Penalty;
	}

	public void setWk_Penalty(int wk_Penalty) {
		this.wk_Penalty = wk_Penalty;
	}


	public String getWk_Picture() {
		return wk_Picture;
	}


	public void setWk_Picture(String wk_Picture) {
		this.wk_Picture = wk_Picture;
	}
	
	

}

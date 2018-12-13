package com.study.spring.dto;

import java.sql.Timestamp;

public class cstDto_205 {
	String cst_Id;
	String cst_Token;
	String cst_Name;
	String cst_Password;
	String cst_Phone;
	String cst_Email;
	int cst_Penalty;


	public cstDto_205() {
		
	}


	public cstDto_205(String cst_Id, String cst_Token, String cst_Name, String cst_Password, String cst_Phone,
			String cst_Email, int cst_Penalty) {
		super();
		this.cst_Id = cst_Id;
		this.cst_Token = cst_Token;
		this.cst_Name = cst_Name;
		this.cst_Password = cst_Password;
		this.cst_Phone = cst_Phone;
		this.cst_Email = cst_Email;
		this.cst_Penalty = cst_Penalty;
	}


	public String getCst_Id() {
		return cst_Id;
	}


	public void setCst_Id(String cst_Id) {
		this.cst_Id = cst_Id;
	}


	public String getCst_Token() {
		return cst_Token;
	}


	public void setCst_Token(String cst_Token) {
		this.cst_Token = cst_Token;
	}


	public String getCst_Name() {
		return cst_Name;
	}


	public void setCst_Name(String cst_Name) {
		this.cst_Name = cst_Name;
	}


	public String getCst_Password() {
		return cst_Password;
	}


	public void setCst_Password(String cst_Password) {
		this.cst_Password = cst_Password;
	}


	public String getCst_Phone() {
		return cst_Phone;
	}


	public void setCst_Phone(String cst_Phone) {
		this.cst_Phone = cst_Phone;
	}


	public String getCst_Email() {
		return cst_Email;
	}


	public void setCst_Email(String cst_Email) {
		this.cst_Email = cst_Email;
	}


	public int getCst_Penalty() {
		return cst_Penalty;
	}


	public void setCst_Penalty(int cst_Penalty) {
		this.cst_Penalty = cst_Penalty;
	}


}

package com.study.spring.dto;

public class chattDto {
	int num;
	String roomList;
	String bj;
	int count;
	String ox;
	
	String waitRoom;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getRoomList() {
		return roomList;
	}

	public void setRoomList(String roomList) {
		this.roomList = roomList;
	}

	public String getBj() {
		return bj;
	}

	public void setBj(String bj) {
		this.bj = bj;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getOx() {
		return ox;
	}

	public void setOx(String ox) {
		this.ox = ox;
	}

	public String getWaitRoom() {
		return waitRoom;
	}

	public void setWaitRoom(String waitRoom) {
		this.waitRoom = waitRoom;
	}

	public chattDto(int num, String roomList, String bj, int count, String ox) {

		this.num = num;
		this.roomList = roomList;
		this.bj = bj;
		this.count = count;
		this.ox = ox;
	}

	public chattDto(String waitRoom) {

		this.waitRoom = waitRoom;
	}

	public chattDto() {

	}
	
	
}

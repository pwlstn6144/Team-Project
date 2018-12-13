package com.study.spring.dao;

import java.util.ArrayList;

import com.study.spring.dto.BDto;
import com.study.spring.dto.cst_zip;
import com.study.spring.dto.orderDto2;
import com.study.spring.dto.workerDto;

public interface IDao {

	public void write(String bName, String bTitle, String bContent, int bCheck);
	
	public ArrayList<BDto> list(int nStart, int nEnd, int bCheck); // 게시물 목록
	
	public int listCount(int bCheck); // 게시물 갯수
	
	public BDto contentView(int strID);
	
	public void modify(int bId, String bName, String bTitle, String bContent);
	
	public void upHit(int bId);
	
	public void delete(int bId);
	
	public BDto replyView(int bId);
	
	public void reply(String bName, String bTitle, String bContent, int bGroup, int bStep,
			int bIndent, int bCheck);
	
	public void replyShape(int strGroup, int strStep);
	
	public int orderPrice(String start_zip, String end_zip); //요금 확정
	
	public void deliveryResult(String cst_ID, String cst_Name, String cst_Phone, String start_zip, String arrive_Name, String arrive_Phone, String end_zip,
			int orderkinds, int direction, int payment_info, String bContent, int orderPrices, String request_number, double start_Lat, double start_Lon, double arrive_Lat, double arrive_Lon); //요청 결과
	
	public void cancel(int cst_orderId);
	
	public ArrayList<orderDto2> RequestNumberSearch(int nStart, int nEnd, String search); // 비회원 주문번호 조회
	
	public ArrayList<orderDto2> RequestNumberSearch2(int nStart, int nEnd, String search, String id); // 회원 주문번호 조회
	
	public ArrayList<orderDto2> RequestNumberSearch3(int nStart, int nEnd, String search, String id); // 기사 회원 송장번호 조회
	
	public ArrayList<orderDto2> RequestNumberSearchDate1(int nStart, int nEnd, String search, String id, String date1); // 기사 회원  주문번호 + 시작 날짜 조회
	
	public ArrayList<orderDto2> RequestNumberSearchDate2(int nStart, int nEnd, String search, String id, String date2); // 기사 회원  송장번호 + 종료 날짜 조회
	
	public ArrayList<orderDto2> RequestNumberSearchDate3(int nStart, int nEnd, String search, String id, String date1, String date2); // 기사 회원  송장번호 + 시작 ! 종료 날짜 조회
	
	public int RequestNumberCount(String RequestNumber); //회원, 비회원 주문번호 갯수 
	
	public int RequestNumberCount2(String RequestNumber, String id); // 기사 주문번호 갯수
	
	public int cstNameCount(String id); //회원 보내는 분 갯수
	
	public int cstNameCount2(String cstName, String id); // 기사 보내는 분 갯수
	
	public int arriveNameCount(String arriveName); //회원 받는 분 갯수
	
	public int arriveNameCount2(String arriveName, String id); // 기사 받는 분 갯수
	
	public ArrayList<orderDto2> cstName(int nStart, int nEnd, String cst_Name, String id); // 회원 보내는 분 조회
	
	public ArrayList<orderDto2> cstName2(int nStart, int nEnd, String cst_Name, String id); // 기사 보내는 분 조회
	
	public ArrayList<orderDto2> cstNameDate1(int nStart, int nEnd, String cst_Name, String id, String date1);// 기사 보내는 분 + 시작 날짜 조회
	
	public ArrayList<orderDto2> cstNameDate2(int nStart, int nEnd, String cst_Name, String id, String date2); // 기사 보내는 분 + 종료 날짜 조회
	
	public ArrayList<orderDto2> cstNameDate3(int nStart, int nEnd, String cst_Name, String id, String date1, String date2); // 기사 보내는 분 + 시작 ~ 종료 날짜 조회
	
	public ArrayList<orderDto2> arriveName(int nStart, int nEnd, String cst_Name, String id); // 회원 받는 분 조회
	
	public ArrayList<orderDto2> arriveName2(int nStart, int nEnd, String cst_Name, String id); // 기사 받는 분 조회
	
	public ArrayList<orderDto2> arriveNameDate1(int nStart, int nEnd, String cst_Name, String id, String date1); // 기사 받는 분 + 시작 날짜 조회
	
	public ArrayList<orderDto2> arriveNameDate2(int nStart, int nEnd, String cst_Name, String id, String date2); // 기사 받는 분 + 종료 날짜 조회
	
	public ArrayList<orderDto2> arriveNameDate3(int nStart, int nEnd, String cst_Name, String id, String date1, String date2); // 기사 받는 분 + 시작 ~ 종료 날짜 조회
	
	public orderDto2 tracking_View(int cst_orderid); // 상세 조회 정보
	
	public workerDto tracking_Picture(String wk_Id); // 상세 조회 정보(기사 사진)
	
	public int memberCount(String id); // 회원 전체 배송 갯수
	
	public int workerCount(String id); //기사 전체 배송 갯수
	
	public ArrayList<orderDto2> memberTrack(int nStart, int nEnd, String id); // 회원 전체 배송 조회
	
	public ArrayList<orderDto2> workTrack(int nStart, int nEnd, String id); // 기사 전체 배송 조회
	
	public int workCount(); // 총 기사의 수
	
	public ArrayList<workerDto> workerList(int nStart, int nEnd); // 기사 리스트
	
	public workerDto workerInfo(String wk_Id); //기사 정보
	
	public int workCount1(String id); //총 배송 횟수
	
	public int workCount2(String id, String date1); //배송 횟수 + 시작 날짜
	
	public int workCount3(String id, String date2); //배송 횟수 + 종료 날짜
	
	public int workCount4(String id, String date1, String date2); // 배송 횟수 + 시작 날짜 + 종료 날짜
	
	public int masterCount(String id); // 관리자용 기사 배송 횟수
	
	public int masterCount2(); // 관리자가 배송조회 전체 횟수 조회
	
	public ArrayList<orderDto2> masterTrack(int nStart, int nEnd, String id); // 관리자용 기사 배송 조회 리스트
	
	public ArrayList<orderDto2> masterTrack2(int nStart, int nEnd); //관리자가 배송조회 진입 후, 리스트 조회
	
	public int masterRequestCount(String requestNum, String id); // 관리자용 주문번호 조회
	
	public int masterRequestCount2(String requestNum); // 관리자가 배송조회 메뉴에서 주문번호 조회
	
	public ArrayList<orderDto2> masterRequestSearch(int nStart, int nEnd, String search, String id); // 관리자 주문번호 검색
	
	public ArrayList<orderDto2> masterRequestSearch2(int nStart, int nEnd, String search); //관리자가 배송조회 메뉴에서 주문번호 조회
	
	public ArrayList<orderDto2> masterRequestSearchDate1(int nStart, int nEnd, String search, String id, String date1); // 관리자 주문번호 + 시작 날짜 조회
	
	public ArrayList<orderDto2> masterRequestSearchDate1_2(int nStart, int nEnd, String search, String date1); // 관리자가 배송조회 메뉴에서 주문번호 + 시작 날짜 조회
	
	public ArrayList<orderDto2> masterRequestSearchDate2(int nStart, int nEnd, String search, String id, String date2); // 관리자 주문번호 + 종료 날짜 조회
	
	public ArrayList<orderDto2> masterRequestSearchDate2_2(int nStart, int nEnd, String search, String date2); // 관리자가 배송조회 메뉴에서 주문번호 + 종료 날짜 조회
	
	public ArrayList<orderDto2> masterRequestSearchDate3(int nStart, int nEnd, String search, String id, String date1, String date2); // 관리자 주문번호 + 시작 ~ 종료 날짜 조회
	
	public ArrayList<orderDto2> masterRequestSearchDate3_2(int nStart, int nEnd, String search, String date1, String date2); // 관리자가 배송조회 메뉴에서 주문번호 + 시작 ~ 종료 날짜 조회
	
	public int masterCstNameCount(String searchText, String wk_Id); // 관리자 보내는 분 숫자
	
	public int masterCstNameCount2(String searchText); // 관리자가 배송조회 메뉴에서 보내는 분 횟수 조회
	
	public ArrayList<orderDto2> masterCstName(int nStart, int nEnd, String search, String wk_Id); // 관리자 보내는 분 검색
	
	public ArrayList<orderDto2> masterCstName2(int nStart, int nEnd, String search); //관리자가 배송조회 메뉴에서 보내는 분 검색
	
	public ArrayList<orderDto2> masterCstNameDate1(int nStart, int nEnd, String search, String wk_Id, String date1); // 관리자 보내는 분 + 시작 날짜 조회
	
	public ArrayList<orderDto2> masterCstNameDate1_2(int nStart, int nEnd, String search, String date1); // 관리자가 배송조회 메뉴에서 보내는 분 + 시작 날짜 조회
	
	public ArrayList<orderDto2> masterCstNameDate2(int nStart, int nEnd, String search, String wk_Id, String date2); // 관리자 보내는 분 + 종료 날짜 조회
	
	public ArrayList<orderDto2> masterCstNameDate2_2(int nStart, int nEnd, String search, String date2); // 관리자가 배송조회 메뉴에서 보내는 분 + 종료 날짜 조회
	
	public ArrayList<orderDto2> masterCstNameDate3(int nStart, int nEnd, String search, String wk_Id, String date1, String date2); // 관리자 배송조회 메뉴에서 보내는 분 + 시작 ! 종료 날짜 조회
	
	public ArrayList<orderDto2> masterCstNameDate3_2(int nStart, int nEnd, String search, String date1, String date2); // 관리자가 배송조회 메뉴에서 보내는 분 + 시작 ! 종료 날짜 조회
	
	public int masterArriveNameCount(String searchText, String wk_Id); // 관리자 받는 분 숫자
	
	public int masterArriveNameCount2(String searchText); // 관리자가 배송조회 메뉴에서 받는 분 숫자 조회
	
	public ArrayList<orderDto2> masterArriveName(int nStart, int nEnd, String search, String wk_Id); // 관리자 받는 분 검색
	
	public ArrayList<orderDto2> masterArriveName2(int nStart, int nEnd, String search); // 관리자가 배송조회 메뉴에서 받는 분 검색
	
	public ArrayList<orderDto2> masterArriveNameDate1(int nStart, int nEnd, String search, String wk_Id, String date1); // 관리자 받는 분 + 시작 날짜 조회
	
	public ArrayList<orderDto2> masterArriveNameDate1_2(int nStart, int nEnd, String search, String date1); // 관리자가 배송조회 메뉴에서 받는 분 + 시작 날짜 조회
	
	public ArrayList<orderDto2> masterArriveNameDate2(int nStart, int nEnd, String search, String wk_Id, String date2); // 관리자 받는 분 + 종료 날짜 조회
	
	public ArrayList<orderDto2> masterArriveNameDate2_2(int nStart, int nEnd, String search, String date2); // 관리자 받는 분 + 종료 날짜 조회
	
	public ArrayList<orderDto2> masterArriveNameDate3(int nStart, int nEnd, String search, String wk_Id, String date1, String date2); // 관리자 받는 분 + 시작 ! 종료 날짜 조회
	
	public ArrayList<orderDto2> masterArriveNameDate3_2(int nStart, int nEnd, String search, String date1, String date2); // 관리자 받는 분 + 시작 ! 종료 날짜 조회
	
	public void addWorker(String wk_Id, String wk_Name, String wk_Password, String wk_Phone, String wk_Picture); // 기사 추가
	
	public void deleteWorker(String wk_Id); // 기사 삭제
	
	public String WorkerCheck(String wk_Id, String wk_Name); // 기사 로그인
	
	public void modifyWorker(String wk_Id, String wk_Name, String wk_Password, String wk_Phone, String wk_Picture); //기사 정보 수정
	
	public int workerNumber(); // 기사 수
	
	public int customerCount(String cst_Id); // 고객이 즐겨찾기에 등록되었는지 여부
	
	public void insertCustomer1(String cst_Id, String cst_zip1, String cst_detail1); // 고객이름으로 해당 순번에 즐겨찾기1 주소 추가
	
	public void insertCustomer2(String cst_Id, String cst_zip2, String cst_detail2); // 고객이름으로 해당 순번에 즐겨찾기2 주소 추가
	
	public void insertCustomer3(String cst_Id, String cst_zip3, String cst_detail3); // 고객이름으로 해당 순번에 즐겨찾기3 주소 추가
	
	public void updateCustomer1(String cst_Id, String cst_zip1, String cst_detail1); // 고객이름으로 해당 순번에 즐겨찾기1 주소 업데이트
	
	public void updateCustomer2(String cst_Id, String cst_zip2, String cst_detail2); // 고객이름으로 해당 순번에 즐겨찾기2 주소 업데이트
	
	public void updateCustomer3(String cst_Id, String cst_zip3, String cst_detail3); // 고객이름으로 해당 순번에 즐겨찾기3 주소 업데이트
	
	public void insertArrive1(String cst_Id, String arrive_zip1, String arrive_detail1); // 고객이름으로 해당 순번에 즐겨찾기1 주소 추가
	
	public void insertArrive2(String cst_Id, String arrive_zip2, String arrive_detail2); // 고객이름으로 해당 순번에 즐겨찾기2 주소 추가
	
	public void insertArrive3(String cst_Id, String arrive_zip3, String arrive_detail3); // 고객이름으로 해당 순번에 즐겨찾기3 주소 추가
	
	public void updateArrive1(String cst_Id, String arrive_zip1, String arrive_detail1); // 고객이름으로 해당 순번에 즐겨찾기1 주소 업데이트
	
	public void updateArrive2(String cst_Id, String arrive_zip2, String arrive_detail2); // 고객이름으로 해당 순번에 즐겨찾기2 주소 업데이트
	
	public void updateArrive3(String cst_Id, String arrive_zip3, String arrive_detail3); // 고객이름으로 해당 순번에 즐겨찾기3 주소 업데이트
	
	public cst_zip selectCustomer1(String cst_Id); //고객 이름으로 해당 순번의 즐겨찾기 주소 찾기 
	
	public cst_zip selectArrive1(String cst_Id); //고객 이름으로 해당 순번의 즐겨찾기 주소 찾기 
	
	public int wk_NameCount(String wk_name); // 관리자 기사 이름 검색 총 수
	
	public ArrayList<workerDto> wk_NameSearch(int nEnd, int nStart, String wk_name); // 관리자 기사 이름 검색 결과

	public int wk_PhoneCount(String wk_phone); // 관리자 기사 전화번호 검색 총 수
	
	public ArrayList<workerDto> wk_PhoneSearch(int nEnd, int nStart, String wk_phone); // 관리자 기사 전화번호 검색
	
	public int wk_IdCount(String wk_Id); // 관리자 기사 아이디 검색 총 수
	
	public ArrayList<workerDto> wk_IdSearch(int nEnd, int nStart, String wk_Id); // 관리자 기사 아이디 검색
	
	public int wt_IdCount(String wt_Id, int bCheck); // Q&A ID 검색 수
	
	public ArrayList<BDto> wt_IdSearch(int nEnd, int nStart, String wk_Id, int bCheck); // Q&A id 검색
	
	public int wt_TitleCount(String wt_Title, int bCheck); // Q&A 제목 검색 수
	
	public ArrayList<BDto> wt_TitleSearch(int nEnd, int nStart, String wk_Title, int bCheck); // Q&A 제목 검색
	
	public ArrayList<BDto> bestNotice(int bCheck); //메인화면 왼쪽 공지사항
	
	public ArrayList<BDto> noticeBest(int bCheck); //메인화면 오른쪽 고객의 소리
	
	public int payTracking(String startZip, String arriveZip); // 요금 조회
	
	public int threeMonth(String wk_Id); // 3개월전 배송완료 수 
	
	public int twoMonth(String wk_Id); // 2개월전 배송완료 수 
	
	public int oneMonth(String wk_Id); // 1개월전 배송완료 수
	
	public int nowMonth(String wk_Id); // 이번 달 배송완료 수 
	
	public int allThreeMonth();// 3개월전 총 배송완료 수
	
	public int allTwoMonth(); // 2개월전 총 배송완료 수
	
	public int allOneMonth(); // 1개월전 총 배송완료 수
	
	public int allNowMonth(); // 이번 달 총 배송완료 수
	
	public int chooseMonth(int check, String date);
}

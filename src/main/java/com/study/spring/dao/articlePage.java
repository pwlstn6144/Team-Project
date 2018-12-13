package com.study.spring.dao;

import com.study.spring.dto.BPageInfo;

public class articlePage {
	
	public BPageInfo aPage(int curpage, int totalCount) {
		
		int listCount = 15;	// 한페이지 당 보여줄 게시물의 갯수
		int pageCount = 10;	// 하단에 보여줄 페이지 리스트의 갯수
		
		// 총 페이지 수
		
				int totalPage = totalCount / listCount;
					
				if(totalCount % listCount > 0)
					totalPage++;
					
				int myCurPage = curpage;
				if(myCurPage > totalPage)
					myCurPage = totalPage;
				if(myCurPage <= 1)
					myCurPage = 1;
					
				//시작 페이지
				int startPage = ((myCurPage - 1) / pageCount) * pageCount + 1;
				
				//끝 페이지
				int endPage = startPage + pageCount - 1;
				if (endPage > totalPage) 
				    endPage = totalPage;
				
				int nStart = (myCurPage - 1) * listCount + 1;
				int nEnd = (myCurPage - 1) * listCount + listCount;

				BPageInfo pinfo = new BPageInfo();
				pinfo.setTotalCount(totalCount);
				pinfo.setListCount(listCount);
				pinfo.setTotalPage(totalPage);
				pinfo.setCurPage(myCurPage);
				pinfo.setPageCount(pageCount);
				pinfo.setStartPage(startPage);
				pinfo.setEndPage(endPage);
				pinfo.setnStart(nStart);
				pinfo.setnEnd(nEnd);
				
				// set
				return pinfo;
	}
}

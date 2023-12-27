package com.bn.model;

import javax.servlet.http.HttpSession;

import lombok.Data;

/*페이징 처리 및 검색 기능을 모듈화하여
 * 재사용할 수 있도록 하자
 * */
@Data
public class PagingVO {
	
	//페이징 처리 관련 프로퍼티
	private int cpage;//현재 보여줄 페이지 번호
	private int pageSize=5;//한 페이지 당 보여줄 목록 개수
	private int totalCount;//총 게시글 수
	private int pageCount;//페이지 수
	
	//DB에서 레코드를 끊어오기 위한 프로퍼티
	private int start;
	private int end;
	
	//페이징 블럭처리 위한 프로퍼티
	private int pagingBlock=5;//한 블럭 당 보여줄 페이지 수
	private int prevBlock;//이전 5개 (이전 블럭)
	private int nextBlock;//이후 5개 (이후 블럭)
	
	//검색 관련 프로퍼티
	private String findType;//검색 유형
	private String findKeyword;//검색어
	
	
	/**페이징 처리 관련 연산을 수행하는 메서드*/
	public void init(HttpSession session) {
		if(findType==null) {
			findType="";
		}
		
		if(findKeyword==null) {
			findKeyword="";
		}
		
		
		pageCount=(totalCount-1)/pageSize+1;
		if(cpage<1) {
			cpage=1;//1페이지를 디폴트로
		}
		if(cpage>pageCount) {
			cpage=pageCount;//마지막 페이지로 설정
		}
		/*
		 * where rn > start and rn < end
		 * cpage	pageSize		start		end
		 * 1			5			 0			6
		 * 2						 5			11
		 * 
		 * */
		start=(cpage-1)*pageSize;
		end = start + (pageSize+1);
		
		//페이징 블럭 연산
		/*cpage
		 * [1][2][3][4][5] | [6][7][8][9][10] | [11][12][13][14][15] | [16][17][18][19][20]
		 * 
		 * cpage		pagingBlock			prevBlock(이전 5개)		nextBlock(이후 5개)
		 * 1~5				5					0						6
		 * 6~10									5						11
		 * 11~15								10						16
		 * ----------------------------------------------------------------------
		 * prevBlock=(cpage-1)/pagingBlock * pagingBlock
		 * nextBlock=prevBlock +(pagingBlock+1);
		 * */
		
		prevBlock=(cpage-1)/pagingBlock * pagingBlock;
		nextBlock=prevBlock +(pagingBlock+1);
	}//init()---------------------------------
	
	/**페이지 네비게이션 문자열을 반환하는 메서드
	 * myctx: 컨텍스트명(/campus)
	 * loc : board/list
	 * */
	public String getPageNavi(String myctx, String loc) {
		String link=myctx+"/"+loc; // /campus/board/list
		String qStr="?findType="+findType+"&findKeyword="+findKeyword;
		link+=qStr;
		
		StringBuilder buf=new StringBuilder();
		buf.append("<ul class='pagination justify-content-center'>");
		
		if(prevBlock>0) {
			buf.append("<li class='page-item'>")
				.append("<a class='page-link' href='"+link+"&cpage="+prevBlock+"'>")
				.append("Prev")
				.append("</a>")
				.append("</li>");
		}
		for(int i=prevBlock+1;i<=nextBlock-1 && i<=pageCount  ;i++) {
			String css=(i==cpage)?"active":"";
			buf.append("<li class='page-item "+css+"'>")
			.append("<a class='page-link' href='"+link+"&cpage="+i+"'>")
			.append(i)
			.append("</a>")
			.append("</li>");
			
		}//for------
		if(nextBlock <= pageCount) {
			buf.append("<li class='page-item'>")
				.append("<a class='page-link' href='"+link+"&cpage="+nextBlock+"'>")
				.append("Next")
				.append("</a>")
				.append("</li>");
		}
		buf.append("</ul>");
		return buf.toString();
	}//----------------------------------------------

}/////////////////////




















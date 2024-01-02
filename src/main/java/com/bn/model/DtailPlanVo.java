package com.bn.model;

import java.util.Date;

import lombok.Data;

@Data
public class DtailPlanVo {

	int dp_id;//시퀀스
	int p_id;//컨트롤러에서 조회에서 긁어오는값(시퀀스)
	String contentid;//div에서추출
	int dp_day;//저장할때 부모 div의 아이디값
	Date dp_start;//session에서긁기
	Date dp_end;//session에서 받아오기
	int dp_num;//부모div의 인덱스
}

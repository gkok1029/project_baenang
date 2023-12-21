package com.bn.model;

import java.util.Date;

import lombok.Data;

@Data
public class DtailPlanVo {

	int dp_id;
	int p_id;
	String contentid;
	int dp_day;
	Date dp_start;
	Date dp_end;
	int dp_num;
}

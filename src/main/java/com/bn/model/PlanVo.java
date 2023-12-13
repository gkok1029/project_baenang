package com.bn.model;

import java.util.Date;
import lombok.Data;

@Data
public class PlanVo {
	
	int p_id;//플랜아이디
	int m_id;//회원아이디
	String p_name;//플랜이름
	String p_birth;//플랜생성일
	Date p_moddate;//플랜수정일
	
	
}

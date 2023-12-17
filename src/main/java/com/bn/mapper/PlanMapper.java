package com.bn.mapper;

import java.util.List;

import com.bn.model.PlanVo;

public interface PlanMapper {
	public int insert(PlanVo vo);//plan저장
	
	public List<PlanVo> selectAll(int m_id);//회원아이디의 모든 플랜 불러오기
	
	public PlanVo selectPlan(int p_id);//plan번호로 플랜불러오기
}

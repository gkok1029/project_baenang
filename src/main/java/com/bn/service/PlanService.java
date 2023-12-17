package com.bn.service;

import java.util.List;

import com.bn.model.PlanVo;

public interface PlanService {
	public int insert(PlanVo vo);
	
	public PlanVo selectPlan(int p_id);
	
	public List<PlanVo> selectAll(int m_id);

}

package com.bn.service;

import java.util.List;

import com.bn.model.CityVo;
import com.bn.model.DtailPlanVo;
import com.bn.model.PlanVo;

public interface PlanService {
	public int insert(PlanVo vo);
	
	public int seq();
	
	public PlanVo selectPlan(int p_id);
	
	public List<PlanVo> selectAll(int m_id);
	
	public int insertDp(DtailPlanVo vo);
	
	public CityVo cityloc(String CITYNAME);
	
	public int delplan(int p_id);
	
	public String[]Csearch(String keyword);
	
	public List<DtailPlanVo> dpretrieve(String p_id);
	
	public List<DtailPlanVo> getdplan(DtailPlanVo vo);
}

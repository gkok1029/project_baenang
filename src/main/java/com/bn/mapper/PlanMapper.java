package com.bn.mapper;

import java.util.List;

import com.bn.model.CityVo;
import com.bn.model.DtailPlanVo;
import com.bn.model.PlanVo;

public interface PlanMapper {
	public int insert(PlanVo vo);//plan占쏙옙占쏙옙
	
	public List<PlanVo> selectAll(int m_id);//회占쏙옙占쏙옙占싱듸옙占쏙옙 占쏙옙占� 占시뤄옙 占쌀뤄옙占쏙옙占쏙옙
	
	public PlanVo selectPlan(int p_id);//plan占쏙옙호占쏙옙 占시뤄옙占쌀뤄옙占쏙옙占쏙옙
	
	public int insertDp(DtailPlanVo vo);
	
	public CityVo cityloc(String CITYNAME);
}

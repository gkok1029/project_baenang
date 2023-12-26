package com.bn.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bn.mapper.PlanMapper;
import com.bn.model.ContentVo;
import com.bn.model.DtailPlanVo;
import com.bn.model.PlanVo;

@Service("PlanService")
public class PlanServiceImpl implements PlanService {

	@Inject
	private PlanMapper planmapper; 
	
	@Override
	public int insert(PlanVo vo) {

		return this.planmapper.insert(vo);
	}

	@Override
	public List<PlanVo> selectAll(int m_id) {
		
		return this.planmapper.selectAll(m_id);
	}

	@Override
	public PlanVo selectPlan(int p_id) {

		return this.planmapper.selectPlan(p_id);
	}

	@Override
	public int insertDp(DtailPlanVo vo) {
		// TODO Auto-generated method stub
		return this.planmapper.insertDp(vo);
	}

	@Override
	public CityVo cityloc(String CITYNAME) {
		
		return this.planmapper.cityloc(CITYNAME);
	}

}

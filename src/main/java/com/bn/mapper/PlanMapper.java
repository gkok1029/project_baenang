package com.bn.mapper;

import java.util.List;

import com.bn.model.PlanVo;

public interface PlanMapper {
	public int insert(PlanVo vo);//plan����
	
	public List<PlanVo> selectAll(int m_id);//ȸ�����̵��� ��� �÷� �ҷ�����
	
	public PlanVo selectPlan(int p_id);//plan��ȣ�� �÷��ҷ�����
}


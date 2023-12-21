package com.bn.service;

import java.util.List;

import com.bn.model.MemberVo;
import com.bn.model.MypageVo;

public interface MypageService {
	
	public MemberVo getProfile(String M_NNAME);

	public List<MypageVo> getPlanList(long m_ID);
	
}

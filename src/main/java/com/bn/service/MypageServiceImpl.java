package com.bn.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bn.mapper.MypageMapper;
import com.bn.model.MemberVo;
import com.bn.model.MypageVo;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Inject
	private MypageMapper mypageMapper;
	public MemberVo getProfile(String M_NNAME) {
		return mypageMapper.getProfile(M_NNAME);
	}
	@Override
	public List<MypageVo> getPlanList(long m_ID) {
		// TODO Auto-generated method stub
		return mypageMapper.getPlanList(m_ID);
	}
	
	
}

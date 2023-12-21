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
	public MemberVo getProfile(String m_nname) {
		return mypageMapper.getProfile(m_nname);
	}
	@Override
	public List<MypageVo> getPlanList(MypageVo my) {
		// TODO Auto-generated method stub
		return mypageMapper.getPlanList(my);
	}
	
	
}

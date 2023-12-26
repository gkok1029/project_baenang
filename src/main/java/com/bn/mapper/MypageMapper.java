package com.bn.mapper;

import java.util.List;

import com.bn.model.MemberVo;
import com.bn.model.MypageVo;

public interface MypageMapper {
	
	public MemberVo getProfile(String m_nname);

	public List<MypageVo> getPlanList(MypageVo my);

	public int updatePwd(MemberVo user);

	public int updateNickname(MemberVo user);
	
}

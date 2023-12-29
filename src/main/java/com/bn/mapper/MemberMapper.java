package com.bn.mapper;

import java.util.List;
import java.util.Map;

import com.bn.model.MemberVo;
import com.bn.model.PageVo;

public interface MemberMapper {
	/*마이페이지 기능*/
	public MemberVo getProfile(String m_nname) throws Exception;
	public List<PageVo> getPlanList(PageVo myVo) throws Exception;
	public int updatePwd(MemberVo userVo) throws Exception;
	public int updateNickname(MemberVo userVo) throws Exception;
	public int memberOut(MemberVo userVo) throws Exception;
	public int updateProfileImage(PageVo myVo) throws Exception;
	public int deletePlan(PageVo myVo) throws Exception;

	/*로그인 기능*/
	public String loginCheck2(MemberVo member) throws Exception;
	public void tempPass(Map<String, String> parameters) throws Exception;
	public int statusCheck(String userEmail) throws Exception;
}

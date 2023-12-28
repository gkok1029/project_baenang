package com.bn.service;

import java.util.List;

import com.bn.model.MemberVo;
import com.bn.model.PageVo;

public interface MemberService {
	/*마이페이지기능*/
	public MemberVo getProfile(String m_nname);
	public List<PageVo> getPlanList(PageVo myVo);
	public int updatePwd(MemberVo userVo);
	public int passwordCheck(MemberVo userVo);
	public int updateNickname(MemberVo userVo);
	public int memberOut(MemberVo userVo);
	public int updateProfileImage(PageVo myVo);
	public int deletePlan(PageVo myVo);
	public int deleteDPlan(PageVo myVo);
	
	/*로그인페이지기능*/
	public String loginCheck2(MemberVo member);
	public void tempPass(String userEmail, String temppass);
	public int statusCheck(String userEmail);
}

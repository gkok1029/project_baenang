package com.bn.service;

import javax.servlet.http.HttpSession;

import com.bn.model.MemberVo;

public interface LoginService {
	public int loginCheck(MemberVo member);
	
	public String loginCheck2(MemberVo member, HttpSession session);
	
}

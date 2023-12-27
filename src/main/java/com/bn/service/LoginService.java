package com.bn.service;

import javax.servlet.http.HttpSession;

import com.bn.model.MemberVo;

public interface LoginService {
	
	public String loginCheck2(MemberVo member);
	
	public void tempPass(String userEmail, String temppass);
	
}

package com.bn.service;

import com.bn.model.MemberVo;

public interface SignupService {

	public void signup(MemberVo member); 
	boolean validateSignup(MemberVo member);
}

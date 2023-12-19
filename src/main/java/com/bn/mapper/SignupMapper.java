package com.bn.mapper;

import com.bn.model.MemberVo;

public interface SignupMapper {
	public void signup(MemberVo member) throws Exception; //회원가입
	public int checkEmail(String userEmail) throws Exception; 
	public String returnPass(String userEmail) throws Exception; //pass word 반환 
}
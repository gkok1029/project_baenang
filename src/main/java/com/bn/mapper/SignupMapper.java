package com.bn.mapper;

import com.bn.model.MemberVo;

public interface SignupMapper {
	public void signup(MemberVo member) throws Exception; //회원가입
}
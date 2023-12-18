package com.bn.mapper;

import com.bn.model.MemberVo;

public interface LoginMapper {

	public int loginCheck(MemberVo member) throws Exception;
	public String loginCheck2(MemberVo member) throws Exception;
}

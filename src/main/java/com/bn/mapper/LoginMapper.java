package com.bn.mapper;

import java.util.Map;

import com.bn.model.MemberVo;

public interface LoginMapper {

	public String loginCheck2(MemberVo member) throws Exception;
	public void tempPass(Map<String, String> parameters) throws Exception;
	public int statusCheck(String userEmail) throws Exception;
}

package com.bn.mapper;

import com.bn.model.MemberVo;

public interface MemberMapper {
	public void joinS(MemberVo member) throws Exception; //회원가입
	public MemberVo loginS(String m_email); //로그인
	public String findId(MemberVo member); //아이디 찾기
	public void findPwd(MemberVo member); //비밀번호찾기
	public int checkLogin(MemberVo member) throws Exception;
}
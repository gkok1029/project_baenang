package com.bn.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.LoginMapper;
import com.bn.model.MemberVo;

@Service
public class LoginServiceImp implements LoginService{

	@Autowired
	private LoginMapper loginMapper;
		
	@Override
	public int loginCheck(MemberVo member) {
		int n=0;
		
		try {
		n = loginMapper.loginCheck(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return n;
	}

	@Override
	public String loginCheck2(MemberVo member, HttpSession session) {
		try {
			String name = loginMapper.loginCheck2(member);
			if(name != null) {
				session.setAttribute("userEmail", member.getM_EMAIL());
				session.setAttribute("name", name);
			}
			return name;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	
}

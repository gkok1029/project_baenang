package com.bn.service;

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

}

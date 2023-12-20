package com.bn.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.LoginMapper;
import com.bn.model.MemberVo;

@Service
public class LoginServiceImp implements LoginService{

	@Autowired
	private PasswordEncoder passwordEncoder;
	
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
			 String encryptedPassword = passwordEncoder.encrypt(member.getM_EMAIL(),member.getM_PWD()); // 비밀번호를 해싱합니다.
	         member.setM_PWD(encryptedPassword); // 해싱된 비밀번호로 설정합니다.
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

	@Override
	public void tempPass(String userEmail, String temppass) {
		try {
			Map<String, String> parameters = new HashMap<>();
			parameters.put("userEmail", userEmail);
			parameters.put("temppass", temppass);
			loginMapper.tempPass(parameters);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	
}

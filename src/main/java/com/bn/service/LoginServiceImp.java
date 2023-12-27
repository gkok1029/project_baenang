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
	public String loginCheck2(MemberVo member) {
		try {
			 String encryptedPassword = passwordEncoder.encrypt(member.getM_EMAIL(),member.getM_PWD()); // ��й�ȣ�� �ؽ��մϴ�.
	         member.setM_PWD(encryptedPassword); // �ؽ̵� ��й�ȣ�� �����մϴ�.
			 String name = loginMapper.loginCheck2(member);
			if(name != null) {
				return name;
			}
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

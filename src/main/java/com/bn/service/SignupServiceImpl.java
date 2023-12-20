package com.bn.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.SignupMapper;
import com.bn.model.MemberVo;

@Service
public class SignupServiceImpl implements SignupService{

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private SignupMapper signupMapper;
	
	@Override
    public void signup(MemberVo member) {
        try {
            String encryptedPassword = passwordEncoder.encrypt(member.getM_EMAIL(),member.getM_PWD()); // 비밀번호를 해싱합니다.
            member.setM_PWD(encryptedPassword); // 해싱된 비밀번호로 설정합니다.
            signupMapper.signup(member);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	@Override
	public boolean validateSignup(MemberVo member) {
		// 이메일, 닉네임, 비밀번호 유효성 검사
        if (member.getM_EMAIL() == null || member.getM_EMAIL().isEmpty()) {
            return false; // 이메일이 비어 있으면 유효성 검사 실패
        }

        if (member.getM_NNAME() == null || member.getM_NNAME().isEmpty()) {
            return false; // 닉네임이 비어 있으면 유효성 검사 실패
        }

        if (member.getM_PWD() == null || member.getM_PWD().isEmpty()) {
            return false; // 비밀번호가 비어 있으면 유효성 검사 실패
        }

        if (member.getM_BIRTH() == null) {
            return false; // 생년월일이 널값이라면 유효성 검사 실패
        }
        
        if (member.getM_GEN() == null || member.getM_GEN().isEmpty()) {
            return false; // 생년월일 비어 있으면 유효성 검사 실패
        }
		return true;
	}

	
}

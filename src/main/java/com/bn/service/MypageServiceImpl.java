package com.bn.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.LoginMapper;
import com.bn.mapper.MypageMapper;
import com.bn.model.MemberVo;
import com.bn.model.MypageVo;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Inject
	private LoginMapper loginMapper;
	
	@Inject
	private MypageMapper mypageMapper;
	public MemberVo getProfile(String m_nname) {
		
		
		
		return mypageMapper.getProfile(m_nname);
	}
	@Override
	public List<MypageVo> getPlanList(MypageVo my) {
		// TODO Auto-generated method stub
		return mypageMapper.getPlanList(my);
	}
	@Override
	public int updatePwd(MemberVo user) {
		String encryptedPassword = passwordEncoder.encrypt(user.getM_EMAIL(),user.getM_PWD()); // 비밀번호를 해싱합니다.
        user.setM_PWD(encryptedPassword);
		return mypageMapper.updatePwd(user);
	}
	@Override
	public int passwordCheck(MemberVo user) {
		
		String encryptedPassword = passwordEncoder.encrypt(user.getM_EMAIL(),user.getM_PWD()); // 비밀번호를 해싱합니다.
        user.setM_PWD(encryptedPassword);
        try {
        	String name = loginMapper.loginCheck2(user);
        	if(name!= null) {
        		return 1;
        	}else {
        		return -1;
        	}
        }catch(Exception e){
        	e.printStackTrace();
        	return -1;
        }
        
	}
	@Override
	public int updateNickname(MemberVo user) {
		// TODO Auto-generated method stub
		return mypageMapper.updateNickname(user);
	}
	@Override
	public int memberOut(MemberVo user) {
		// TODO Auto-generated method stub
		return mypageMapper.memberOut(user);
	}
	@Override
	public int updateProfileImage(MypageVo my) {
		// TODO Auto-generated method stub
		return mypageMapper.updateProfileImage(my);
	}
	@Override
	public int deletePlan(MypageVo my) {
		// TODO Auto-generated method stub
		return mypageMapper.deletePlan(my);
	}
	@Override
	public int deleteDPlan(MypageVo my) {
		// TODO Auto-generated method stub
		return mypageMapper.deleteDPlan(my);
	}
	
	
}

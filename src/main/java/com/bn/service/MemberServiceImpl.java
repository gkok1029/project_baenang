package com.bn.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.MemberMapper;
import com.bn.model.MemberVo;
import com.bn.model.PageVo;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private MemberMapper memberMapper;
	
	
	 @Override
		public MemberVo getProfile(String m_nname) {
			MemberVo member = null;
			try {
				member = memberMapper.getProfile(m_nname);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return member;
		}
		
		@Override
		public List<PageVo> getPlanList(PageVo myVo) {
		    List<PageVo> planList = null;
		    try {
		        planList = memberMapper.getPlanList(myVo);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return planList;
		}
		
		@Override
		public int updatePwd(MemberVo userVo) {
		    int updatedRows = 0;
		    try {
		        String encryptedPassword = passwordEncoder.encrypt(userVo.getM_EMAIL(),userVo.getM_PWD());
		        userVo.setM_PWD(encryptedPassword);
		        updatedRows = memberMapper.updatePwd(userVo);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return updatedRows;
		}
		
		@Override
		public int passwordCheck(MemberVo userVo) {
			String encryptedPassword = passwordEncoder.encrypt(userVo.getM_EMAIL(),userVo.getM_PWD()); // ��й�ȣ�� �ؽ��մϴ�.
	        userVo.setM_PWD(encryptedPassword);
	        try {
	        	String name = memberMapper.loginCheck2(userVo);
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
		public int updateNickname(MemberVo userVo) {
		    int updatedRows = 0;
		    try {
		        updatedRows = memberMapper.updateNickname(userVo);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return updatedRows;
		}
		
		@Override
		public int memberOut(MemberVo userVo) {
		    int deletedRows = 0;
		    try {
		        deletedRows = memberMapper.memberOut(userVo);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return deletedRows;
		}
		
		@Override
		public int updateProfileImage(PageVo myVo) {
		    int updatedRows = 0;
		    try {
		        updatedRows = memberMapper.updateProfileImage(myVo);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return updatedRows;
		}
		
		@Override
		public int deletePlan(PageVo myVo) {
		    int deletedRows = 0;
		    try {
		        deletedRows = memberMapper.deletePlan(myVo);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return deletedRows;
		}
		
		@Override
		public int deleteDPlan(PageVo myVo) {
		    int deletedRows = 0;
		    try {
		        deletedRows = memberMapper.deleteDPlan(myVo);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return deletedRows;
		}

		@Override
		public String loginCheck2(MemberVo member) {
			try {
				 String encryptedPassword = passwordEncoder.encrypt(member.getM_EMAIL(),member.getM_PWD()); // ��й�ȣ�� �ؽ��մϴ�.
		         member.setM_PWD(encryptedPassword); // �ؽ̵� ��й�ȣ�� �����մϴ�.
				 String name = memberMapper.loginCheck2(member);
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
				memberMapper.tempPass(parameters);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		@Override
		public int statusCheck(String userEmail) {
			int n = 0;
			try {
				n = memberMapper.statusCheck(userEmail);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return n;
		}
}

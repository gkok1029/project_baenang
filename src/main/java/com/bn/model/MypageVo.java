package com.bn.model;

import java.util.Date;
import lombok.Data;

@Data
public class MypageVo {
	
	private int p_id;//플랜id
	private String p_name;//플랜이름
	private String p_birth;//플랜생성일
	private Date p_moddate;//플랜수정일
	
	private Date dp_start;//여행시작일
	private Date dp_end;//여행종료일
	
	private long m_id;//회원id
	private String m_email; //이메일
	private String m_pwd; //비밀번호
	private String m_gen; //성별
	private String m_nname; //닉네임
	private Date m_birth; //생년월일
	private Date m_rdate;//가입일
	private String m_image; //프로필이미지 경로
	private int m_status; //회원상태
	private int m_profil; //사용자 프로필
	
	private long i_id;//초대id
	private int i_per;//권한
	private int i_status;//초대상태
}

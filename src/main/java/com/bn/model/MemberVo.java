package com.bn.model;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberVo {

	private long M_id;//회원 ID
	private String M_email; //이메일
	private String M_PWD; //비밀번호
	private String M_GEN; //성별
	private String M_NNAME; //닉네임
	private Date M_BIRTH; //생년월일
	private Date M_RDATE;//가입일
	private String M_IMAGE; //프로필이미지 경로
	private int M_STATUS; //회원상태
	private int M_PROFIL; //사용자 프로필
	
	
}

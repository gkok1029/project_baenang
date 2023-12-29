package com.bn.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PostVo {
	//이하 포스트
	private int p_id;
	private int m_id;
	private String p_title;
	private String p_content;
	private int p_view;
	private Date p_credate;
	private Date p_moddate;
	//이하 멤버
	private String m_nname;
	private String m_image;
	private String m_profil;
}

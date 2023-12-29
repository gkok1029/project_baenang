package com.bn.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PostVo {
	//이하 포스트
	private int p_id;
	private String p_title;
	private String p_content;
	private int p_view;
	private Date p_credate;
	private Date p_moddate;
	//이하 멤버
	private int m_id;
	private String m_nname;
	private String m_image;
	//이하 좋아요
	private int l_id;
	private Date l_date;
	//이하 리플리
	private int r_id;
	private String r_content;
	private Date r_credate;
	private Date r_moddate;
	private int r_status;
	
}

package com.bn.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PostVo {
	
	private int p_id;
	private int m_id;
	private String p_title;
	public String p_content;
	public int p_view;
	public Date p_credate;
	public Date p_moddate;
}

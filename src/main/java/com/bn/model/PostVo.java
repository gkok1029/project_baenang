package com.bn.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PostVo {
	
	private int p_id;
	private int m_id;
	private String p_title;
	private String p_content;
	private int p_view;
	private Date p_credate;
	private Date p_moddate;
}

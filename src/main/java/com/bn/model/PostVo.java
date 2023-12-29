package com.bn.model;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PostVo {
	//이하 포스트
	private int p_id;
	private String p_title;
	private String p_content;
	private int p_view;
	private Date p_credate;
	private Date p_moddate;
	private int m_id;
	
}
package com.bn.model;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyVo {
	//이하 댓글
	private int r_id;
	private int m_id;
	private int p_id;
	private String r_content;
	private Date r_credate;
	private Date r_moddate;
	private int r_status;
}

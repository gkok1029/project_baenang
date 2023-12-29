package com.bn.model;

import java.sql.Date;

import lombok.Data;

@Data
public class ReplyVo {
	private int r_id;
	private int p_id;
	private String r_content;
	private Date r_credate;
	private Date r_moddate;
	private int r_status; //리플의 상태(공개/비공개)
	//이하 멤버
	private int m_id;
	private String m_nname;
	private String m_image;
}

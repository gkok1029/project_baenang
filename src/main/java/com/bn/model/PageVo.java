package com.bn.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PageVo {
	private int p_id;
	private String p_name;
	private String p_birth;
	private Date p_moddate;
	private Date dp_start;
	private Date dp_end;
	private long m_id;
	private String m_email;
	private String m_pwd;
	private String m_gen;
	private String m_nname;
	private Date m_birth;
	private Date m_rdate;
	private String m_image;
	private int m_status;
	private int m_profil;
	private String filter;
	private long i_id;
	private int i_per;
	private int i_status;
	private String filename;
	private String originFilename;
	private long filesize;
	private String firstimage;
}

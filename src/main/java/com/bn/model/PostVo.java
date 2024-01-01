package com.bn.model;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PostVo {
	//이하 포스트
	private int p_id;
	private String p_title;
	private String p_content;
	private int p_view;
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date p_credate;
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
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
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date r_credate;
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date r_moddate;
	private int r_status;
	//이하 이미지
	private int i_id;
	private String i_path;
	private String i_name;
	private String i_name2;
	private Date i_birth;
	//이하 img_dir
	private int dir_id;
	private int dir_num;
	
}
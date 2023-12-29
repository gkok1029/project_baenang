package com.bn.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class ContentVo implements Serializable{
	
	public ContentVo() {
		
	}
	
	public ContentVo(String contentid, String contenttypeid, String code, String title, String tel, String addr,
			String firstimage, String mapx, String mapy, String overview) {
	}
	String contentid;
	String contenttypeid;
	String code;
	String title;
	String tel;
	String addr;
	String firstimage;
	String mapx;
	String mapy;
	String overview;
	int count;

}
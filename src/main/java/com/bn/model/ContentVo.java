package com.bn.model;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
public class ContentVo {
	
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

}
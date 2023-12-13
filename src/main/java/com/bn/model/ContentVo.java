package com.bn.model;

import lombok.Data;

@Data
public class ContentVo {
	public ContentVo(String contentid2, String contenttypeid2, String code2, String title2, String tel2, String addr2,
			String firstimage2, String mapx2, String mapy2) {
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
}

package com.bn.model;

import lombok.Data;

@Data
public class CityVo {
	
	private String cityid;
	private String cityname;
	private String longitude;
	private String latitude;
	private String c_overview;
	private String c_image;

	public CityVo() {
		
	}
	
	public CityVo(String cityid, String cityname, String longitude, String latitude, String c_overview, String c_image) {
		
	}
	
}


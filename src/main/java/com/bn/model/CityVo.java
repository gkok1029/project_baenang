package com.bn.model;

import lombok.Data;

@Data
public class CityVo {

	public CityVo() {
		
	}
	
	public CityVo(String CITYID, String CITYNAME, String LONGITUDE, String LATITUDE) {
		
	}
	
	private String CITYID;
	private String CITYNAME;
	private String LONGITUDE;
	private String LATITUDE;
	
}


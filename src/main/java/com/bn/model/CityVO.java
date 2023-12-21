package com.bn.model;

import lombok.Data;

@Data
public class CityVO {
	
	private String cityId;
	private String cityImage;
	private String cityIntro;
	private String locX;
	private String locY;
	
	public CityVO() {
		
	}

	public CityVO(String cityId, String cityImage, String cityIntro, String locX, String locY) {
		this.cityId = cityId;
		this.cityImage = cityImage;
		this.cityIntro = cityIntro;
		this.locX = locX;
		this.locY = locY;
	}
	
	public CityVO(String cityId) {
		this.cityId = cityId;
	}
	
}

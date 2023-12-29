package com.bn.service;

import com.bn.model.CityVo;
import com.bn.model.ContentVo;

public interface InfoService {
	
	public ContentVo getTourData(String contentid);
	
	public int insertOverview(ContentVo vo);
	
	public String existOverview(String title);
	
	public CityVo getCityData(String cityname);
	
}

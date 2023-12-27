package com.bn.service;

import java.util.List;

import com.bn.model.ContentVo;

public interface TourInfoService {
	
	public List<ContentVo> getCityData(String title);
	
	public int insertOverview(ContentVo vo);
	
	public List<ContentVo> existOverview(String title);
	
}

package com.bn.mapper;

import java.util.List;

import com.bn.model.ContentVo;

public interface TourInfoMapper {
	
	public ContentVo getCityData(String contentid);
	
	public int insertOverview(ContentVo vo);
	
	public String existOverview(String title);
	
}

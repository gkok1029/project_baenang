package com.bn.mapper;

import com.bn.model.ContentVo;

public interface InfoMapper {
	
	public ContentVo getCityData(String contentid);
	
	public int insertOverview(ContentVo vo);
	
	public String existOverview(String title);
	
}

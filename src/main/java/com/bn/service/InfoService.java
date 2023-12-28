package com.bn.service;

import java.util.List;

import com.bn.model.ContentVo;

public interface InfoService {
	
	public ContentVo getCityData(String contentid);
	
	public int insertOverview(ContentVo vo);
	
	public String existOverview(String title);
	
}

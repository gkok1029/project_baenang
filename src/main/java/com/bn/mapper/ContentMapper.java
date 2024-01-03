package com.bn.mapper;

import java.util.List;
import java.util.Map;

import com.bn.model.ContentVo;

public interface ContentMapper {

	public int insertdb(ContentVo vo);
	
	 List<ContentVo> searchInRange(Map<String, Object> cd);
	 
	 public void countup(String contentid);
	 
	 public ContentVo contentload(String contentid);
}


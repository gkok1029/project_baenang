package com.bn.service;

import java.util.List;
import java.util.Map;

import com.bn.model.ContentVo;


public interface DbService {
	
	public int insertdb(ContentVo vo);
	
		
	public List<ContentVo>searchInRange(Map<String, Object> cd);

}

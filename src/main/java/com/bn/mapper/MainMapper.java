package com.bn.mapper;

import java.util.List;

import com.bn.model.ContentVo;

public interface MainMapper {
	
	public String rec(String contentid);

	public List<ContentVo> search(String title);
}

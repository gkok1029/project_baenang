package com.bn.mapper;

import java.util.List;

import com.bn.model.CityVo;
import com.bn.model.ContentVo;

public interface MainMapper {
	
	public String rec(String contentid);

	public List<CityVo> search(String title);
}

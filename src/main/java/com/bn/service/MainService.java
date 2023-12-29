package com.bn.service;

import java.util.List;

import com.bn.model.CityVo;

public interface MainService {
	
	public String rec(String contentid);

	public List<CityVo> search(String title);
}

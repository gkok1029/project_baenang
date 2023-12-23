package com.bn.service;

import java.util.List;

import com.bn.model.ContentVo;

public interface MainService {
	
	public String rec(String contentid);

	public List<ContentVo> search(String title);
}

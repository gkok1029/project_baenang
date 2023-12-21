package com.bn.mapper;

import java.util.List;

public interface MainMapper {
	
	public String rec(String contentid);

	public List<String> search(String title);
}

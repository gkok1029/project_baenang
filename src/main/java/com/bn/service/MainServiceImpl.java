package com.bn.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bn.mapper.MainMapper;

@Service("MainService")
public class MainServiceImpl implements MainService {

	@Inject
	private MainMapper mainMapper;
	
	@Override
	public String rec(String contentid) {
		return this.mainMapper.rec(contentid);
	}

}

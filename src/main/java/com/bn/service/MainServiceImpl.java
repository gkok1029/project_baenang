package com.bn.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bn.mapper.MainMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service("MainService")
public class MainServiceImpl implements MainService {

	@Inject
	private MainMapper mainMapper;
	
	@Override
	public String rec(String contentid) {
		return this.mainMapper.rec(contentid);
	}
	
	@Override
	public List<String> search(String title) {
		log.info("ServiceImpe title : "+title);
		return this.mainMapper.search(title);
	}

}

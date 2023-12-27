package com.bn.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bn.model.ContentVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class TourInfoServiceImpl implements TourInfoService {

	@Override
	public List<ContentVo> getCityData(String title) {
		
		return null;
	}
	
	@Override
	public int insertOverview(ContentVo vo) {
		
		return 1;
	}
	
	@Override
	public boolean existOverview(ContentVo vo) {
		
		return false;
	}

}

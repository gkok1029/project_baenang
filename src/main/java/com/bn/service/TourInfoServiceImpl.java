package com.bn.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.TourInfoMapper;
import com.bn.model.ContentVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class TourInfoServiceImpl implements TourInfoService {

	@Autowired
	private TourInfoMapper TourInfoMapper;
	
	@Override
	public List<ContentVo> getCityData(String title) {
		
		return TourInfoMapper.getCityData(title);
	}
	
	@Override
	public int insertOverview(ContentVo vo) {
		
		return 1;
	}
	
	@Override
	public List<ContentVo> existOverview(String title) {
		
		return TourInfoMapper.existOverview(title);
	}

}

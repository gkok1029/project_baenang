package com.bn.service;

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
	public ContentVo getCityData(String contentid) {
		
		ContentVo result = TourInfoMapper.getCityData(contentid);
		log.info("TSI result : "+result);
		return result;
	}
	
	@Override
	public int insertOverview(ContentVo vo) {
		return TourInfoMapper.insertOverview(vo);
	}
	
	@Override
	public String existOverview(String title) {
		
		return TourInfoMapper.existOverview(title);
	}

}

package com.bn.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.InfoMapper;
import com.bn.model.CityVo;
import com.bn.model.ContentVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class InfoServiceImpl implements InfoService {

	@Autowired
	private InfoMapper InfoMapper;
	
	@Override
	public ContentVo getTourData(String contentid) {
		ContentVo result = InfoMapper.getTourData(contentid);
		//log.info("InfoServiceImpl gettour result : "+result);
		return result;
	}
	
	@Override
	public int insertOverview(ContentVo vo) {
		return InfoMapper.insertOverview(vo);
	}
	
	@Override
	public String existOverview(String title) {
		
		return InfoMapper.existOverview(title);
	}
	
	@Override
	public CityVo getCityData(String cityname) {
		System.out.println("InfoServiceImpl getcity cityname : "+cityname);
		CityVo result = InfoMapper.getCityData(cityname);
		log.info("InfoServiceImpl getcity result : "+result);
		return result;
	}

}

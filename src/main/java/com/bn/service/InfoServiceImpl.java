package com.bn.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.InfoMapper;
import com.bn.model.ContentVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class InfoServiceImpl implements InfoService {

	@Autowired
	private InfoMapper InfoMapper;
	
	@Override
	public ContentVo getCityData(String contentid) {
		
		ContentVo result = InfoMapper.getCityData(contentid);
		log.info("TSI result : "+result);
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

}

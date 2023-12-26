package com.bn.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bn.mapper.MainMapper;
import com.bn.model.CityVo;

import lombok.extern.log4j.Log4j;

@Log4j
@Service("MainService")
public class MainServiceImpl implements MainService {

	@Autowired
	private MainMapper mainMapper;
	
	@Override
	public String rec(String contentid) {
		return this.mainMapper.rec(contentid);
	}
	
	@Override
	public List<CityVo> search(String title) {
		List<CityVo> result;
		//log.info("ServiceImpl title : "+title);
		System.out.println("ServiceImpl title : "+title);
		result = mainMapper.search(title);
		System.out.println("MC : result : "+result);
		
		return result;
	}
	
}

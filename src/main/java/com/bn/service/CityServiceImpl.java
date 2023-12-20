package com.bn.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bn.mapper.CityMapper;
import com.bn.model.CityVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CityServiceImpl implements CityService {
	
	@Inject
    private CityMapper cityMapper;

    public CityServiceImpl(CityMapper cityMapper) {
        this.cityMapper = cityMapper;
    }

    @Override
    public List<CityVO> getAllCities() {
        return cityMapper.getAllCities();
    }
    
    @Override
    public CityVO getCityById(String cityId) {
    	log.info("CSI : "+cityId);
        return cityMapper.getCityById(cityId);
    }
    
}

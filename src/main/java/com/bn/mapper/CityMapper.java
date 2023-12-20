package com.bn.mapper;

import java.util.List;

import com.bn.model.CityVO;

public interface CityMapper {
    List<CityVO> getAllCities();

    CityVO getCityById(String cityId);
    
}

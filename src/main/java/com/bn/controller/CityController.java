package com.bn.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.CityVO;
import com.bn.service.CityService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CityController {
    private CityService cityService;

    @Autowired
    public CityController(CityService cityService) {
        this.cityService = cityService;
    }

    @RequestMapping("/cities")
    public String getAllCities(Model model) {
        List<CityVO> cities = cityService.getAllCities();
        System.out.println(cities);
        model.addAttribute("cities", cities);
        return "cities";
    }
    
    @RequestMapping(value = "/getCityData", method = RequestMethod.GET)
    @ResponseBody
    public CityVO getCityData(@RequestParam String cityId) {
    	log.info("CC : "+cityId);
    	CityVO vo=cityService.getCityById(cityId);
        return vo;
    }
    
}

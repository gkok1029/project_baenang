package com.bn.model;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PlaceDTO {
    private String pname;
    private List<ContentVo> place;
    private List<ContentVo> hotel;
    private String startdate;
    private String enddate;
}

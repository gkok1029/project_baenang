package com.bn.model;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class PlaceDTO {
		private String pname;
	 	private List<ContentVo> place;
	    private List<ContentVo> hotel;
	    private Date startdate;
	    private Date enddate;

}

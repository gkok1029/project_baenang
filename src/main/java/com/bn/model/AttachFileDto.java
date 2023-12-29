package com.bn.model;

import java.util.Date;

import lombok.Data;

@Data
public class AttachFileDto {

	private long i_id;
	private String i_path;
	private Date i_birth;
	private String i_name; //uuid
	private String i_name2; //origin
}

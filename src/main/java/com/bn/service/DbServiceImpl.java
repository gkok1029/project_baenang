package com.bn.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bn.mapper.ContentMapper;
import com.bn.model.ContentVo;

@Service("DbService")
public class DbServiceImpl implements DbService {

	@Inject
	private ContentMapper contentMapper;
	
	@Override
	public int insertdb(ContentVo vo) {
		
		return this.contentMapper.insertdb(vo);
	}

}

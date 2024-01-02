package com.bn.service;

import java.util.List; 
import java.util.Map;

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
	 
	@Override
	public List<ContentVo> searchInRange(Map<String, Object> cd) {

		return this.contentMapper.searchInRange(cd);
	}

	@Override
	public void countup(String contentid) {
		
	 this.contentMapper.countup(contentid);
	}

	@Override
	public ContentVo contentload(String contentid) {
		return this.contentMapper.contentload(contentid);
	}

}

package com.bn.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bn.model.AttachFileDto;
import com.bn.model.Criteria;
import com.bn.model.ReplyVo;

public interface ReplyService {
	
	public int register(ReplyVo vo);
	
	public ReplyVo get(int r_id);
	
	public int modify(ReplyVo vo);
	
	public int remove(int r_id);
	
	public List<ReplyVo> getList(int p_id);
	
	int searchPid(String userEmail);
	
}
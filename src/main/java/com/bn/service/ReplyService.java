package com.bn.service;

import java.util.List;

import com.bn.model.ReplyVo;

public interface ReplyService {
	
	public int register(ReplyVo vo);
	
	public ReplyVo get(int r_id);
	
	public int modify(ReplyVo vo);
	
	public int remove(int r_id);
	
	public List<ReplyVo> getList(int r_id);

}
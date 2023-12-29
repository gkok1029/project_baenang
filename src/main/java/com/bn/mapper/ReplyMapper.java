package com.bn.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bn.model.Criteria;
import com.bn.model.ReplyVo;

public interface ReplyMapper {
	
	public int insert(ReplyVo vo);
	
	public ReplyVo read(int r_id);
	
	public int delete(int r_id);
	
	public int update(ReplyVo reply);

	public List<ReplyVo> getList(int p_id);

	public List<ReplyVo> getListWithPaging(Criteria cri, int p_id);
	
	
}

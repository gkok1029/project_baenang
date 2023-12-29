package com.bn.mapper;

import java.util.List;

import com.bn.model.AttachFileDto;
import com.bn.model.PostVo;

public interface PostMapper {
	
	public List<PostVo> getList();
	
	public void postInsert(PostVo post);
	
	public void postInsertSK(PostVo post);
	
	public PostVo postRead(int p_id);
	
	public int postDelete(int p_id);
	
	public int modPost(PostVo post);
	
	int updateP_veiws(int num);
	
	public int searchPid(String userEmail);
	
	public int imgInsert(AttachFileDto dto);
}
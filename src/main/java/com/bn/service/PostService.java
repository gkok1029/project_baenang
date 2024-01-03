package com.bn.service;

import java.util.List;

import com.bn.model.AttachFileDto;
import com.bn.model.PostVo;


public interface PostService {

	public void register(PostVo post);
	public PostVo get(int p_id);
	public boolean modify(PostVo post);
	public boolean removeImgD(int p_id);
	public boolean remove(int p_id);
	public List<PostVo> getList();
	int searchPid(String userEmail);
	public int imgInsert(AttachFileDto dto);
	public int imgDirInsert(AttachFileDto dto);
}

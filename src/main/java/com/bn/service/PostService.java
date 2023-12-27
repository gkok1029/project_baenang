package com.bn.service;

import java.util.List;

import com.bn.model.PostVo;


public interface PostService {

	public void register(PostVo post);
	public PostVo get(int p_id);
	public boolean modify(PostVo post);
	public boolean remove(int p_id);
	public List<PostVo> getList(int p_id);
	
}

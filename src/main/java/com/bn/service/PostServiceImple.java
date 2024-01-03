package com.bn.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bn.model.AttachFileDto;
import com.bn.model.PostVo;
import com.bn.mapper.PostMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service("PostService")
@AllArgsConstructor
public class PostServiceImple implements PostService {

	private PostMapper mapper;

	@Override
	public void register(PostVo post) {

		log.info("register...: " + post);
		mapper.postInsert(post);

	}

	@Override
	public PostVo get(int p_id) {
		log.info("get...:" + p_id);
		return mapper.postRead(p_id);
	}

	@Override
	public boolean modify(PostVo post) {
		log.info("modi post" + post);
		return mapper.modPost(post) == 1;
	}

	@Override
	public boolean removeImgD(int p_id) {
		log.info("remove post" + p_id);
		return mapper.deleteImgD(p_id) == 1;
		
	}
	
	@Override
	public boolean remove(int p_id) {
		log.info("remove post" + p_id);
		
		return mapper.postDelete(p_id) == 1;
	}

	@Override
	public List<PostVo> getList() {
		log.info("get list");
		List<PostVo> boyeogeo=mapper.getList();
		System.out.println("PSI : "+boyeogeo);
		return mapper.getList();
	}
	
	@Override
	public int searchPid(String userEmail) {
		return mapper.searchPid(userEmail);
	}

	@Override
	public int imgInsert(AttachFileDto dto) {
		return mapper.imgInsert(dto); 
	}

	@Override
	public int imgDirInsert(AttachFileDto dto) {
		return mapper.imgDirInsert(dto);
	}

}

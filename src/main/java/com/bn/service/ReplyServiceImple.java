package com.bn.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import com.bn.mapper.ReplyMapper;
import com.bn.model.Criteria;
import com.bn.model.ReplyVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImple implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Override
	public int register(ReplyVo vo) {
		log.info("register........." + vo);

		return mapper.insert(vo);
	}

	@Override
	public ReplyVo get(int r_id) {
		log.info("get............" + r_id);

		return mapper.read(r_id);
	}

	@Override
	public int modify(ReplyVo vo) {
		log.info("modify............" + vo);

		return mapper.update(vo);
	}

	@Override
	public int remove(int r_id) {
		log.info("remove.............." + r_id);

		return mapper.delete(r_id);
	}


	@Override
	public List<ReplyVo> getList(Criteria cri, int p_id) {
		
		log.info("Reply List" + p_id);
		
		return mapper.getListWithPaging(cri, p_id);
	}
}

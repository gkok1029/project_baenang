package com.bn.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bn.model.PostVo;

@Repository
public class PostDAO {
	@Autowired
	public SqlSession sqlSession;
	
	public List<PostVo> getPostList(){
		return sqlSession.selectList("getPostList");
	}
}

package com.bn.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bn.model.PostVo;
import com.bn.mapper.*;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PostServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private PostService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		PostVo post = new PostVo();
		
		post.setP_title("new 제목");
		post.setP_content("new 내용");

		service.register(post);
		
		log.info("p_id is " +post.getP_id());
	}
	
	@Test
	public void testGetList(){
		service.getList().forEach(post -> log.info(post));
	}
	
}

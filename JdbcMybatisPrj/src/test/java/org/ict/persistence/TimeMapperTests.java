package org.ict.persistence;

import org.ict.mapper.TimeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class TimeMapperTests {

	
	@Autowired
	private TimeMapper timeMapper;
	
	//@Test
	public void testGetTime() {
		log.info("현재 시간 조회중...");
		log.info(timeMapper.getTime());
	}
	
	//@Test
	public void testGetTime2() {
		log.info("getTime2가 얻어온 시간");
		log.info(timeMapper.getTime2());
	}
	
	// getTime3를 만들어서 테스트코드에서 실행까지 해 주세요. 
	
	@Test
	public void testGetTime3() {
		log.info("getTime3가 얻어온 시간");
		log.info(timeMapper.getTime3());
	}
}

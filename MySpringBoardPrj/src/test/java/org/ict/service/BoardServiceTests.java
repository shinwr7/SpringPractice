package org.ict.service;

import static org.junit.Assert.assertNotNull;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

// Service테스트는 BoardServiceImpl 내부 기능을
// 서버 가동 없이 테스트하기 위해 작성합니다.
// 아래에 기본 세팅을 해주세요.

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	// 다형성 원리에 의해서 BoardService로 만들어도 
	// BoardServiceImpl이 주입됨
	@Autowired
	private BoardService service;
	
	// 먼저 서비스가 제대로 주입되었는지 여부만 확인해봅니다. 
	//@Test
	public void testExist() {
		log.info(service);
		
		// assertNotNull은 해당 객체가 주입이 되지 않아
		// null인경우 에러를 발생시킵니다.
		assertNotNull(service);
	}
	
	//@Test
	public void testRegister() {
		BoardVO vo = new BoardVO ();
		vo.setWriter("writer");
		vo.setContent("content");
		vo.setTitle("title");
		service.register(vo);
		
	}
	// 글 전체 목록을 가져오는 로직을 작성해주세요. 
	// 해당 로직은 mapper내부의 getList의 쿼리문을 먼저 
	// 전체 글을 가져오는 로직으로 수정해 주신 다음 service 에 
	// 등록해서 구현해주시면 됩니다.
	// 추가로 테스트 진행
	//@Test
	public void testGetList() {
		
	//	log.info(service.getList());
		
	}
	//@Test
	public void testGet() {
		log.info(service.get(5L));
	}
	//@Test
	public void testRemove() {
		service.remove(6L);
		
	}
	@Test
	public void testModify() {
		// 수정 로직도 수정사항 정보를 BoardVO에 담아서
		// 전달하기 때문에 BoardVO를 만들어놓고 자료를 저장한뒤 실행합니다.
		BoardVO vo = new BoardVO ();
		
		vo.setTitle("수정 제목");
		vo.setContent("수정 내용");
		vo.setWriter("수정 글쓴이");
		vo.setBno(6L);
		service.modify(vo);
	}
}

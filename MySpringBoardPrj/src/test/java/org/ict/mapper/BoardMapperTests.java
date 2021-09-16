package org.ict.mapper;

import org.ict.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;

import lombok.extern.log4j.Log4j;

// 테스트코드 기본 세팅(RunWith, ContextConfiguration, Log4j) 

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j

public class BoardMapperTests {
	// 이 테스트코드 내에서는 Mapper테스트를 담당합니다.
	// 따라서 BoardMapper내부의 메서드를 실행할 예정이고
	// BoardMapper 타입의 변수가 필요하니 
	// 선언해주시고 자동 주입으로 넣어주세요.
	
	@Autowired
	private BoardMapper bm;
	
	
	//@Test
	public void testGetList() {
		// mapper 내부의 getList 메서드를 호출하려면? 
		log.info(bm.getList());
	}
	
	
	// Insert를 실행할 테스트코드를 하단에 작성해보겠습니다.
	//@Test
	public void testInsert() {
		// 글 입력을 위해서 BoardVO 타입을 매개로 사용함
		// 따라서 BoardVO를 만들어놓고
		// setter로 글제목, 글본문, 글쓴이 만 저장해둔 채로
		// bm.insert(vo);를 호출해서 실행여부를 확인하면 끝
		
		BoardVO vo = new BoardVO() ;
		vo.setTitle("?");
		vo.setContent("?");
		vo.setWriter("?");
		
		log.info(vo);
		
		bm.insert(vo);
	}
	
	//@Test
	public void testSelect() {
		log.info(bm.select(3L));
	}
	// 글 번호 (Long bno)를 파라미터로 받아/
	// 해당 글 번호에 맞는 글을 삭제해주는 메서드를 작성해주세요
	// 메서드 이름은 delete 입니다
	// xml파일에 쿼리문도 작성해주시고
	// 테스트코까지 만들어 실제로 삭제되는지 sqldeveloper로 봐주세요 
	
	//@Test
	public void testDelete() {
		
		bm.delete(3L);
	}
	
	//@Test
	public void testUpdate() {
		
		BoardVO vo = new BoardVO() ;
		
		vo.setTitle("s");
		vo.setContent("s");
		vo.setWriter("s");
		vo.setBno(4L);
		
		bm.update(vo);
	}
	
	
}

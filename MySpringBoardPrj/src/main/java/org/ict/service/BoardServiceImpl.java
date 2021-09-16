package org.ict.service;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

// BoardServiceImpl은 BoardService 인터페이스를 구현합니다.

@Log4j //로깅을 위한 어노테이션 // x 뜨면 자세한 사항은 pom.xl 의 log4j 참조
@Service //  의존성 등록을 위한 어노테이션
@AllArgsConstructor // 서비스 생성자 자동생성
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO vo) {
		
		log.info("등록 작업 실행");
		mapper.insert(vo);
	}

	@Override
	public BoardVO get(Long bno) {
		
		BoardVO vo = mapper.select(bno);
		log.info(bno + "번 글 조회");
		// TODO Auto-generated method stub
		return vo;
	}

	@Override
	public void modify(BoardVO vo) {
		// TODO Auto-generated method stub
		log.info("글 수정작업 진행 - "+ vo);
		mapper.update(vo);
	}

	@Override
	public void remove(Long bno) {
		// TODO Auto-generated method stub
		log.info(bno + "번 글 삭제 작업 진행");
		mapper.delete(bno);
		
	}
	
		// 전체 글 목록을 가져오는 로직을 작성해주세요
		// 해당 로직은 mapper 내부의 getList의 쿼리문을 먼저
		// 전체 글을 가져오는 로직으로 수정해 주신 다음 service에
		// 등록해서 구현해주시면 됩니다.
		// 추가로 테스트도 진행

	@Override
	public List<BoardVO> getList() {
		// TODO Auto-generated method stub
		List<BoardVO> boardList = mapper.getList();
		return boardList;
	}



}

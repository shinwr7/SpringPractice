package org.ict.service;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.mapper.BoardMapper;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper mapper;
	
	// 리플 썼을때 board_tbl도 업데이트 해야하므로  board_tbl에 접근할 수 있는
	// BoardMapper도 필요
	@Autowired
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
		boardMapper.updateReplyCount(vo.getBno(), 1);
	}
	
	@Override
	public List<ReplyVO> listReply(Long bno) {
		return mapper.getList(bno);
	}
	
	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
	}
	
	@Transactional
	@Override
	public void removeReply(Long rno) {
		Long bno = mapper.getBno(rno);
		mapper.delete(rno);
		boardMapper.updateReplyCount(bno, -1);
	}
	

}

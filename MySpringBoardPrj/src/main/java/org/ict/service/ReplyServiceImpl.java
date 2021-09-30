package org.ict.service;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public void addReply(ReplyVO vo) {
		mapper.create(vo);
	}
	
	@Override
	public List<ReplyVO> listReply(Long bno) {
		return mapper.getList(bno);
	}
	
	@Override
	public void modifyReply(ReplyVO vo) {
		mapper.update(vo);
	}
	
	@Override
	public void removeReply(Long rno) {
		mapper.delete(rno);
	}
	

}

package org.ict.security;

import org.apache.ibatis.annotations.Param;
import org.ict.domain.AuthVO;
import org.ict.domain.MemberVO;
import org.ict.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
public class UserJoinService {
	
	@Autowired
	private PasswordEncoder pwen;
	
	@Autowired
	MemberMapper mapper;
	
	@Transactional
	public void userJoin(MemberVO mvo, AuthVO avo) {
		log.info("회원가입 서비스 실행");
		
		mvo.setUserpw(pwen.encode(mvo.getUserpw()));
		
		mapper.join(mvo);
		mapper.authorize(avo);
	}
	
}

package org.ict.mapper;

import org.ict.domain.AuthVO;
import org.ict.domain.MemberVO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public void join(MemberVO mvo);
	
	public void authorize(AuthVO avo);
}

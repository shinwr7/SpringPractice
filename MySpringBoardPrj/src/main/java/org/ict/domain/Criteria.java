package org.ict.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 페이징 처리를 할 때 페이지 하단에 현재 보고있는 페이지에 맞는
// 버튼을 깔아야 하는데, 이를 처리하려면 여러 정보가 동시에 전달되어야 해서
// 아예 페이징 처리에 필요한 정보들을 묶어서 전달하기 위해 
// Criteria 객체를 생성해 사용합니다.
@Getter
@Setter
@ToString
// @Data 안쓰는 이유? 
// -> 생성자를 커스터마이징 해야하는데, data는 생성자를 지가 생성해버림. 충돌날 가능성
public class Criteria {
	
	// 페이지 번호, 페이지당 몇 개의 글을 보여줄지에 대해
	// 먼저 저장하고,이를 이용해 나머지 정보를 계산합니다.
	private int pageNum;
	private int amount;
	
	// 생성자 오버로딩, 만약 페이지 정보가 들어온게 없다면
	// 1페이지, 10개 게시물 게시를 기본값으로
	public Criteria() {
		this(1, 10);
	}
	
	// 페이지 정보가 들어온다면 들어온 정보로 수치를 정함
	public Criteria(int pageNum, int amount) {
		this.pageNum=pageNum;
		this.amount=amount;
	}

}

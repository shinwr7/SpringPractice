package org.ict.domain;

import lombok.Getter;
import lombok.ToString;

// DTO는 Data Transfer Object로 데이터 전달 객체라고 합니다.
// DTO와 VO나 엄격하게 구분되는 것은 아니고 둘 다 특정 데이터를
// 한 변수에 묶어서 보내기 위해 사용합니다. 
// 차이점이 있다면 VO는 DB에서 바로 꺼낸 데이터를 매칭시키고
// DTO는 DB에 있는 정보를 토대로 가공한 데이터를 전달할 때 
// 사용한다는 차이가 있습니다.

@Getter
@ToString
public class PageDTO {

	// 페이지네이션 버튼을 몇 개 깔지
	private int btnNum;
	// 페이지 세트 중 시작하는 페이지
	// 16페이지 조회중이라면 11이 시작페이지
	private int startPage;
	// 페이지 세트 중 마지막 페이지 
	// 16페이지 조회중이라면 20이 끝페이지
	private int endPage;
	// 이전, 이후 10개 페이지 버튼 유무여부
	private boolean prev, next;
	
	// 전체 데이터 갯수
	private int total;
	private Criteria cri; // Criteria 는 현재 화면(글 목로) 띄워주기 위해
	
	// DTO 는 페이징 버튼을 보여주기 위해
	// 위의 변수 정보들을 자동으로 계산하게 하기 위한 생성자
	public PageDTO(Criteria cri, int total, int btnNum) {
		this.cri = cri;
		this.total = total;
		this.btnNum = btnNum;
		
		
		// 위에서 저장된 멤버변수를 이용해 나머지 정보 구하기
		// 끝페이지를 먼저 구하고
		// 끝페이지 = 올림((현재페이지/출력페이지, 실수))* 출력페이지
		this.endPage = 
				(int)(Math.ceil(cri.getPageNum() / (double)this.btnNum)
						*this.btnNum);
		
		this.startPage = this.endPage - this.btnNum + 1;
		
		// realEnd 로직은 제일 마지막 페이지 버튼의 값을 구하는 로직 
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		// endPage 는 10의 배수로만 나오는데, 그렇게 하면 제일 마지막 페이지 버튼의 값인 realEnd와는 상관없이
		// 10의 배수 페이지 넘버로 끝나게 됨. 즉, 실제로 데이터는 예를 들어 754페이지 까지의 데이터 밖에 없는데 
		// 페이지 버튼은 755 756 757 758 759 760 으로 나오게 되는 거임
		// 이걸 막기 위해
		// realEnd가 endPage 보다 작을 경우 endPage를 realEnd로 치환시킴
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		// 이전 페이지는 출력 페이지가 1~10인 경우만 아니면 갈 수 있어야 함
		this.prev = this.startPage == 1 ? false : true;
		
		this.next = this.endPage < realEnd ;
		
	}
	
}

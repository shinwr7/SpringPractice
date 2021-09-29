package org.ict.controller;
// 의존성 추가, 로깅기능을 추가해주세요 .

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.PageDTO;
import org.ict.domain.SearchCriteria;
import org.ict.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor // 의존성 주입 설정을 위해 생성자만 생성
@RequestMapping("/board/*")// 주소는 조금 이따가 추가
// 이 클래스를 사용하는 모든 메서드의 연결주소 앞에 /board/ 추가
public class BoardController {

	// 컨트롤러는 서비스를 호출합니다. / 서비스는 매퍼롤 호출합니다.
	@Autowired
	private BoardService service;
	
	//@GetMapping("/list") // Get방식으로만 주소연결
	public void list(Model model, String keyword) {
		log.info("keyword 값 : "+ keyword);
		if(keyword==null) {
			keyword="";
		}
		log.info("list로직 접속");
		// 전체 글 정보를 얻어와서 
		List<BoardVO> boardList = service.getList(keyword);
		
		//view 파일에 list라는 이름으로 넘겨주기
		model.addAttribute("list", boardList);
		if(keyword!="") {
			model.addAttribute("keyword_ok", keyword);
		}
		
		// 1. views 하위에 경로에 맞게 폴더 및 .jsp 파일 생성
		// 2. 부트스트랩을 적용해 게시글 목록을 화면에 표시.
		
	}
	
	// 아래 주소로 데이터를 보내줄 수 있는 form을 작성해주세요. 
	// register.jsp 파일명으로 작성해주시면 되고
	// @GetMapping으로 register.jsp에 접근할 수 있는 
	// 컨트롤러 메서드도 아래에 작성해주세요 .
	
	@PostMapping("/register") // Post 방식으로만 접속 허용
	public String register(BoardVO vo, RedirectAttributes rttr) {
		
		// 글을 썼으면 상세 페이지나 혹은 글 목록으로 이동시켜야 합니다.
		
		// 1. 글 쓰는 로직 실행 후,
		service.register(vo);
		log.info("insertSelectKey확인 : "+ vo);
		// 2. list 주소로 강제로 이동을 시킵니다.
		// 이동을 시킬 떄 몇번 글을 썼는지 안내해주는 로직을 추가합니다.
		// addFlashAttribute는 redirect시에 컨트롤러에서
		// .jsp 파일로 데이터를 보내줄 때 사용합니다.
		// model.addAttribute()를 쓴다면
		// 일반 이동이 아닌 redirect 이동시는 데이터가 소멸됨 
		// 이를 막기 위해 rttr.addFlashAttribute로 대신함
		rttr.addFlashAttribute("bno", vo.getBno());
		rttr.addFlashAttribute("success", "register");
		
		// views 폴더 하위 board 폴더의 list.jsp 출력
		// redirect로 이동시킬떄는 "redirect:파일명"
		return "redirect:/board/list";
		
		
	}
	
	@GetMapping("/register")
	public void goRegister() {
		
		
	}
	
	// 실제 페이지 조회는 Long bno에 적힌 글번호를 이용해서 합니다.
	// /get 을 주소로 getmapping을 사용하는 메서드 get을 만들어주세요. 
	// service에서 get() 을 호출해 가져온 글 하나의 정보를 
	// get.jsp에 보냅니다. 　
	
	@GetMapping("/get")
	public String get(Long bno, Model model) {
		log.info("전달받은 bno 값: "+ bno);
		
		if(bno==null) {
			return "redirect:/board/list";
		}
		BoardVO board = service.get(bno);
		
		model.addAttribute("board", board);
		
		return "/board/get";
	}
	
	// get방식으로 삭제를 허용하면 매크로 등을 이용
	// 글삭제 맘대로 하는 경우 생김
	// 무조건 삭제버튼 클릭, 삭제할수 있도록
	// post방식 접근 허용
	// bno를 받아서 삭제, 삭제 후에는 "success" 문자열 .jsp로 보내줘
	// 삭제 완료되면 redirect 기능으로 list페이지로
	// 코드 및 파라미터작성
	@PostMapping("/remove")
	public String remove(Long bno, RedirectAttributes rttr) {
		log.info("삭제 로직 : " + bno);
		service.remove(bno);
		rttr.addFlashAttribute("success", "success");
		rttr.addFlashAttribute("bno", bno);
		
		return "redirect:/board/list";
		
	}
	
	// 수정 로직도 post방식으로 진행
	// /modify를 주소로 하고, 사용자가 수정할 수 있는 요소들을
	// BoardVO로 받아서 처리
	
	@PostMapping("/modify")
	// searchType, keyword, pageNum을 컨트롤러가 받아올 수 있도록
	// 해당 이름의 멤버변수를 가진 SearchCriteria를 파라미터선언
	public String modify(SearchCriteria cri, BoardVO vo, RedirectAttributes rttr) {
		service.modify(vo);
		rttr.addFlashAttribute("m_success", "m_success");
		
		log.info("검색어 : " + cri.getKeyword());
		log.info("검색조건 : "+ cri.getSearchType());
		log.info("페이지번호 : " + cri.getPageNum());
		
		// rttr.addAttribute("파라미터명", "전달자료")
		// 는 호출되면 redirect 주소 뒤에 파라미터를 붙여줍니다.
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/get";
	}
	
	// 글을 수정할때는 modify.jsp 를 이용해 수정을 해야합니다. 
	// PostMapping을 이용해서 /boardmodify로 접속 시 수정폼으로 접근시켜주세요
	// 수정 폼은 register.jsp와 비슷한 양식으로 작성되어 있지만
	// 해당 글이 몇 번인지에 대한 정보도 화면에 표출시켜야 하고
	// 글쓴이는 readonly 를 걸어서 수정 불가하게 만들어주세요
	// 아래 메서드는 수정 폼으로 접근하도록 만들어주시고
	// 수정 폼에는 내가 수정하고자 하는 글의 정보를 먼저 받아온 다음
	// model.addAttribute로 정보를 .jsp로 보내서 폼을 채워두시면 됩니다.
	
	@PostMapping("/boardmodify")
	public String goModify (Long bno, Model model) {
		
		BoardVO vo = service.get(bno);
		
		log.info(vo);
		// vo를 modify.jsp로 전달하고 modify.jsp에서 전달받았는지 확인
		
		model.addAttribute("board", vo);
		
		return "/board/modify";
	}
	
	@GetMapping("/list")
	public void list(SearchCriteria cri, Model model) {
		// pageNum, amount로 전달된 자료를 활용해
		// 게시글 목록 조회
		
		
		List<BoardVO> boards = 
		service.getListPaging(cri);
		
		// 페이지 밑에 깔아줄 페이징버튼 관련 정보 생성
		// 단순히 페이지버튼 깔리는지 여부를 테스트할때는 
		// 우선 글 갯수를 정확하게 모르므로 253개를 임의로 넣고
		// 까는 버튼 갯수는 최대 10개로 고정
		
		PageDTO btnMaker = new PageDTO(cri, service.getListCount(cri), 10);
		
		
		// 버튼 관련 정보도 같이 넘겨줌
		// btnMaker를 넘기면 동시에 SearchCriteria도 같이 넘어감
		// 단, btnMaker 내부 멤버변수로 SearchCriteria가 있기 때문에
		// 클래스 내부 변수로 클래스를 넣은 형태라 호출이 2단계로 이루어짐
		model.addAttribute("btnMaker", btnMaker);
		
		model.addAttribute("list", boards);
		
		// board/list.jsp로 자동연결이 되므로 
		// 리턴구문은 필요없습니다.
		
	}
}

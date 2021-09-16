package org.ict.controller;
// 의존성 추가, 로깅기능을 추가해주세요 .

import java.util.List;

import org.ict.domain.BoardVO;
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
	
	@GetMapping("/list") // Get방식으로만 주소연결
	public void list(Model model) {
		
		log.info("list로직 접속");
		// 전체 글 정보를 얻어와서 
		List<BoardVO> boardList = service.getList();
		
		//view 파일에 list라는 이름으로 넘겨주기
		model.addAttribute("list", boardList);
		
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
		// 2. list 주소로 강제로 이동을 시킵니다.
		// 이동을 시킬 떄 몇번 글을 썼는지 안내해주는 로직을 추가합니다.
		// addFlashAttribute는 redirect시에 컨트롤러에서
		// .jsp 파일로 데이터를 보내줄 때 사용합니다.
		// model.addAttribute()를 쓴다면
		// 일반 이동이 아닌 redirect 이동시는 데이터가 소멸됨 
		// 이를 막기 위해 rttr.addFlashAttribute로 대신함
		rttr.addFlashAttribute("result", vo.getBno());
		
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
	
	
}

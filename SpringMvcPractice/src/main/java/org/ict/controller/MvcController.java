package org.ict.controller;

import org.ict.domain.TestVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

// 빈 컨테이너에 넣어주세요. 

@Controller
public class MvcController {

	// 기본주소(localhost:8181)뒤에 /goA를 붙이면 goA() 메서드 실행
	@RequestMapping(value="/goA")
	// return 타입이 String인 경우 결과 페이지를 지정할 수 있음
	public String goA() {
		System.out.println("goA 주소 접속 감지");
		// 결과 페이지는 views 폴더 아래의 A.jsp
		return "A";
	}
	@RequestMapping(value="/goB")
	// return 타입이 String인 경우 결과 페이지를 지정할 수 있음
	public String goB() {
		System.out.println("goB 주소 접속 감지");
		// 결과 페이지는 views 폴더 아래의 A.jsp
		return "B";
	}
	
	// goC는 파라미터를 입력받을 수 있도록 해보겠습니다.
	@RequestMapping(value="/goC")
	// 주소 뒤 ?cNum=값 형태로 들어오는 값을 로직 내 cNum으로 처리합니다.
	// 들어온 파라미터를 .jsp파일로 전달하기 위해서는
	// Model model을 파라미터에 추가로 선언해줍니다.
	public String goC(int cNum, Model model) {
		System.out.println("주소로 전달받은 값 : "+cNum);
		
		// 전달받은 cNum을 C.jsp에 출력하는 로직을 작성해주세요
		model.addAttribute("cNum", cNum);
		
		return "C";
	}
	
	// goD는 requestParam을 이용해 변수명과 받는 이름이 일치하지 않게 해보겠습니다.
	@RequestMapping(value="/goD")
	// @RequestParam("대체이름")은 변수 왼쪽에 선언합니다.
	// 이렇게 되면 적힌 변수명 대신 대체이름으로 치환해 받아옵니다.
	public String goD(@RequestParam("d") int dNum, Model model) {
		
		System.out.println("d 변수명으로 받은 것 dNum에 저장 : "+dNum);
		
		// 받아온 변수를 D.jsp에서 출력해주세요.
		model.addAttribute("dNum", dNum);
		
		return "D";
		
	}
	// cToF 메서드를 만들겠습니다.
	// 섭씨 온도를 입력받아 화씨 온도로 바꿔서 출력해주는 로직을 작성해주세요.
	// (화씨 - 32) / 1.8 = 섭씨입니다.
	// ctof.jsp 파일이름
	
	// 폼에서 post방식으로 제출했을때만 결과페이지로 넘어오도록 설계
	@RequestMapping(value="/ctof", method=RequestMethod.POST)
	public String cToF(@RequestParam("cel") int cel, Model model) {
		
		System.out.println("입력받은 섭씨 온도 : " + cel );
		
		double far = cel*1.8+32;
		
		
		model.addAttribute("far", far);
		model.addAttribute("cel", cel);
		
		return "ctof";
	}
	
	// 폼으로 연결하는 메서드도 만들겠슴당
	// 폼과 결과페이지가 같은 주소를 공유하게 하기 위해 폼쪽을 갯 방식 접근허용
	@RequestMapping(value="/ctof", method=RequestMethod.GET)
	public String cToFForm() {
		
		//ctofform을 이용해 섭씨온도를 입력하고 제출버튼을 누르면
		// 결과값이 나오는 로직을 작성해주세요 .
		// input 태그의 name 속성은 cel로 주시면 되고
		// action은 value에 적힌 주소값으로 넘겨주시면 됩니다.
		
		return "ctofform";
	}
	
	// 위와 같은 방식으로 bmi 측정페이지를 만들어보겠습니다.
	// 폼과 결과페이지로 구성해주시면 되고
	// bmi 공식은 체중/ (키(m)^2)으로 나오는 결과입니다.
	
	@RequestMapping(value="/bmi", method=RequestMethod.POST)
	public String getBmi(@RequestParam("height") double height, 
						@RequestParam("weight") int weight, Model model) {
		
		System.out.println("입력받은 키(cm) : "+ height);
		System.out.println("입력받은 몸무게(kg) : "+ weight);
		
		double heightM = height / 100;
		System.out.println(heightM);
		double bmi = weight/(heightM*heightM);
		
		model.addAttribute("height", height);
		model.addAttribute("weight", weight);
		model.addAttribute("bmi", bmi);
		
		return "getbmi";
		
		
	}
	@RequestMapping(value="/bmi", method=RequestMethod.GET)
	public String goBmiForm() {
		
		return "bmiform";
	}
		
	// PathVariable을 이용하면 url 패턴만으로도 특정 파라미터를 받아올 수 있습니다.
	// rest 방식으로 url을 처리할 때 주로 사용하는 방식입니다.
	@RequestMapping(value="/pathtest/{page}")
	// int page 왼쪽에 @PathVariable을 붙여서 처리해야 연동됩니다.
	public String pathTest(@PathVariable int page, Model model) {
		
		// 받아온 page 변수를 path.jsp로 보내주세요.
		// path.jsp에는 {path} 페이지 조회중입니다. 라는 문장이 뜨게 해주세요.
		
		model.addAttribute("page", page);
		
		return "path";
	}
	
	// ctof 로직을 PathVariable을 적용해서 만들어주세요 
	// ctofpv.jsp 에 결과가 나오면 됩니다.
	@RequestMapping(value="/ctofpv/{cel}" )
	public String ctofpv(@PathVariable int cel, Model model) {
		
		double far = cel*1.8+32;
		
		
		model.addAttribute("cel", cel);
		model.addAttribute("far", far);
		
		return "ctofpv";
	}
	// void 타입 컨트롤러의 특징 
	// void 타입은 return 구문을 사용할 수 없는 만큼
	// view 파일의 이름을 그냥 url패턴.jsp 로 자동 지정 해버립니다.
	// 간단한 작성은 void 타입으로 해도 되지만 메서드명에 제약이 생겨서 잘 안씁니다.
	@RequestMapping(value="/voidreturn", method=RequestMethod.GET)
	public void voidTest(int num, Model model) {
		System.out.println("void 컨트롤러는 리턴구문이 필요없습니다.");
		// 1. 파라미터를 아무거나 받아오게 임의로 설정해주세요 .
		
		// 2. 현 메서드에 맞는 view파일을 생성해주세요. 
		
		// 3. 1에서 얻어온 파라미터를 2에 출력되도록 설정해주세요.
		
		model.addAttribute("num", num);
		
	}
	// 원래 파라미터의 자료형이 int, String등이었던 경우는
	// 단일 자료형이었기 때문에 get, post 방식으로 전달되는 데이터를 자동으로 
	// 받아서 처리할 수 있었습니다. 
	// 현재 TestVO 내부에는 int age, String name 이 들어있고
	// TestVO를 아래와 같인 선언하는 것만으로도 int age, String name을 선언하는 것과 
	// 같은 효과를 볼 수 있습니다.
	// 즉 ?age=OOO&name=OOO 라고 적는 데이터를 받아올 수 있습니다.
	
	@RequestMapping(value="/getVO")
	public String getVO(TestVO vo, Model model) {
		System.out.println("받아온 객체 : "+ vo);
		
		//1. TestVO에 멤버변수를 하나 더 추가해서 객체 3개를 처리하도록 해주세요.
		
		// 2.voview.jsp를 생성해주시고, 거기에 vo 내부 멤버변수값을 각각 따로따로
		// 화면에 표시해주세요 
		model.addAttribute("TestVO", vo);
		
		// testvo폴더 내부의 voview.jsp
		return "testvo/voview";
	}
	
	
}

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<style>
#modDiv{
		width: 300px;
		height: 100px;
		background-color: green;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-top: -50px;
		margin-left: -150px;
		padding: 10px;
		z-index: 1000;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<!--1. jquery 입력받을 수 있도록 처리 -->
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--2. body태그 하단에 <script>태그 작성 후 var bno = ${vo.bno}로 글 번호를 받은 다음
function getAllList()를 test.jsp에서 복붙해서 게시물별 페이지에서 잘 작동하는지 확인 해주세요  -->
</head>
<body>
	
	<h1>게시글</h1>
	글번호 : ${board.bno}<br/>
	제목 : ${board.title }<br/>
	본문 : ${board.content }<br/>
	글쓴이 : ${board.writer }<br/>
	날짜 : ${board.regdate }<br/>
	수정날짜 : ${board.updatedate }<br/>
	
	<button type="button" class="btn btn-primary" onclick="location.href='/board/list?pageNum=${param.pageNum}&searchType=${param.searchType }&keyword=${param.keyword }'">돌아가기</button>
	 <%--  pageNum, searchType, keyword 들어오는지 여부 디버깅 
	db 연계 필요없이 웹 쪽에서 get방식으로 전달한 데이터 받을 수 있음
	EL의 ${param.파라미터명}--%>
	페이지번호 : ${param.pageNum }<br/>
	검색조건 : ${param.searchType }<br/>
	키워드 : ${param.keyword }<br/>
	<!-- 글 삭제가 되면, 리스트 페이지로 넘어가는데, 삭제로 넘어오는 경우는 alert()창을 띄워서 "글이 삭제되었습니다."가 출력되도록 로직을 짜주세요 -->
	<form action="/board/remove" method="post">
		<input type="hidden" name="bno" value="${board.bno }">
		<input type="submit" class="btn btn-danger" value="삭제">
	</form>
	<form action="/board/boardmodify" method="post">
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
		<input type="hidden" name="searchType" value="${param.searchType}">
		<input type="hidden" name="keyword" value="${param.keyword}">
		<input type="submit" class="btn btn-primary" value="수정하기">
	</form>
	
	<hr>
	<div class="row">
		<h3 class="text-primary">댓글</h3>
		<div id="replies">
			<!-- 댓글 들어갈 위치 -->
		</div>
	</div>
	<!-- 모달창, 기타 ajax 호출 로직을 가져와서 실제로 작동하는지 화인해주세요. -->
	
	<div>
		<div>
			REPLYER <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			REPLY<input type="text" name="reply" id="newReply">
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>


	<!-- 모달 요소는 안보이기 때문에 어디 넣어도 되지만 보통 html 요소들 끼리 놨을 때 
	제일 아래쪽에 작성하는 경우가 많습니다. -->
	<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="replytext">
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">Delete</button>
			<button type="button" id="closeBtn">Close</button>
		</div>
	</div>
	
	<script>
	// 글쓰기
	$("#replyAddBtn").on("click", function() {
		// 각 input 태그에 들어있던, 글쓴이, 본문의 value값을 변수에 저장함.
		var replyer = $("#newReplyWriter").val();
		var reply = $("#newReply").val();
		console.log("클릭됨");
	
		$.ajax({
			type:'post',
			url:'/replies',
			headers: {
				"Content-Type" : "application/json",
				"X-HTTP-METHOD-Override" : "POST"
				
			},
			dataType : "text",
			data : JSON.stringify({
				// 왼쪽 : 오른쪽 
				// 왼쪽 => 쿼리문과 매칭, 오른쪽 => 입력하는 벨류값
				bno : bno,
				replyer : replyer,
				reply : reply
			}),
			success : function(result) {
				if(result =='SUCCESS'){
					alert("등록되었습니다.");
					$("#newReplyWriter").val("");
					$("#newReply").val("");
					getAllList();
				}
			}
			
		})
	});
	
	// 글삭제
	$("#replyDelBtn").on("click", function(){
		//삭제에 필요한 댓글번호 모달 타이틀 부분에서 얻기
		var rno = $(".modal-title").html();
		
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			// 전달 데이터가 없이 url과 호출타입만으로 삭제처리하므로
			// 이외 정보는 제공할 필요가 없음
			success : function(result){
				if(result === 'SUCCESS') {
					alert(rno + '번 댓글이 삭제되었습니다.');
					// 댓글 삭제 후 모달창 닫고 새 댓글목록 갱신
					$("#modDiv").hide("slow");
					getAllList();
				}
			}
		})
	});
	
	// 글수정
	$("#replyModBtn").on("click", function() {
		//수정에 필요한 댓글번호 모달 타이틀 부분에서 얻기 
		var rno = $(".modal-title").html();
		console.log('rno 값: ' + rno);
		//수정에 필요한 본문내용 #reply의 value 값에서 얻기
		var reply = $("#replytext").val();
		console.log('reply 값 : ' + reply );
		
		$.ajax({
			type: 'patch',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PATCH"
			},
			dataType : 'text',
			data : JSON.stringify({reply:reply}),
			success : function(result) {
				if(result === 'SUCCESS'){
					alert(rno + "번 댓글이 수정되었습니다.");
					// 댓글 삭제 후 모달창 닫고 새 댓글목록 갱신
					$("#modDiv").hide("slow");
					getAllList();
				}
			}
		})
	});
	
	$("#closeBtn").on("click",function() {
		$("#modDiv").hide("slow");
	});
	
	// 이벤트 위임
	// 내가 현재 이벤트를 걸려는 집단(button)을 포함하면서 범위가 제일 좁은 
	// #replies로 시작조건을 잡습니다.
	// .on("click", "목적지 태그까지 요소들", function(){실행문})
	// 과 같이 위임시는 파라미터가 3개 들어갑니다.
	$("#replies").on("click", ".replyLi button", function() {
		// this는 최 하위태그인 button, button의 부모면 결국 .replyLi
		console.log("버튼 클릭.");
		var replyLi = $(this).parent();
		
		// .attr("속성명")을 하면 해당 속성의 값을 얻습니다.
		var rno = replyLi.attr("data-rno");
		var reply = replyLi.children(".replytext").text();
		// 버튼의 부모(replyLi)의 자식(.reply) div class="reply"의 내부텍스트만 가져옴
		
		// 클릭한 버튼에 해당하는 댓글번호 + 본문이 얻어지나 디버깅
		console.log(rno+ ":"+ reply);
		
		$(".modal-title").html(rno);// 여기서 .modal-title에 rno를 넣어주고 있는데 안나와요.
		$("#replytext").val(reply);
		$("#modDiv").show("slow");
	});
	
	var bno = ${board.bno};
	
	function getAllList() {
					
				
				$.getJSON("/replies/all/" + bno, function(data){
					console.log(data);
					
					// str 변수 내부에 문자 형태로 html 코드를 작성
					var str ="";
					
					str = "<li>123</li>";
					
					//#replies인 ul태그 내부에 str을 끼워넣음
					// ul 내부에 <li>123</li>를 추가하는 구문
					
					$(data).each(function(){
						// $(data).each()는 향상된 for문 처럼 내부데이터를 하나하나 반복합니다.
						// 내부 this는 댓글 하나하나 입니다. 
						console.log(this.rno + "/" +this.reply);
						console.log("------------");
					});
					
					var str = "";
					$(data).each(
							function() {
								// $(data).eacj()는 향상된 for문처럼 내부데이터를 하나하나 반복합니다.
								// 내부 this는 댓글 하나하나입니다.
								// 시간 형식을 우리가 쓰는 형식으로 변경
								var timestamp = this.updateDate;
								var date = new Date(timestamp);
								
								// date만으로도 시간표시는 우리가 아는 형태로 할 수 있지만 보기 불편함
								
								// date 내부의 시간을 형식화 해서 출력
								var formattedTime = "게시일 : " + date.getFullYear()
													+ "/" + (date.getMonth()+1) //month는 0월부터 시작하므로 1 더해줘
													+ "/" + date.getDate() // 날짜 추출 
													+ "/" + date.getHours() // 시간 추출
													+ ":" + date.getMinutes() // 분 추출
													
								// this.updateDate를 표출하면 시간이 unix 시간으로 표시됨
								// 아까는 저기 data-rno = 에서 =이 빠져서 속성지정이 이상하게 되어있었습니다.
								// 어제까지만해도 됐는데 언제 제가 잘못 건들였나봅니다 
								str+="<div class='replyLi' data-rno='" + this.rno + "'><strong>@"
								+ this.replyer + "</strong> - " + formattedTime + "<br>"
								+ "<div class = 'replytext'>" + this.reply + "</div>"
								+ "<button type='button' class = 'btn btn-info'>수정/삭제</button>"
								+ "</div>";
								
							});
					$("#replies").html(str);
				});
				
				}
	getAllList();
	
	
	</script>
	
</body>

<script type="text/javascript">

		// 컨트롤러에서 m_success라는 이름으로 날린 자료가 들어오는지 확인
		// 그냥 list 페이지 접근시는 m_success를 날려주지 않아서
		// 아무것도 들어오지 않고
		// modify로직의 결과로 넘어왔을 때만 데이터가 전달됨 
		var result = "${m_success}";
		
		console.log(result);
		
		if(result==="m_success") {
			alert('글 수정 완료');
		}
			
		
	</script>
</html>
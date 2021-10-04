<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>

	<h2>Ajax 테스트</h2>
	<ul id="replies">
	
	</ul> 
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

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script>
		
			
				var bno = 8;
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
							getAllList();
						}
					}
					
				})
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
				var reply = replyLi.text(); // li 태그 내부 글씨만 얻기.
				
				// 클릭한 버튼에 해당하는 댓글번호 + 본문이 얻어지나 디버깅
				console.log(rno+ ":"+ reply);
				
				$(".modal-title").html(rno);
				$("#replytext").val(reply);
				$("#modDiv").show("slow");
			});
			
			
			
			getAllList();
			
			function getAllList() {
				
			
			$.getJSON("/replies/all/" + bno, function(data){
				console.log(data.length);
				
				
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
							str+= "<li data-rno='" + this.rno + "' class='replyLi'>"
								+ this.rno+ ":" + this.reply
								+ "<button>수정/삭제</button></li>";
							
						});
				
				$("#replies").html(str);
			});
			
			}
		</script>
</body>
</html>
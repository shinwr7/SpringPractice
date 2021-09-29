<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
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
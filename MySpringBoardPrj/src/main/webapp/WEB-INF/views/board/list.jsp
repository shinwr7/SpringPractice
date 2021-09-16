<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var result = "${result}"
		alert.(result+'번 글이 작성되었습니다.')
		
	
</script>
</head>
<body>
		
	<div class="panel panel-default ">
  <!-- Default panel contents -->
  <div class="panel-heading">게시물 목록</div>
  <div class="panel-body">
    <p>list 이름으로 보낸 boardList 나열</p>
  </div>
 
	  <table class="table table-hover" style="width:1000px">
	    <tr class ="p-3 mb-2 bg-primary text-white">
	    	<th>글번호</th>
	    	<th>글제목</th>
	    	<th>글쓴이</th>
	    	<th>쓴날짜</th>
	    	<th>최종수정일</th>
	    </tr>
		<c:forEach var="board" items="${list }">
		<tr>
			<td>${board.bno }</td>
			<td onclick="location.href='/board/get?bno=${board.bno}'">${board.title }</td>
			<td>${board.writer }</td>
			<td>${board.regdate }</td>
			<td>${board.updatedate }</td>
		</tr>
		
	
	  <!-- Table -->
		</c:forEach>
	  </table>
	</div>
  	<button type="button" class="btn btn-primary" onclick="location.href='/board/register'">글쓰기</button>
		  
		
		
</body>
</html>
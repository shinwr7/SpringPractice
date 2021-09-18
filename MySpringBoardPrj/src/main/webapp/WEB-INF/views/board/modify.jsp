<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/board/modify" method="post">
			
		<ul>
			<li>글번호<input type="text" name="bno" value="${board.bno }" readonly></li>
			<li>제목<input type="text" name="title" value="${board.title }" required></li>
			<li>본문<textarea rows="10" cols="50" name="content" required>${board.content }</textarea></li>
			<li>글쓴이<input type="text" name="writer" value="${board.writer }" readonly></li>
			<li><input type="submit">
			<input type="reset"></li>
		</ul>
	
	</form>
</body>
</html>



















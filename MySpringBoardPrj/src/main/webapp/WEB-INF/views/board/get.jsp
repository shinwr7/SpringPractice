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
	<button type="button" class="btn btn-primary" onclick="location.href='/board/list'">돌아가기</button>
	
</body>
</html>
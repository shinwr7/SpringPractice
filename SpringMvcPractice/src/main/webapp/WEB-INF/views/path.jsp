<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	${page} 페이지 조회중입니다.
	
	<!-- jstl을 활용해서 page 가 100 미만이면 하단에 h2태그를 이용해서
	"초반부입니다", 100이상 200미만이면 "중반부입니다.", 200이상이면 "후반부입니다."
	라는 문장을 추가로 출력해보세요. -->
	
	<c:if test="${page<100}">
		<h2>초반부입니다.</h2>
	</c:if>
	<c:if test="${page>=100 && page <200}">
		<h2>중반부입니다.</h2>
	</c:if>
	<c:if test="${page>=200}">
		<h2>후반부입니다.</h2>
	</c:if>
</body>
</html>
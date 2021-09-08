<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<form action="/bmi" method="post">
		<h1>키와 체중을 입력하세요.</h1>
		키 : <input type="text" name="height" placeholder="CM">cm<br/>
		체중 : <input type="text" name="weight" placeholder="KG">kg<br/>
		<input type="submit">
	</form>
</body>
</html>
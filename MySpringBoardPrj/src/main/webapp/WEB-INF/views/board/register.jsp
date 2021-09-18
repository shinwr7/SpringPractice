<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script>
	

</script>
<style>
	ul{
		list-style:none;
	}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>게시물 입력 창</h1>
	<form action="/board/register" method="post">
		<ul>
			<li>제목<input type="text" name="title"></li>
			<li>본문<textarea rows="10" cols="50" name="content"></textarea></li>
			<li>글쓴이<input type="text" name="writer"></li>
			<li><input type="submit">
			<input type="reset"></li>
		</ul>
	</form>
</body>
</html>
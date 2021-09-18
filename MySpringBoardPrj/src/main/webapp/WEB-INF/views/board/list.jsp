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
</head>
<style>
	body{width : 1000px}
	  .navbar .navbar-form {
        width: 185px;
        padding-left:0;
        padding-right:0;
    }
	.navbar .navbar-form {
    padding-top: 0;
    padding-bottom: 0;
    margin-right: 0;
    margin-left: 0;
    border: 0;
    -webkit-box-shadow: none;
    box-shadow: none;
}
</style>
<body>

	<div class="panel panel-default ">
  <!-- Default panel contents -->
  <div class="panel-heading">게시물 목록</div>
  <div class="panel-body">
  </div>
 <!-- 검색창 -->
 <div class="navbar navbar-inverse navbar-fixed-top" style="width:1000px">
   <div class="container">
      <div class="navbar-header">
     
         <form action="/board/list" method="get" class="navbar-form pull-left" role="search">
            <div class="input-group">
               <input type="text" name="keyword" placeholder="검색" value="${keyword_ok }"  class="form-control">
               <div class="input-group-btn">
                  <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
               </div>
            </div>
         </form>
      </div>
   </div>
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
		</c:forEach>
	  <!-- Table -->
	  </table>
	</div>
  	<button type="button" class="btn btn-primary" onclick="location.href='/board/register'">글쓰기</button>
	
	<script type="text/javascript">
		// 컨트롤러에서 success라는 이름으로 날린 자료가 들어오는지 확인
		// 그냥 list 페이지 접근시는 success를 날려주지 않아서
		// 아무것도 들어오지 않고
		// remove로직의 결과로 넘어왔을 때만 데이터가 전달됨 
		var result = "${success}";
		var bno = "${bno}";
		var keyword_ok = "검색";
		console.log(result);
		
		if(result==="success"&&bno!=null) {
			alert(${bno}+'번 글 삭제 완료');
		}
		
		
	</script>
		
		
</body>
</html>
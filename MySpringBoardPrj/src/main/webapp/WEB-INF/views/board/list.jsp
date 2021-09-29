<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 합쳐지고 최소화된 최신 CSS -->
<!DOCTYPE html>
<html>
<head>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

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
${btnMaker }
<div class="panel panel-default ">
  <!-- Default panel contents -->
  <div class="panel-heading">게시물 목록</div>
  <div class="panel-body">
  </div>
</div>
<div class="container">
	<div class="row">
		<h1 class="text-primary text-center">전체 글 목록</h1>
	</div>
	<div class="row">
		<div class="box-body">
	 <div class="navbar navbar-inverse navbar-fixed-top" style="width:1000px">
	   <div class="container">
	      <div class="navbar-header">
	     
	         <form action="/board/list" method="get" class="navbar-form pull-left" role="search">
			<select name="searchType">
			<!-- option value => 백으로 전달되는 값 
				c:out value => 웹으로 출력되는 값 -->
				<option value="n"
				<c:out value="${cri.searchType == null ? 'selected' : '' }"/>>-</option>
				<option value="t"
				<c:out value="${cri.searchType eq 't' ? 'selected' : '' }"/>>제목</option>
				<option value="c"
				<c:out value="${cri.searchType eq 'c' ? 'selected' : '' }"/>>본문</option>
				<option value="w"
				<c:out value="${cri.searchType eq 'w' ? 'selected' : '' }"/>>글쓴이</option>
				<option value="tc"
				<c:out value="${cri.searchType eq 'tc' ? 'selected' : '' }"/>>제목본문</option>
				<option value="cw"
				<c:out value="${cri.searchType eq 'cw' ? 'selected' : '' }"/>>본문글쓴이</option>
				<option value="tcw"
				<c:out value="${cri.searchType eq 'tcw' ? 'selected' : '' }"/>>제목본문글쓴이</option>
			</select>
			<!-- 검색창 -->
	            <div class="input-group">
	               <input type="text" name="keyword" placeholder="검색" value="${keyword_ok }"  class="form-control">
	               <div class="input-group-btn">
	                  <button type="submit" class="btn btn-default">검색</button>
	               </div>
	            </div>
	         </form>
	      </div>
	   </div>
	</div>
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
			<td onclick="location.href='/board/get?pageNum=${btnMaker.cri.pageNum }&bno=${board.bno}&searchType=${btnMaker.cri.searchType }&keyword=${btnMaker.cri.keyword }'">${board.title }</td>
			<td>${board.writer }</td>
			<td>${board.regdate }</td>
			<td>${board.updatedate }</td>
		</tr>
		</c:forEach>
	  <!-- Table -->
	  </table>
	  <nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
  	<!-- prev 버튼 -->
  	<c:if test="${btnMaker.prev }">
    	<li class="page-item"><a class="page-link" href="/board/list?pageNum=${btnMaker.startPage-1}&searchType=${btnMaker.cri.searchType }&keyword=${btnMaker.cri.keyword }">Previous</a></li>
    </c:if>
    <!-- 번호 버튼 
    c 태그의 forEach기능을 쓰되, begin, end 속성을 이용해서 
    startPage부터 endPage까지의 숫자들이 버튼으로 나열되게 만들어주세요.
    현재 보고있는 페이지 강조는 class 속성 내에서 삼항연산자를 이용해도 좋다 -->
    
    <c:forEach var="pageBtn" begin="${btnMaker.startPage }" end="${btnMaker.endPage }">
   		 <li class="page-item ${btnMaker.cri.pageNum == pageBtn ? 'active' : '' }"><a class="page-link" href="/board/list?pageNum=${pageBtn }&searchType=${btnMaker.cri.searchType }&keyword=${btnMaker.cri.keyword }">${pageBtn}</a></li>
    	<c:if test="${cri.pageNum eq pageBtn}">
    		
    	</c:if>
    </c:forEach>
    <!-- next 버튼 -->
    <c:if test="${btnMaker.next }">
    	<li class="page-item"><a class="page-link" href="/board/list?pageNum=${btnMaker.startPage+10 }&searchType=${btnMaker.cri.searchType }&keyword=${btnMaker.cri.keyword }">Next</a></li>
    </c:if>
  </ul>
</nav>
  	<button type="button" class="btn btn-primary" onclick="location.href='/board/register'">글쓰기</button>
	
	
	<!-- 모달 코드는 작성이 안되어있는게 아니고 
	작성은 해뒀지만 css의 display 속성을 none으로 평상시에 두고 
	특정한 요건을 만족했을때만 display를 허용하도록 설계되어있다.
	그래서 아래와 같이 모달 예시코드를 붙여넣어도 일반 화면에서는 보이지 않는다. -->
<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알림</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>${bno }번 글 작성완료</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
	<script type="text/javascript">
		// 컨트롤러에서 success라는 이름으로 날린 자료가 들어오는지 확인
		// 그냥 list 페이지 접근시는 success를 날려주지 않아서
		// 아무것도 들어오지 않고
		// remove로직의 결과로 넘어왔을 때만 데이터가 전달됨 
		var result = "${success}";
		var bno = "${bno}";
		var keyword_ok = "검색";
		
		// 모달 사용 위한 변수 선언
		// 모달 공식문ㅅ의 자바스크립트 관련 실행 코드를 복사
		var myModal = new bootstrap.Modal(document.getElementById('myModal'), focus);
		var myInput = document.getElementById('myInput');

		console.log(result);
		
		if(result==="success"&&bno!=null) {
			alert(${bno}+'번 글 삭제 완료');
		}
		else if(result==="register"&&bno!=null) {
			myModal.show();
			
		}
		
		
	</script>
		
		
</body>
</html>
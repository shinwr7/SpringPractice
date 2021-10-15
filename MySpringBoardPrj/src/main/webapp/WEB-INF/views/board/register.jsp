<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
			<li><input type="submit" id="submitBtn">
			<input type="reset"></li>
		</ul>
	</form>
	
	<h1>Upload with Ajax </h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	
	<div class='uploadResult'>
		<ul>
			<!-- 업로드된 파일이 들어갈 자리 -->
		</ul>
	</div>
	
	<button id="uploadBtn">Upload</button>
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
	
	
		$(document).ready(function(){
			
			let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			let maxSize = 5242880 // 5MB
			
			function checkExtension(fileName, fileSize) {
				if(fileSize >= maxSize) {
					alert("파일 사이즈 초과");
					return false;
				}
				
				if(regex.test(fileName)) {
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
			// 업로드 파일 선택을 초기화시키기 위해 미리 비어있는
			// .uploadDiv를 깊은 복사해둠
			let cloneObj = $('.uploadDiv').clone();
			
			
		$('#uploadBtn').on("click", function(e){
			
				// ajax는 제출버튼을 눌렀을때 목적지가 없기 떄문에
				// 빈 폼을 만들고 거기에 정보를 채워넣어야 함
			let formData = new FormData();
			
			let inputFile = $("input[name='uploadFile']");
			
			console.log(inputFile);
			
			let files= inputFile[0].files;
			
			console.log(files);
	
			// 파일 데이터를 폼에 집어넣기
			for(let i =0; i<files.length; i++){
				console.log("checkExtension 진입전");
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			console.log("폼데이터 확인");
			console.log(formData);
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData : false,
				contentType: false,
				data : formData,
				type : 'POST',
				dataType:'json', // 입력시 json으로 콘솔에, 안입력하면 xml로 콘솔에 찍힘
				success : function(result){
					console.log(result); // 내가 업로드한 파일 내역이 콘솔에 찍히나 디버깅
					alert("Uploaded");
					// 업로드된 그림파일 목록을 ul내부에 리스트로 입력
					showUploadedFile(result);
					
					// 세팅되어있던 파일이 업로드되면서 목록에서 사라지게 처리
					$(".uploadDiv").html(cloneObj.html());
				}
			});
			
			}); // onclick uploadBtn
		
			
		let uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {
			
			let str = "";
			
			// i는 인덱스번호(0, 1, 2, 3..) obj가 그림파일 정보가 담긴 json
			$(uploadResultArr).each(function(i, obj) {
				console.log("--------------");
				console.log(i);
				console.log(obj);
				console.log("--------------");
				
				if(!obj.image){
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + 
							obj.uuid + "_"+ obj.fileName);
					
					str += "<li "
						+"data-path='"+obj.uploadPath + "'data-uuid='" + obj.uuid
						+"' data-filename='" + obj.fileName + "' data-type='" + obj.image
						+"'><a href='/download?fileName=" + fileCallPath +"'>" + "<img src='/resources/attachment.png'>"
						+ obj.fileName + "</a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='file'> X </span>"
						+ "</li>";
						console.log("str : " + str);
				} else {
				// str+= "<li>" + obj.fileName + "</li>";
				// 파일이름 + 썸네일을 보여주기 위해 썸네일 주소 요청하게 만들기
		
				let fileCallPath = encodeURIComponent(obj.uploadPath + "//s_" + 
														obj.uuid + "_"+ obj.fileName);
				
				let fileCallPath2 = encodeURIComponent(obj.uploadPath + "/" +
														obj.uuid + "_"+ obj.fileName);
				
				str +="<li "
					+"data-path='"+obj.uploadPath + "'data-uuid='" + obj.uuid
					+"' data-filename='" + obj.fileName + "' data-type='" + obj.image
					+"'><a href='/download?fileName=" + fileCallPath2 + "'>"+"<img src='/display?fileName="+fileCallPath+"'></a>"
						+ "<span data-file=\'" + fileCallPath + "\' data-type='image'> X </span>"
						+ "</li>";
				console.log("obj.fileName : " +obj.fileName );
				
				}
			});
			
			uploadResult.append(str);
			
		}
	$(".uploadResult").on("click", "span", function(e){
		let targetFile = $(this).data("file");
		let type=$(this).data("type");
		
		let targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName : targetFile, type:type},
			dataType: 'text',
			type: 'POST',
			success: function(result){
				alert(result);
				targetLi.remove();
			}
		}); // ajax
	}); //click span
	
	$("#submitBtn").on("click", function(e) {
		
		// 클릭된 요소의 동작 중지(제출버튼인 경우 버튼 눌러도 제출 안됨)
		// 글쓰기를 했을 때 , 그림이 몇장 추가될지는 글을 써봐야 알 수 있음
		// 제출을 바로 하지 못하도록 막음
		e.preventDefault();
		
		// 위의 form에 업로드된 그림요소들에 대한 정보를 추가합니다.
		// 1. form 태그 정보 얻기
		// 상단 form태그에 이미지 관련 정보를 hidden으로 추가하기 위해 얻어옴
		let formObj = $("form");
		
		// 2. 추가 내용을 먼저 받기 위해 빈 문자열 생성 
		let str ="";
		
		// 3. .uploadResult 내부에 들어간 그림정보를 얻어와서 
		// formObj내부에 넣어주기
		// .uploadResult내부 ul 내부의 li가 그림정보를 담고있으므로
		$(".uploadResult ul li").each(function(i, obj) {
			
			let imgInfo = $(obj);
			console.log(imgInfo);
			
			// BoardVO 내부의 List<BoardAttachVO>를 처리하기 위해 변수명 attachList로 전달
			str += "<input type='hidden' name='attachList[" + i + "].fileName'"
				+ " value='" + imgInfo.data("filename") + "'>" 
				+ "<input type='hidden' name='attachList[" + i + "].uuid'"
				+ " value='" + imgInfo.data("uuid") + "'>" 
				+ "<input type='hidden' name='attachList[" + i + "].uploadPath'"
				+ " value='" + imgInfo.data("path") + "'>" 
				+ "<input type='hidden' name='attachList[" + i + "].image'"
				+ " value='" + imgInfo.data("type") + "'>" 
		});
		// 반복이 끝나면, formObj에 위 태그들을 추가한 다음 제출합니다.
		
		formObj.append(str).submit();
		// 그림정보가 잘 추가되는지 디버깅
		console.log($(formObj));
		
		
		
		
		
		
	})
	
	
	
	
	});
		
	
</script>
</body>
</html>
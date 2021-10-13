<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Upload with Ajax</h1>
	
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
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
				success : function(result){
					alert("Uploaded");
				}
			});
			
			});
		});
	</script>
</body>
</html>
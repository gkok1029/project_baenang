<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>addPost</title>
<style>
.ck-editor__editable {
	height: 400px;
}

.ck-content {
	font-size: 12px;
}

</style>

<link href="/resources/css/styles.css" rel="stylesheet" />

<jsp:include page="../top.jsp" />
</head>
<body>

<br>
<br>
<br>
<br>

<header style="background-color: #0F46A4" class="py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="text-center text-white">

			<h1>배 낭</h1>

			<p class="lead fw-normal text-white-50 mb-0">designe your travel</p>

		</div>
	</div>
</header>

<div> <!-- 글 작성 -->
	<form action="/user/blog/addpost" method="POST" id=postForm>
		<!-- Add Title field -->
		<div style="width: 50%; margin: 0 auto;">
			<label>Title</label> <br> <input type="text" name="p_title">
		</div>
		<br>
		<!-- CKEditor for content -->
		<div style="width: 50%; margin: 0 auto;">
			<textarea name="p_content" id="editor">사진은 아래의 버튼을 통해 업로드 해주세요</textarea>
		</div>
		<br>

		<p style="width: 50%; margin: 0 auto;">
			<input type="submit" value="전송" id="uploadBtn">
		</p>
</div>
		<hr>

		<div>
			<div>
				<div class="uploadDiv">
					<input type="file" name="uploadFile" multiple>
				</div>
			</div>
		</div>

	</form>

</body>
<!-- CKEditor scripts -->
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<script>		
	ClassicEditor
	.create(document.querySelector('#editor'))
	.then(editor => {
		
		console.log('Editor was initialized');
	})
	.catch(error => {
		console.error(error);
	});
 </script>
 

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        $('#postForm').submit(function (e) {
            var title = $('input[name="p_title"]').val().trim();
            var content = $('textarea[name="p_content"]').val().trim();

            if (title === '' || content === '') {
                e.preventDefault(); // 제출 방지
                alert('제목과 내용을 입력해주세요.');
                return;
            }
            
            var uploadResult = $(".uploadResult ul");

            function showUploadedFile(uploadResultArr) {
                var str = "";
                $(uploadResultArr).each(function (i, obj) {
                    str += "<li>" + obj.fileName + "</li>";
                });
                uploadResult.append(str);
            }

            var regex = new RegExp("(.*?)\.(exe|sh|zip|7z)$");
            var maxSize = 52428880;

            function checkExtension(fileName, fileSize) {
                if (fileSize >= maxSize) {
                    alert("5MB 이하의 사진만 업로드 가능합니다.");
                    return false;
                }
                if (regex.test(fileName)) {
                    alert("해당 유형의 확장자는 업로드 할 수 없습니다.");
                    return false;
                }
                return true;
            }

            var cloneObj = $(".uploadDiv").clone();

            // 파일 업로드 코드를 제출 이벤트 핸들러 안에 넣습니다.
            var formData = new FormData();
            var inputFile = $("input[name='uploadFile']");
            var files = inputFile[0].files;

            for (var i = 0; i < files.length; i++) {
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                url: '/uploadAction',
                processData: false,
                contentType: false,
                data: formData,
                type: 'POST',
                dataType: 'json',
                success: function (result) {
                    console.log(result);
                    showUploadedFile(result);
                    $(".uploadDiv").html(cloneObj.html());
                }
            });
        });
    });
</script>
</html>

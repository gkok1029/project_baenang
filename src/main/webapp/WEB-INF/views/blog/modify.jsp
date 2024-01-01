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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">
   $(document).ready(function () {
      var formObj = $("form");

      $('button').on("click", function (e) {
         e.preventDefault();

         var operation = $(this).data("oper");
         console.log(operation);

         if (operation === 'remove') {
            formObj.attr("action", "/blog/remove");
         } else if (operation === 'list') {
            window.location.href = "/blog/bloghub";
            return;
         }
         formObj.submit();
      });
   });
</script>

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

	<div>
		<!-- 글 수정 -->
		<form action="/blog/addpost" method="POST" id=postForm>
			<!-- Add Title field -->
			<div style="width: 50%; margin: 0 auto;">
				<label>Title</label> <br> <input type="text" name="p_title">
			</div>
			<br>
			<!-- CKEditor for content -->
			<div style="width: 50%; margin: 0 auto;">
				<textarea name="p_content" id="editor"></textarea>
			</div>
			<br>

			<p style="width: 50%; margin: 0 auto;">
				<input type="submit" value="전송" id="uploadBtn">
			</p>
	</div>
	<hr>

	<!-- <div>
		<div>
			<div class="uploadDiv">
				<input type="file" name="uploadFile" multiple>
			</div>
		</div>
	</div> -->

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

<%-- <div class="form-group">
                  <label>작성일</label> <input class="form-control" name='p_credate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${post.p_credate}"/>'>
               </div> --%>

<%-- <div class="form-group">
                  <label>수정일</label> <input class="form-control" name='p_moddate' value='<fmt:formatDate pattern="yyyy-MM-dd" value="${post.p_moddate}"/>'>
               </div> --%>

<button type="submit" data-oper='modify' class="btn btn-default">이
	게시물 수정완료</button>
<button type="submit" data-oper='remove' class="btn btn-danger">이
	게시물 지우기</button>
<button data-oper='list' class="btn btn-info">List</button>
</form>
</div>
</div>
</div>
</div>
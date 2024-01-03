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

<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

<script type="text/javascript">

$('button[data-oper="modify"]').on("click", function (e) {
    e.preventDefault();

    var operation = $(this).data("oper");
    console.log(operation);

    if (operation === 'modify') {
        // hidden input에 값을 설정
        $('input[name="p_id"]').val(${post.p_id});

        // 폼 서브밋
        formObj.attr("action", "/user/blog/modify");
    } else if (operation === 'remove') {
        formObj.attr("action", "/user/blog/remove");
    } else if(operation === 'list') {
        window.location.href = "/user/blog/bloghub";
        return;
    }
    formObj.submit();
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

	<form role="form" action="/user/blog/modify" method="POST">
		<div>
			<!-- 글 수정 -->

			<!-- Add Title field -->
			<div  style="width: 50%; margin: 0 auto;" class="form-group">
				<label>게시물 번호</label> <input class="form-control" name='p_id'
					value='<c:out value="${post.p_id}"/>' readonly="readonly">
			</div>

			<input type="hidden" name="p_id" value="${post.p_id}">


			<div  style="width: 50%; margin: 0 auto;" class="form-group">
				<label>제목</label> <input class="form-control" name='p_title'
					value='<c:out value="${post.p_title}"/>'>
			</div>
			<br>
			<!-- CKEditor for content -->
			<div style="width: 50%; margin: 0 auto;">
				<textarea name="p_content" id="editor"><c:out
						value="${post.p_content}" /></textarea>
			</div>
			<br>

			<!-- <p style="width: 50%; margin: 0 auto;">
				<input type="submit" value="전송" id="uploadBtn">
			</p> -->
			<hr>
			<div  style="width: 50%; margin: 0 auto;">
			<button type="submit" data-oper='modify' class="btn btn-info">수정완료</button>
			<%-- <button class="btn btn-danger"
										onclick="location.href='/blog/remove?p_id=<c:out value="${post.p_id}"/>'">삭제</button> --%>
			<button data-oper='list' class="btn btn-info">List</button></div>
			
		</div>
	</form>
		
		

		<!-- <div>
		<div>
			<div class="uploadDiv">
				<input type="file" name="uploadFile" multiple>
			</div>
		</div>
	</div> -->
		

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
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


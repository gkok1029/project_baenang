<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		let operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/blog/modify");
			operForm.submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.find("#p_id").remove();
			operForm.attr("action", "/blog/bloghub");
			operForm.submit();
		});
	});
</script>

<style>
.panel-body {
	width: 50%;
	margin: 0 auto;
}

.form-group {
	margin-top: 20px;
	margin-bottom: 20px;
}

.form-group input, .form-group textarea {
	border: none;
	border-bottom: 1px solid #ccc;
}

.readonly-text {
	padding: 10px;
	border: 1px solid #ccc;
	background-color: white;
	height: auto;
	min-height: 200px;
	overflow: auto;
	border-radius: 10px;
}
</style>

<link href="/resources/css/styles.css" rel="stylesheet" />

<jsp:include page="../top.jsp" />

<title><c:out value="${post.p_title}" /></title>

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<div style="background-color: #0F46A4" class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">get post</div>

			<div class="panel-body">
				<div class="form-group">
					<input class="form-control" name='p_id'
						value='<c:out value="${post.p_id}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Title</label> <input class="form-control" name='p_title'
						value='<c:out value="${post.p_title}"/>' readonly="readonly">
				</div>

<div style="background-color: #52DCD1" class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">get post</div>

			<div class="panel-body">
				<div class="form-group">
					<label>게시물 번호</label> <input class="form-control" name='p_id' value='<c:out value="${post.p_id}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>제목</label> <input class="form-control" name='p_title' value='<c:out value="${post.p_title}"/>' readonly="readonly">
				</div>

				<div class="form-group" >
					<label></label> <textarea class="form-control" rows="20" name='p_content' readonly="readonly"><c:out value="${post.p_content}"/></textarea>
				</div>



				<div class="content">
					<div class="readonly-text">${post.p_content}</div>

					<c:if test="${not empty post.uploadedImages}">
						<div>
							<h4>Uploaded Images:</h4>
							<c:forEach items="${post.uploadedImages}" var="imagePath">
								<img src="${imagePath}" alt="Uploaded Image"
									style="max-width: 100%; border-radius: 5px; margin-top: 10px;">
							</c:forEach>
						</div>
					</c:if>
				</div>

				<br>
				<hr>

				<button data-oper='modify' class="btn btn-default">이
					게시물수정하기</button>
				<button data-oper='list' class="btn btn-info">List</button>

				<br>
				<hr>
				<br>

			</div>

		</div>

	</div>
</div>
				<button data-oper='modify' class="btn btn-default">이 게시물 수정하기</button>
				<button data-oper='list' class="btn btn-info">List</button>


			</div>

		</div>

	</div>
</div>


<br>
<br>
<br>

<div>
	<!-- 리플 공간 -->
	<div style="text-align: center;">
		<!-- 리플 출력 -->
		<ul style="list-style: none; padding: 0;">
			<c:forEach items="${reply}" var="reply">
				<li
					style="margin: 30px auto; display: flex; justify-content: center; align-items: center;">
					<!-- 프로필 사진을 위한 원 -->
					<div
						style="width: 50px; height: 50px; border-radius: 50%; background-color: #ccc; margin-right: 10px;"></div>

					<div style="margin: 30px;">
						<p>${reply.m_id}/${reply.m_nname}/${reply.r_credate} /
							${reply.r_moddate}</p>
						<p>${reply.r_content }</p>
						<hr>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
	<div style="text-align: center;" class="form-group">
		<form method="post" action="/replies/write">
			<!-- <p>
				<label>댓글 작성자</label> <input type="text" name="writer">
			</p> -->
			<p>
				<textarea rows="5" cols="50" name="r_content"></textarea>
			</p>
			<p>
				<input type="hidden" name="p_id" value="${post.p_id}">
				<button type="submit">댓글 작성</button>
			</p>
		</form>
	</div>
</div>
<br>
<br>
<br>
<hr>

<div></div>
<h1>다른 게시물들</h1>
<div>
	<!-- 카드 포스트 리스팅 -->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

				<c:forEach items="${posts}" var="post">
					<div class="col mb-5">
						<div class="card h-100">
							<a href='/blog/get?p_id=<c:out value="${post.p_id}"/>'> <img
								class="card-img-top"
								src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />

								<div class="card-body p-4">
									<div class="text-center">

										<h5 class="fw-bolder">
											<c:out value="${post.p_title}" />
										</h5>

										<c:out value="${post.m_id}" />
									</div>
								</div>
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
</div>
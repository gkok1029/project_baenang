<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

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
	width: 60%;
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
	min-height: 300px;
	overflow: auto;
	border-radius: 10px;
}

.image-container {
	max-width: 100%; /* 이미지 컨테이너의 최대 너비를 100%로 설정하여 부모 요소에 맞게 조정 */
	max-height: 100%; /* 높이를 자동으로 조정하여 이미지의 원래 비율을 유지 */
	overflow: hidden; /* 필요한 경우 이미지를 컨테이너 내에 자동으로 숨김 */
}
</style>

<link href="/resources/css/styles.css" rel="stylesheet" />

<jsp:include page="../top.jsp" />

<title><c:out value="${post.p_title}" /></title>

<br>
<br>
<br>
<br>

<header style="background-color: #0F46A4" class="py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="text-center text-white">

			<h1>B A E N A N G</h1>

			<p class="lead fw-normal text-white-50 mb-0">designe your travel</p>

		</div>
	</div>
</header>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">


			<div class="panel-body">
				<div class="form-group">
					<label>작성자</label><input class="form-control" name='m_nname'
						value='<c:out value="${post.m_nname}"/>' readonly="readonly">
				</div>

				<div class="form-group">
					<label>Title</label> <input class="form-control" name='p_title'
						value='<c:out value="${post.p_title}"/>' readonly="readonly">
				</div>

				<div class="row">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">

								<div class="panel-body">
									<div class="form-group">
										<label>게시물 번호</label> <input class="form-control" name='p_id'
											value='<c:out value="${post.p_id}"/>' readonly="readonly">
									</div>

									<div class="form-group">
										<label>작성일</label> <input class="form-control" name='p_id'
											value='<c:out value="${post.p_credate}"/>'
											readonly="readonly">
									</div>
									<div class="form-group">
										<label>수정일</label> <input class="form-control" name='p_id'
											value='<c:out value="${post.p_moddate}"/>'
											readonly="readonly">
									</div>

									<div class="form-group">
										<label>제목</label> <input class="form-control" name='p_title'
											value='<c:out value="${post.p_title}"/>' readonly="readonly">
									</div>

									<div class="content">

										<div class="readonly-text">
											<div class="image-container">
												<img alt="" src="/resources/postImage/${post.i_name}">
											</div>
											${post.p_content}
										</div>
									</div>

									<br>
									<hr>

									<button data-oper='modify' class="btn btn-info"
										onclick="location.href='/blog/modify?p_id=<c:out value="${post.p_id}"/>'">수정</button>
									<button data-oper='list' class="btn btn-info"
										onclick="location.href='/blog/bloghub'">List</button>

									<a href="/blog/remove?p_id=36">Remove Post 36</a> <br>
									<hr>
									<br>

								</div>

							</div>

						</div>
					</div>

				</div>

			</div>

		</div>
	</div>


	<br> <br> <br>

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
							style="width: 50px; height: 50px; border-radius: 50%; background-color: #ccc; margin-right: 10px;">
							<img alt="" src="/resources/profile/${reply.m_image}">
						</div>

						<div style="margin: 30px;">
							<p>${reply.m_id}/${reply.m_nname}/${reply.r_credate}/
								${reply.r_moddate} /</p>
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
	<br> <br> <br>
	<hr>

	<div></div>
	<h1>다른 게시물들</h1>
	<div>
		<!-- 카드 포스트 리스팅 -->
		<section class="py-5">
			<div class="container px-4 px-lg-5 mt-5">
				<div
					class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

					<c:forEach items="${posts}" var="post" begin="0" end="7">
						<div class="col mb-5">
							<div class="card h-100">
								<a href='/blog/get?p_id=<c:out value="${post.p_id}"/>'> <c:if
										test="${not empty post.i_name}">
										<!-- If there is an image, display it -->
										<img class="card-img-top" alt=""
											src="/resources/postImage/${post.i_name}">
									</c:if> <c:if test="${empty post.i_name}">
										<!-- If there is no image, display a default image -->
										<img class="card-img-top" alt=""
											src="/resources/postImage/defaultimage.png">
									</c:if>
									<div class="card-body p-4">
										<div class="text-center">
											<h5 class="fw-bolder">
												<c:out value="${post.p_title}" />
											</h5>
											<c:out value="${post.m_nname}" />
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

	<div></div>
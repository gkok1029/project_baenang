<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>posts</title>
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/css/styles.css" rel="stylesheet" />
</head>
<body>
	<jsp:include page="../top.jsp" />
	<!-- Navigation-->
	<!-- <nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="/main">배낭</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/main">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="/plan">Planning</a></li>
				</ul>
				<form class="d-flex">
					<button class="btn btn-outline-dark" type="submit">
						<i></i> MyPage 
						<span class="badge bg-dark text-white ms-1 rounded-pill" href="/myPage"></span>
					</button>
				</form>
			</div>
		</div>
	</nav> -->
	<!-- Header-->
	<br><br><br><br>
	<header style="background-color: #52DCD1" class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<div id="search_block">
					<form action="/plan" method="GET">

						<input type="text" id="search-box" name="search"
							placeholder="포스트를 검색하세요" class="form-control dropdown-toggle"
							data-toggle="dropdown" aria	-haspopup="true"
							aria-expanded="false" oninput="onKeywordInput()">
							
					</form>
				</div>
				<p class="lead fw-normal text-white-50 mb-0"><c:out value="${member.m_nname}" />의 포스트</p>
				
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">기간별
						트렌드</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="bloghub30days">30일</a></li>
						<li><a class="dropdown-item" href="bloghub7days">7일</a></li>
						<li><a class="dropdown-item" href="bloghub">오늘</a></li>
					</ul>
				</li>
				<a href="bloghub"><button class="btn btn-info"> 모든 포스트</a>
				<a href="userposts"><button class="btn btn-info"> 내 포스트</a>
				<a href="addpost"><button class="btn btn-info"> 포스트 작성</a>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

				<c:forEach items="${posts}" var="post">
					<div class="col mb-5">
						<div class="card h-100">
							<a href='/blog/get?p_id=<c:out value="${post.p_id}"/>' /> <img
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
							<!-- Product actions-->
							<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
								<div class="text-center">
									<a class="btn btn-outline-dark mt-auto" href="#">View
										options</a>
								</div>
							</div>
							</a>
						</div>
					</div>
				</c:forEach>


			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2023</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/resources/js/scripts.js"></script>
</body>
</html>
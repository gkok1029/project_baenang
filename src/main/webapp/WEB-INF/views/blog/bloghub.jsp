<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="java.io.File" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.bn.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>여행엽서</title>
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/resources/css/styles.css" rel="stylesheet" />

</head>
<body>
	<jsp:include page="../top.jsp" />
	
	
	<br><br><br><br>
	<header style="background-color: #0F46A4" class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1> B A E N A N G </h1>
				<p class="lead fw-normal text-white-50 mb-0">designe your travel</p>
				
				<!-- <li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">기간별트렌드</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="bloghub30days">30일</a></li>
						<li><a class="dropdown-item" href="bloghub7days">7일</a></li>
						<li><a class="dropdown-item" href="bloghub">오늘</a></li>
					</ul>
				</li>
				<a href="mylikes"> <button class="btn btn-info"> 좋아하는 포스트 </a>
				<a href="userposts"> <button class="btn btn-info"> 내 포스트 보기 </a> -->
				<br>
				
				<a href="addpost"> <button class="btn btn-info"> 엽서쓰기 </a>
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
							<a href='/user/blog/get?p_id=<c:out value="${post.p_id}"/>' /> 
									<c:if
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
	<!-- Footer-->
	
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/resources/js/scripts.js"></script>
	
	<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
	
</body>
</html>

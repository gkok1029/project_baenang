<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/rsources/js/reply.js"></script>


<script type="text/javascript">
$(document).ready(function(){
	let operForm = $("#operForm");

	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/blog/modify").submit();
	});

	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#p_id").remove();
		operForm.attr("action", "/blog/bloghub");
		operForm.submit();
	})	
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

    .form-group input,
    .form-group textarea {
        border: none;
        border-bottom: 1px solid #ccc;
    }
</style>

<link href="/resources/css/styles.css" rel="stylesheet" />

<jsp:include page="../top.jsp" />

<title><c:out value="${post.p_title}"/></title>
<br><br><br><br><br><br><br><br><br>

<br><br>



<br>
<br>
<br>
<hr>

<div>
	<!-- 카드 포스트 리스팅 -->
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
</div>
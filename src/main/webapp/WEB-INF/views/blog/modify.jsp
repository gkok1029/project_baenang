<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
$(document).ready(function () {
    var formObj = $("form");

    $('button').on("click", function (e) {
        e.preventDefault(); // 오타 수정

        var operation = $(this).data("oper");
        console.log(operation);

        if (operation === 'remove') {
            formObj.attr("action", "/blog/remove");
        } else if (operation === 'list') {
            window.location.href = "/blog/posts";
            return;
        }
        formObj.submit();
    });
});
</script>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시물 수정</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시물 수정</div>
			
			<div class="panel-body">
				<div class="form-group">
					<label>p_id</label> <input class="form-control" name='p_id' value='<c:out value="${post.p_id}"/>'>
				</div>
				
				<div class="form-group">
					<label>Title</label> <input class="form-control" name='p_title' value='<c:out value="${post.p_title}"/>'>
				</div>
				
				<div class="form-group">
					<label>Text area</label> <textarea class="form-control" rows="3" name='p_content'><c:out value="${post.p_content}"/></textarea>
				</div>
				
				
			
				<button type="submit" data-oper='modify' class="btn btn-default">이 게시물 수정완료</button>
				<button type="submit" data-oper='modify' class="btn btn-danger">이 게시물 지우기</button>
				<button data-oper='list' class="btn btn-info">List</button>
				
				
			</div>
			
		</div>
		
	</div>
</div>
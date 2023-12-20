<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">get post</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">get post</div>
			
			<div class="panel-body">
				<div class="form-group">
					<label>p_id</label> <input class="form-control" name='p_id' value='<c:out value="${post.p_id}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>Title</label> <input class="form-control" name='p_title' value='<c:out value="${post.p_title}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>Text area</label> <textarea class="form-control" rows="3" name='p_content' readonly="readonly"><c:out value="${post.p_content}"/></textarea>
				</div>
				
				
			
				<button data-oper='modify' class="btn btn-default">Modify</button>
				<button data-oper='list' class="btn btn-info">List</button>
				
				
			</div>
			
		</div>
		
	</div>
</div>


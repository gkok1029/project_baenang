<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>addPost</title>
  <style>
    .ck-editor__editable { height: 400px; }
    .ck-content { font-size: 12px; }
  </style>
</head>
<body>

  <form action="/blog/addpost" method="POST">
    <!-- Add Title field -->
    <div style="width: 50%; margin: 0 auto;">
      <label>Title</label> <br>
      <input type="text" name="p_title"> 
    </div>
	<br>
    <!-- CKEditor for content -->
    <div  style="width: 50%; margin: 0 auto;">
      <textarea name="p_content" id="editor"></textarea>
    </div> 
    <br>

    <p style="width: 50%; margin: 0 auto;" ><input type="submit" value="전송"></p>
    
    <hr>
    
    
    
  </form>

  <!-- CKEditor scripts -->
 <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
 <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
 <script>		
	ClassicEditor
	.create(document.querySelector('#editor'))
	.then(editor => {
		ckfinder: {
			uploadUrl : '/image/upload'
		}
		console.log('Editor was initialized');
	})
	.catch(error => {
		console.error(error);
	});
 </script>
 </body>
</html>






<!-- <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>posting</title>
</head>
<body>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Posting post</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Posting post</div>
			
			<div class="panel-body">
				<form role="form" action="/blog/addpost" method="post">
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name="p_title"></input>
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name="p_content"></textarea>
					</div>
					<button type="submit" class="btn btn-default">Submit Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html> -->
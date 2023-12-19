<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>posting</title>
</head>
<body>
    <div class="row">
        <h1 class="page-header">당신은 포스팅 중입니다.</h1>
        <div class="col-lg-12">
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <form role="form" action="/blog/posting" method="post">
                        <div class="form-group">
                            <label>p_id</label>
                            <input class="form-control" name="p_id">
                        </div>
                        <div class="form-group">
                            <label>Title</label>
                            <input class="form-control" name="p_title">
                        </div>
                        <div class="form-group">
                            <label>Text here</label>
                            <textarea class="form-control" name="p_content" rows="3" cols="30"></textarea>
                        </div>
                        <button type="submit" class="btn btn-default">포스팅</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
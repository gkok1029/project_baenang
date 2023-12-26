<%@ page import="java.util.List" %>
<%@ page import="com.bn.model.CityVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>City List</title>
</head>
 <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

 <script>
	 $(document).ready(function () {
	     // 현재 페이지의 URL에서 cityId를 추출
	     var urlParams = new URLSearchParams(window.location.search);
	     var cityName = urlParams.get('cityId');
            
	  // Ajax 요청 보내기
	        $.ajax({
	            type: "GET",
	            url: "/getCityData",
	            data: { cityId: cityName },
	            success: function (data) {
	                // 받아온 데이터를 각각의 <td>에 넣기
	                $('h1').append('<td>' + data.cityId + '</td>');
	                $('table tr:last').append('<td>' + data.cityId + '</td>');
	                $('table tr:last').append('<td>' + data.cityImage + '</td>');
	                $('table tr:last').append('<td>' + data.cityIntro + '</td>');
	                $('table tr:last').append('<td>' + data.locX + '</td>');
	                $('table tr:last').append('<td>' + data.locY + '</td>');
	            },
	            error: function (error) {
	                console.error(error);
	            }
	        });
	    });
    </script>

<body>
    <h1></h1>
    <table border="1">
        <tr>
            <th>City ID</th>
            <th>City Image</th>
            <th>City Intro</th>
            <th>Location X</th>
            <th>Location Y</th>
        </tr>
        <tr>
        
        </tr>
        
        
        
    </table>
</body>
</html>

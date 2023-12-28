<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- NewFile.jsp -->

<!DOCTYPE html>
<html>
<head>
    <title>NewFile Page</title>
    <!-- jQuery를 사용하기 위한 CDN 링크 -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>

<!-- 인풋박스와 버튼 -->
<input type="text" id="keywordInput" placeholder="Enter keyword">


<!-- 결과를 표시할 곳 -->
<div id="result">
<h3 id="h0"></h3>
<h3 id="h1"></h3>
<h3 id="h2"></h3>
<h3 id="h3"></h3>
<h3 id="h4"></h3>
</div>
깃씨발새끼
<script>
    // Ajax 요청을 보내는 함수
    $("#keywordInput").on("input", function () {
    // 값이 변경될 때마다 Ajax 요청을 보냄
    sendAjaxRequest();
});
    function sendAjaxRequest() {
        // 인풋박스에서 키워드를 가져옴
        var keyword = $("#keywordInput").val();
        // Ajax 요청
        $.ajax({
            type: "POST",
            url: "/NewFile",
            data:{ keyword: keyword },
            dataType:'json',
            success: function (res){
            	for(let i=0;i<5;i++){
            	var title=res[i].title;
            	var contentid=res[i].contentid;
				$('#h'+i).text(title+contentid);
            	
            	}
				
            },
            error: function (error) {
                // 실패 시 처리
                console.error("Ajax request failed: " + error);
            }
            
        });
    }
</script>

</body>
</html>

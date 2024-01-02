<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>드래그 앤 드롭 예제</title>
    <!-- jQuery 및 jQuery UI 로드 -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
        .draggable {
            width: 100px;
            height: 50px;
            padding: 10px;
            background-color: #ccc;
            margin: 10px;
        }
        
        #dropArea {
            border: 2px dashed #aaa;
            height: 200px;
            margin: 10px;
        }
    </style>
    <script>
        $(function() {
            // 드래그 가능한 요소로 만들기
            $(".draggable").draggable({
                revert: "invalid", // 드롭 영역 밖으로 드래그한 경우 원래 위치로 돌려놓음
                cursor: "move"
            });
            
            // 드롭 영역 설정
            $("#dropArea").droppable({
                accept: ".draggable",
                drop: function(event, ui) {
                    // 드롭된 요소 처리 (서버로 전송 등)
                    var droppedElement = ui.helper.clone();
                    $(this).append(droppedElement);
                }
            }).sortable(); // 드롭된 요소들을 정렬 가능하게 만듭니다.
        });
    </script>
</head>
<body>
    <h2>드래그 앤 드롭 예제</h2>
    
    <!-- 드래그 가능한 요소 -->
    <div class="draggable">드래그 가능한 요소 1</div>
    <div class="draggable">드래그 가능한 요소 2</div>
    
    <!-- 드롭 및 드래그 가능한 영역 -->
    <div id="dropArea">
        드롭 및 드래그 가능한 영역
    </div>
</body>
</html>

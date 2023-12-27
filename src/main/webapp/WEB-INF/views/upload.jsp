<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>upload files</title>
</head>
<body>
    <h1>upload</h1>

    <div class="uploadDiv">
        <input type="file" name="uploadFile" multiple>
    </div>

    <button id="uploadBtn">upload</button>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js" 
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" 
        crossorigin="anonymous"></script>
    
    <script>
        $(document).ready(function () {
        	
        	var regex = new RegExp("(.*?)\.(exe|sh|zip|7z)$");
        	var maxSize = 52428880;
        	
        	function checkExtention(fileName, fileSize) {
				if(fileSize >= maxSize){}
				alert("5MB 이하의 사진만 업로드 가능합니다.")
				return false;
				
				if(regex.test(fileName)){
        		alert("해당 유형의 확장자는 업로드 할 수 없습니다.")
        		return false;
				}
        		return true;
        	}
        	
        	
            $("#uploadBtn").on("click", function (e) {
                var formData = new FormData();
                var inputFile = $("input[name='uploadFile']");
                var files = inputFile[0].files;
                console.log(files);

                for (var i = 0; i < files.length; i++) {
                    formData.append("uploadFile", files[i]);
                }
                	$.ajax({
                    url: '/uploadAction',
                    processData: false,
                    contentType: false,
                    data: formData,
                    type: 'POST',
                    success: function(data){
                        alert("uploaded");
                    }
                });
            });
        });
    </script>
</body>
</html>
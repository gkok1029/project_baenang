<!DOCTYPE html>
<html>
<head>
    <title>NewFile Page</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<input type="text" id="keywordInput" placeholder="Enter keyword">
<div id="result">
    <h3 id="h0"><a href="#" class="result-link" data-index="0"></a></h3>
    <h3 id="h1"><a href="#" class="result-link" data-index="1"></a></h3>
    <h3 id="h2"><a href="#" class="result-link" data-index="2"></a></h3>
    <h3 id="h3"><a href="#" class="result-link" data-index="3"></a></h3>
    <h3 id="h4"><a href="#" class="result-link" data-index="4"></a></h3>
</div>
<script>
    $(document).ready(function () {
        $("#keywordInput").on("input", function () {
            sendAjaxRequest();
        });
        function sendAjaxRequest() {
            var keyword = $("#keywordInput").val();
            $.ajax({
                type: "POST",
                url: "/NewFile",
                data: { keyword: keyword },
                dataType: 'json',
                success: function (res) {
                    for (let i = 0; i < 5; i++) {
                    	let title = res[i].title;
                    	let contentid = res[i].contentid;
                    	let resultLink = $('#h' + i + ' a.result-link');
                        resultLink.text(title + contentid);
                        resultLink.off('click').on('click', function () {
                            handleLinkClick(contentid);
                        });
                    }
                },
                error: function (error) {
                    console.error("Ajax request failed: " + error);
                }
            });
        }
        function handleLinkClick(contentid) {
        	var contentid=contentid;
        	var url = "/tourInfo?contentid="+contentid;
        	// 새 창에서 tourInfo.jsp를 팝업으로 열기
            window.open(url, "TourInfoPopup", "width=800, height=600, resizable=yes, scrollbars=yes");
        }
    });
</script>
</body>
</html>
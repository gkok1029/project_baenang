let SidebarModule = (function () {
    // private 변수 및 함수 정의
    let sidebarElement = document.createElement("div");
    sidebarElement.id = "sidebar";

    let mainLogoButton = document.createElement("button");
    mainLogoButton.id = "main-logo";
    mainLogoButton.innerHTML = '<img class="logo" src="" alt="Main Logo"/>';

    let step1Button = createSidebarButton("btn-step1", "STEP 1<br>날짜확인");
    let step2Button = createSidebarButton("btn-step2", "STEP 2<br>장소확인");
    let step3Button = createSidebarButton("btn-step3", "STEP 3<br>숙소설정");

    let nextButton = document.createElement("button");
    nextButton.className = "bottom-button";
    nextButton.innerHTML = "다음";

    function createSidebarButton(id, text) {
        let button = document.createElement("button");
        button.className = "sidebar_button";
        button.id = id;
        button.innerHTML = text;
        return button;
    }

    function initialize() {
        
        // 생성된 요소들을 sidebar에 추가
        sidebarElement.appendChild(mainLogoButton);
        sidebarElement.appendChild(step1Button);
        sidebarElement.appendChild(step2Button);
        sidebarElement.appendChild(step3Button);
        sidebarElement.appendChild(nextButton);
        
        //버튼에 이벤트 리스너 추가
	    step1Button.addEventListener('click', function () {
	        ViewStyleModule.showView('#view1', '#btn-step1');
	        $(".add-frame").hide();
	        $("#search_frame").css({
	            'width': '300px',
	        });
	    });
	
	    step2Button.addEventListener('click', function () {
	        ViewStyleModule.showView('#view2', '#btn-step2');
	        $(".add-frame").show();
	        $("#search_frame").css({
	            'width': '600px',
	        });
	    });
	
	    step3Button.addEventListener('click', function () {
	        ViewStyleModule.showView('.view-step3', '#btn-step3');
	        $(".add-frame").show();
	        $("#search_frame").css({
	            'width': '600px',
	        });
	    });        
		
		let searchFrame = document.getElementById("search_frame");
		searchFrame.parentNode.insertBefore(sidebarElement, searchFrame);
    }    

    // public 메서드 및 속성 정의
    return {
        initialize: initialize
    };
})();
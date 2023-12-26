let SidebarModule = (function () {

    function initialize() {

        //sidebar 초기화
        let flag = $("#sidebar").eq(0);
        if(flag.length>0){
            flag.remove();
        }

        console.log("sidebar 생성");
        // private 변수 및 함수 정의
        let sidebarElement = $("<div>").attr("id", "sidebar");

        console.log("mainLogo 생성 및 요소 설정");
        let mainLogoButton = $("<button>")
            .attr("id", "main-logo")
            .html('<img class="logo" src="" alt="Main Logo"/>');

        console.log("mainLogo 클릭이벤트 설정");
        mainLogoButton.on('click', function () {
            window.location.href = '/main';
        });

        //메인로고 버튼 append
        sidebarElement.append(mainLogoButton);

        //현재 viewId 확인 default view1
        let viewId = document.getElementsByClassName("view")[0].id;
        console.log("현재 viewId : "+viewId);

        if(viewId==="view1"){
            //steps 버튼 생성
            console.log("steps 버튼 생성");
            let step1Button = createSidebarButton("btn-step1", "STEP 1<br>날짜확인");
            let step2Button = createSidebarButton("btn-step2", "STEP 2<br>장소확인");
            let step3Button = createSidebarButton("btn-step3", "STEP 3<br>숙소설정");
            

            //버튼에 이벤트 리스너 추가
            console.log("버튼에 이벤트 생성")
            step1Button.on('click', function () {
                //ViewPageModule.showView('view1', '#btn-step1');
                $(".view").attr("id","view1");
                ViewPageModule.viewPageLoding();
                console.log("버튼1 클릭");
            });
        
            step2Button.on('click', function () {
                //ViewPageModule.showView('view2', '#btn-step2');             
                $(".view").attr("id","view2");
                ViewPageModule.viewPageLoding();
                console.log("버튼2 클릭");
            });
        
            step3Button.on('click', function () {
                //ViewPageModule.showView('view3', '#btn-step3');             
                $(".view").attr("id","view3");
                ViewPageModule.viewPageLoding();
                console.log("버튼3 클릭");
            });

            let nextButton = $("<button>").addClass("bottom-button").html("다음").on('click', function(){
                console.log("step1에서 다음버튼 클릭")
                $(".view").attr("id","view2");
                //ViewPageModule.showView('view2', '#btn-step2');
                
                ViewPageModule.viewPageLoding();
                
                console.log("2단계이동");
                initialize()
                
            });
            sidebarElement.append(step1Button, step2Button, step3Button, nextButton);
            
        }else if(viewId==="view2"){
            console.log("steps 버튼 생성");
            let step1Button = createSidebarButton("btn-step1", "STEP 1<br>날짜확인");
            let step2Button = createSidebarButton("btn-step2", "STEP 2<br>장소확인");
            let step3Button = createSidebarButton("btn-step3", "STEP 3<br>숙소설정");

            //버튼에 이벤트 리스너 추가
            console.log("버튼에 이벤트 생성")
            step1Button.on('click', function () {
                //ViewPageModule.showView('view1', '#btn-step1');
                $(".view").attr("id","view1");
                ViewPageModule.viewPageLoding();
                initialize()
                console.log("버튼1 클릭");
            });
        
            step2Button.on('click', function () {
                //ViewPageModule.showView('view2', '#btn-step2');                
                $(".view").attr("id","view2");
                ViewPageModule.viewPageLoding();
                initialize()
                console.log("버튼2 클릭");
            });
        
            step3Button.on('click', function () {
                //ViewPageModule.showView('view3', '#btn-step3');
                $(".view").attr("id","view3");
                ViewPageModule.viewPageLoding();
                initialize()
                console.log("버튼3 클릭");
            });

            let nextButton = $("<button>").addClass("bottom-button").html("다음").on('click', function(){
                console.log("step2에서 다음버튼 클릭")
                $(".view").attr("id","view3");
                //ViewPageModule.showView('view2', '#btn-step2');
                
                ViewPageModule.viewPageLoding();
                
                console.log("3단계이동");
                initialize()
                
            });
            sidebarElement.append(step1Button, step2Button, step3Button, nextButton);
        }else if(viewId==="view3"){
            console.log("steps 버튼 생성");
            let step1Button = createSidebarButton("btn-step1", "STEP 1<br>날짜확인");
            let step2Button = createSidebarButton("btn-step2", "STEP 2<br>장소확인");
            let step3Button = createSidebarButton("btn-step3", "STEP 3<br>숙소설정");

            //버튼에 이벤트 리스너 추가
            console.log("버튼에 이벤트 생성")
            step1Button.on('click', function () {
                //ViewPageModule.showView('view1', '#btn-step1');
                $(".view").attr("id","view1");
                ViewPageModule.viewPageLoding();
                initialize()
                console.log("버튼1 클릭");
            });
        
            step2Button.on('click', function () {
                //ViewPageModule.showView('view2', '#btn-step2');
                $(".view").attr("id","view2");
                ViewPageModule.viewPageLoding();
                console.log("버튼2 클릭");
                initialize()
            });
        
            step3Button.on('click', function () {
                //ViewPageModule.showView('view3', '#btn-step3');
                $(".view").attr("id","view3");
                ViewPageModule.viewPageLoding();
                console.log("버튼3 클릭");
                initialize()
            });

            let nextButton = $("<button>").addClass("bottom-button").html("일정 생성").on('click', function(){
                $(".view").attr("id","view4");
                ViewPageModule.viewPageLoding();
                console.log("4단계 이동");
                initialize()
            });

            sidebarElement.append(step1Button, step2Button, step3Button, nextButton);
        }else if(viewId="view5"){
            console.log("view 5 시작")
        }
    
        // 부모 엘리먼트
        
        let sidebarContainer = $("#sidebar-container");
        sidebarContainer.append(sidebarElement);
        
    };
    
    // 헬퍼 함수
    function createSidebarButton(id, text) {
        return $("<button>")
            .attr("id", id)
            .addClass("sidebar-button")
            .html(text);         
    };

    // public 메서드 및 속성 정의
    return {
        initialize: initialize
    };
})();
let SidebarModule = (function () {

    function initialize() {

        //sidebar 초기화
        let flag = $("#sidebar").eq(0);
        if(flag.length>0){
            flag.remove();
        }

        // private 변수 및 함수 정의
        let sidebarElement = $("<div>").attr("id", "sidebar");

        let mainLogoButton = $("<button>")
            .attr("id", "main-logo")
            .html('<img class="logo" src="/resources/img/mainlogo.png" alt="Main Logo"/>');
		
	
        //MainLogo 클릭이벤트 설정
        mainLogoButton.on('click', function () {
            window.location.href = '/main';
        });

        //메인로고 버튼 append
        sidebarElement.append(mainLogoButton);

        //현재 viewId 확인 default view1
        let viewId = document.getElementsByClassName("view")[0].id;
        
        if(viewId==="view1"){
            //steps 버튼 생성
            
            let step1Button = createSidebarButton("btn-step1", "STEP 1<br>날짜확인");
            let step2Button = createSidebarButton("btn-step2", "STEP 2<br>장소확인");
            let step3Button = createSidebarButton("btn-step3", "STEP 3<br>숙소설정");
            

            //버튼에 이벤트 리스너 추가
            
            step1Button.on('click', function () {
                
                $(".view").attr("id","view1");
                ViewPageModule.viewPageLoding();
                initialize()
                ViewPageModule.showView('view1', '#btn-step1');
            });
        
            step2Button.on('click', function () {
                
                $(".view").attr("id","view2");
                ViewPageModule.viewPageLoding();
                PlanModule.tour(x,y);
                initialize()
                ViewPageModule.showView('view2', '#btn-step2');
                
            });
        
            step3Button.on('click', function () {
                
                $(".view").attr("id","view3");
                ViewPageModule.viewPageLoding();
                PlanModule.lodging(x,y);
                initialize()
                ViewPageModule.showView('view3', '#btn-step3');             
                
            });

            let nextButton = $("<button>").addClass("bottom-button").html("다음").on('click', function(){
                
                $(".view").attr("id","view2");
                ViewPageModule.viewPageLoding();
                PlanModule.tour(x,y);
                initialize()
                ViewPageModule.showView('view2', '#btn-step2');
                
            });
            sidebarElement.append(step1Button, step2Button, step3Button, nextButton);
            
        }else if(viewId==="view2"){
            
            let step1Button = createSidebarButton("btn-step1", "STEP 1<br>날짜확인");
            let step2Button = createSidebarButton("btn-step2", "STEP 2<br>장소확인");
            let step3Button = createSidebarButton("btn-step3", "STEP 3<br>숙소설정");
            
            //버튼에 이벤트 리스너 추가
            
            step1Button.on('click', function () {
                
                $(".view").attr("id","view1");
                ViewPageModule.viewPageLoding();
                initialize()
                ViewPageModule.showView('view1', '#btn-step1');
            });
        
            step2Button.on('click', function () {
                
                $(".view").attr("id","view2");
                ViewPageModule.viewPageLoding();
                PlanModule.tour(x,y);
                initialize()
                ViewPageModule.showView('view2', '#btn-step2');
                PlanModule.removeDiv();
            });
        
            step3Button.on('click', function () {
                
                $(".view").attr("id","view3");
                ViewPageModule.viewPageLoding();
                PlanModule.lodging(x,y);
                initialize()
                ViewPageModule.showView('view3', '#btn-step3');
                PlanModule.removeDiv();
            });

            let nextButton = $("<button>").addClass("bottom-button").html("다음").on('click', function(){
                
                $(".view").attr("id","view3");
                ViewPageModule.viewPageLoding();
                PlanModule.lodging(x,y);
                initialize()
                ViewPageModule.showView('view3', '#btn-step3');
                
            });
            sidebarElement.append(step1Button, step2Button, step3Button, nextButton);
        }else if(viewId==="view3"){
            
            let step1Button = createSidebarButton("btn-step1", "STEP 1<br>날짜확인");
            let step2Button = createSidebarButton("btn-step2", "STEP 2<br>장소확인");
            let step3Button = createSidebarButton("btn-step3", "STEP 3<br>숙소설정");
            
            //버튼에 이벤트 리스너 추가
            
            step1Button.on('click', function () {
                
                $(".view").attr("id","view1");
                ViewPageModule.viewPageLoding();
                initialize()
                ViewPageModule.showView('view1', '#btn-step1');
            });
        
            step2Button.on('click', function () {
                
                $(".view").attr("id","view2");
                ViewPageModule.viewPageLoding();
                PlanModule.tour(x,y);
                initialize()
                ViewPageModule.showView('view2', '#btn-step2');
                PlanModule.removeDiv();
            });
        
            step3Button.on('click', function () {
                
                $(".view").attr("id","view3");
                ViewPageModule.viewPageLoding();
                PlanModule.lodging(x,y);              
                initialize()
                ViewPageModule.showView('view3', '#btn-step3');
                PlanModule.removeDiv();
            });

            let nextButton = $("<button>").addClass("bottom-button").html("저장").on('click', function(){
                //view4
                $("#myModal").fadeIn();
                $(".view").attr("id","view4");              
                ViewPageModule.viewPageLoding();
                
                initialize()
            });

            sidebarElement.append(step1Button, step2Button, step3Button, nextButton);
        }else if(viewId==="view5"){
            
            let buttons = [];
            let totalDaysBtn = createSidebarButton("btn-totalDays","전체일정").on('click',function(){
                console.log("전체일정")
            });
            let startDate = sessionStorage.getItem('startDate');
			let endDate = sessionStorage.getItem('endDate');

            for(let i=1; i<=3;i++){
                let button = createSidebarButton("btn-day"+i,i+"일차").on('click',function(){
                    console.log(i+"일차 일정");
                });;
                buttons.push(button);
            }

            let modifyBtn = createSidebarButton("btn-modify","편집").on('click',function(){
                console.log("편집버튼")
            });;
            let savePlanBtn = createSidebarButton("btn-savePlan","저장").on('click',function(){
                console.log("저장버튼")
            });;
            
            sidebarElement.append(totalDaysBtn,...buttons,modifyBtn,savePlanBtn);
            
        }
        // $(".view").attr("id","view1");
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
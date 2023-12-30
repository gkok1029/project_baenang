let ViewPageModule = (function () {

	function viewPageLoding(){
        
        let view = document.getElementsByClassName("view");
        
        let viewId;
        
        //유효성검사
        if(view.length>0){
            viewId = view[0].id;
        }else{
            console.log("class가 view인 엘리먼츠가 없다");
            return;
        };
        
        switch(viewId){
            case "view1" : step1Loding();
                break;
            case "view2" : step2Loding();
                break;
            case "view3" : step3Loding();
                break;
            case "view4" : step4Loding();
                break;
            case "view5" : step5Loding();
                break;
        };
        
    };

    function viewExistedCheck(){
        // view-container이 이미 존재하는지 확인
        let flag = $("#viewContainer1");

        if (flag.length > 0) {
          flag.remove();
        };
    }
    function step1Loding(){
        // view-container이 이미 존재하는지 확인
        viewExistedCheck();
        
        // 부모 엘리먼트 선택
        let parentElement = $(".view").eq(0);

        // div.view-container 엘리먼트 생성
        let viewContainerDiv = $("<div>").addClass("view-container").attr("id", "viewContainer1");

        // div#destinationInfo 엘리먼트 생성
        let destinationInfoDiv = $("<div>").attr("id", "destinationInfo");

        // 첫 번째 하위 div 엘리먼트 생성
        let firstChildDiv = $("<div>");
        
        let h2Element = $("<h2>").text(cityname);
        firstChildDiv.append(h2Element);

        let dateDiv = $("<div>").attr("id", "date").text("2023.12.22(금) - 2023.12.29(금)").append(
            $("<div>").attr("id", "frame-calendar-button").append(
                $("<button>").attr(
                    {
                        type: "button",
                        class: "btn btn-primary btn-calendar",
                        "data-toggle": "modal",
                        "data-target": "#calendarModal"
                    }
                ).on('click',function(){
                    console.log('달력 클릭');
                })
                .append(
                    $("<i>").addClass("far fa-calendar-days")
                )
            )
        );
        
        firstChildDiv.append(dateDiv);

        destinationInfoDiv.append(firstChildDiv);

        // 두 번째 하위 div 엘리먼트 생성
        let secondChildDiv = $("<div>");

        // 스카이스캐너 링크
        let linkElement = $("<a>").attr("href", "https://www.skyscanner.co.kr/transport/flights/sela/cju/231218/231220/?adultsv2=1&cabinclass=economy&childrenv2=&inboundaltsenabled=false&outboundaltsenabled=false&preferdirects=false&ref=home&rtn=1");

        // 항공권 버튼
        let buttonElement = $("<button>").attr("id","btn-skyscanner").text("항공권");

        // 링크 아래에 항공권 버튼 조립
        linkElement.append(buttonElement);

        // 두 번째 하위 div에 링크 조립
        secondChildDiv.append(linkElement);

        let timeInfoDiv = $("<div>").text("여행시간 상세설정 총 00시간 00분");
        secondChildDiv.append(timeInfoDiv);
        // 두 번째 하위 div 조립
        destinationInfoDiv.append(secondChildDiv);

        // 세 번째 하위 div 엘리먼트 생성
        let thirdChildDiv = $("<div>").html(
            '입력하신 여행기간이 시차를 고려한 현지 여행 기간(여행지<br>' +
          '도착 날짜, 여행지 출발 날짜)이 맞는지 확인해 주시고 각 날<br>' +
          '짜의 일정 시작시간과 종료시간을 현지 시간 기준으로 설정 해<br>' +
          '주세요. 기본 설정 시간은 오전 10시 ~ 오후 10시 총 12시간<br>' +
          '입니다.'
        );
        
        // appendChild thirdChildDiv
        destinationInfoDiv.append(thirdChildDiv);

        // 네 번째 하위 div 엘리먼트 생성
        let fourthChildDiv = $("<div>");
        let datesContainerDiv = $("<div>").addClass("dates-container");
        // 테이블 생성
        let tableElement = $("<table>");
        // 테이블 헤더 컬럼
        let tableHeaders = ['일지', '요일', '시작시간', '종료시간'];

        // 테이블 헤더 생성
        let tableHeaderRow = $("<tr>");
        $.each(tableHeaders, function (_, headerText) {
          let thElement = $("<td>").text(headerText);
          tableHeaderRow.append(thElement);
        });
        tableElement.append(tableHeaderRow);

        // 테이블 데이터 생성
        let tableData = [
          ['12/18', '월', '오전 10:00', '오후 10:00'],
          ['12/19', '화', '오전 10:00', '오후 10:00'],
          ['12/20', '수', '오전 10:00', '오후 10:00']
        ];

        $.each(tableData, function (_, rowData) {
          let trElement = $("<tr>");
          $.each(rowData, function (_, cellData) {
            let tdElement = $("<td>").text(cellData);
            trElement.append(tdElement);
          });
          tableElement.append(trElement);
        });

        datesContainerDiv.append(tableElement);
        fourthChildDiv.append(datesContainerDiv);

        let buttonDiv = $("<div>");
        let timeSetButton = $("<button>").attr("id", "time-set-button").text("시간 설정 완료").on('click',()=>{
            $(".view").attr("id","view2");
            ViewPageModule.viewPageLoding();
            PlanModule.tour(x,y);
            SidebarModule.initialize()
            ViewPageModule.showView('view2', '#btn-step2');
        });
        buttonDiv.append(timeSetButton);
        fourthChildDiv.append(buttonDiv);

        destinationInfoDiv.append(fourthChildDiv);

        // viewContainer1에 destinationInfoDiv를 추가
        viewContainerDiv.append(destinationInfoDiv);

        // second-frame-container에 viewDiv를 추가
        parentElement.append(viewContainerDiv);
        
    };

    function step2Loding(){
        // view-container이 이미 존재하는지 확인
        viewExistedCheck();
        //Step2 div 생성
        // 부모 엘리먼트 선택
        let parentElement = $(".view").eq(0);

        // div.view-container 엘리먼트 생성
        let viewContainerDiv = $("<div>").addClass("view-container").attr("id", "viewContainer1");
        
        let firstChildDiv = $("<div>").append(
            $("<div>").append(
                $("<div>").text(cityname),
                $("<div>").addClass("trip-date").attr("id","tripDate").text("2023.12.26(화) - 2023.12.28(목)")
            ),
            $("<div>").append(
                $("<div>").append(
                    $("<a>").text("장소 선택")
                ),
                $("<div>").append(
                    $("<a>").text("신규 장소 등록")
                )
            ),
            $("<div>").addClass("search-bar-container").attr("id","searchBarContainer").append(
                $("<input>").addClass("search-bar").attr({
                    "id": "searchBar",
                    "type": "text",
                    "placeholder": "장소명을 입력하세요"
                }).keydown(function(event) {
                 var keyword = $("#searchBar").val();
                	sendAjaxRequest(keyword);
                }),
          		$("<ul>").attr("id", "dropBox")
            ),
            //버튼들
            $("<div>").addClass("cat-buttons").attr("id","catButtons").append(                
                $("<div>").append(
                    $("<button>").addClass("cat-button").attr("id","attractionBtn").text("명소").on('click',function(){
                        PlanModule.attraction()
                    })
                ),
                $("<div>").append(
                    $("<button>").addClass("cat-button").attr("id","restaurantBtn").text("식당").on('click',function(){
                        PlanModule.restaurant()
                    })
                ),
                $("<div>").append(
                    $("<button>").addClass("cat-button").attr("id","cafeBtn").text("카페").on('click',function(){
                        PlanModule.cafe()
                    })
                )
            )
        );
        
       
            
            
	        // 장소 리스트 생성 테이블 div
	        let placesContainerDiv = $('<div>').addClass('places-container').attr("id","placesContainer");
	        
	
	        //부모 엘리먼트 view
	        parentElement.append(
	            // div.view-container
	            viewContainerDiv.append(
	                //
	                firstChildDiv,
	                // 장소 리스트 테이블 div
	                placesContainerDiv
	            )
	        );
	        
	    };
	     function sendAjaxRequest(keyword) {
	          	console.log(keyword);
	            $.ajax({
	                type: "POST",
	                url: "/NewFile",
	                data: { keyword: keyword },
	                dataType: 'json',
	                success: function (res) {
	                	updateDropDown(res);
	                },
	                error: function (error) {
	                    console.error("Ajax request failed: " + error);
	                }
	            });
	            }
         function updateDropDown(data) {
			        // drop-down 박스를 비우고 결과값으로 채움
			        $('#dropBox').empty();
			        for (let i = 0; i <Math.min(data.length, 5); i++) {
			            let item = data[i];
			            let listItem = $('<li>').text(item.title);
			            let url="/tourInfo?contentid=" + item.contentid;
			            listItem.on('click', function() {
			            	$('#placesContainer').empty();
			                PlanModule.displayTourInformation(data,x,y);
			                $('#dropBox').empty(); // 결과를 클릭하면 drop-down 박스를 비움
			            });
			            $('#dropBox').append(listItem);
			        }
			    }
    //장소 div생성
    function createPlaceDiv(url,content){
                //장소 div 수정:id에 contentid붙여서 각각의 개별성?부여
        return $('<div>').addClass("place-container").attr("id","placeContainer"+content.contentid).append(
            //이미지 div
            $('<div>').addClass("place-image").attr("id","img"+content.contentid).append(
                //이미지 태그
                $('<img>').addClass("place-img").attr("id","pimg"+content.contentid)
                		  .attr('src', content.firstimage || '/resources/images/noimage.PNG')
                		  .click(function() {
                  window.open(url, "TourInfoPopup", "width=800, height=600, resizable=yes, scrollbars=yes");
                // PlanModule.openModal(url);
                })
            	),
            //장소 디테일 div
            $('<div>').addClass("place-details").attr("id","pd"+content.contentid).append(
                //장소 이름 div
                $('<div>').addClass("place-title").attr("id","title"+content.contentid).text(content.title),
                //장소 카테고리,주소 div
                $('<div>').addClass("place-cat-and-addr").attr("id","CatAndAddr"+content.contentid).append(
                    //장소 카테고리 div
                    $('<div>').addClass("place-cat").attr("id","cat"+content.contentid).text(content.cat),
                    //장소 주소 div
                    $('<div>').addClass("place-addr").attr("id","addr"+content.contentid).text(content.addr)
                )
            ),
            
            $('<div>').addClass("place-add").attr("id","placeAdd").append(
                //장소 추가 button
                $('<i>').addClass("fa-regular fa-square-plus place-add-button").attr("id","Button"+content.contentid)
                .click(function() { PlanModule.copyPlaceDiv("placeContainer"+content.contentid);
                					sendCountupRequest(content.contentid);
                })
                														
            )
        )
                            
    }
	
	

				
	
	
	
    function step3Loding(){
        // view-container이 이미 존재하는지 확인
        viewExistedCheck();

        //Step3 div 생성
        // 부모 엘리먼트 선택
        let parentElement = $(".view").eq(0);
        // div.view-container 엘리먼트 생성
        let viewContainerDiv = $("<div>").addClass("view-container").attr("id", "viewContainer1");
        
        let firstChildDiv = $("<div>").append(
            $("<div>").append(
                $("<div>").text(cityname),
                $("<div>").addClass("trip-date").attr("id","tripDate").text("2023.12.26(화) - 2023.12.28(목)")
            ),
            $("<div>").append(
                $("<div>").append(
                    $("<a>").text("숙소 설정")
                ),
                $("<div>").append(
                    $("<a>").text("신규 숙소 등록")
                )
            ),
            $("<div>").addClass("search-bar-container").attr("id","searchBarContainer").append(
                $("<input>").addClass("search-bar").attr({
                    "id": "searchBar",
                    "type": "text"
                }).val("장소명을 입력하세요").on('focus',function(){
                    this.textInput.val("");
                }),
                $("<button>").addClass("search-button").attr("id","searchBtn").text("검색")
            )
            
            
        );
        // 장소 리스트 생성 테이블 div
        let placesContainerDiv = $('<div>').addClass('places-container').attr("id","placesContainer")
        //부모 엘리먼트 view
        parentElement.append(
            // div.view-container
            viewContainerDiv.append(
                
                firstChildDiv,
                // 장소 리스트 테이블 div
                placesContainerDiv
            )
        );
        
    };
     function createHotelDiv(url,content){

                //장소 div 수정:id에 contentid붙여서 각각의 개별성?부여
        return $('<div>').addClass("hotel-container").attr("id","hotelContainer"+content.contentid).append(
            //이미지 div
            $('<div>').addClass("hotel-image").attr("id","img"+content.contentid).append(
                //이미지 태그
                $('<img>').addClass("hotel-img").attr("id","pimg"+content.contentid)
                		  .attr('src', content.firstimage || '/resources/images/noimage.PNG')
            	),
            //장소 디테일 div
            $('<div>').addClass("hotel-details").attr("id","pd"+content.contentid).append(
                //장소 이름 div
                $('<div>').addClass("hotel-title").attr("id","title"+content.contentid).text(content.title),
                //장소 카테고리,주소 div
                $('<div>').addClass("hotel-cat-and-addr").attr("id","CatAndAddr"+content.contentid).append(
                    //장소 카테고리 div
                    $('<div>').addClass("hotel-cat").attr("id","cat"+content.contentid).text(content.cat),
                    //장소 주소 div
                    $('<div>').addClass("hotel-addr").attr("id","addr"+content.contentid).text(content.addr)
                )
            ),
            
            $('<div>').addClass("hotel-add").attr("id","hotelAdd").append(
                //장소 추가 button
                $('<i>').addClass("fa-regular fa-square-plus hotel-add-button").attr("id","Button"+content.contentid)
                .click(function() { PlanModule.copyHotelDiv("hotelContainer"+content.contentid);
                					sendCountupRequest(content.contentid);
                })
            )
        ).click(function() {
                  window.open(url, "TourInfoPopup", "width=800, height=600, resizable=yes, scrollbars=yes");
                // PlanModule.openModal(url);
                });
                            
    }
    function sendCountupRequest(contentid) {
        $.ajax({
            type: 'GET',
            url: '/countup',
            data: { contentid: contentid },
            success: function (data) {
            },
            error: function (error) {
            }
        });
    }

    function step4Loding(){

        // view-container이 이미 존재하는지 확인
        viewExistedCheck();

        // 부모 엘리먼트 선택
        let parentElement = $(".view").eq(0);
        let arrDiv = [];
        for(let i=1;i<=4;i++){
            let div = $('<div>').html(i+"일차<br>").append(
                    $('<img>').addClass("picked").attr("src","/resources/images/noimage.PNG"),
                    $('<img>').addClass("picked").attr("src","/resources/images/noimage.PNG"),
                    $('<img>').addClass("picked").attr("src","/resources/images/noimage.PNG")
                );
            arrDiv.push(div);
            
        }
        
        // div.view-container 엘리먼트 생성
        let viewContainerDiv = $("<div>").addClass("view-container").attr("id", "viewContainer1").append(
            $('<div>').append( $('<h3>').text("나의 제주 여행 pick n개") ),
            $('<div>').append(
                $('<img>').addClass("city").attr("src","/resources/images/noimage.PNG"),
                $('<img>').addClass("city").attr("src","/resources/images/noimage.PNG")
            ),
            $('<div>').attr("id","lastedit").append(
                $('<div>').text("제주여행n").append( $('<a>').html("<br>2023.12.04~2023.12.05편집") ),
                $('<div>').text("선택한 장소n").append( $('<a>').text("편집") ),
                $('<div>').append(
                    $('<img>').addClass("selt").attr("src","/resources/images/noimage.PNG"),
                    $('<img>').addClass("selt").attr("src","/resources/images/noimage.PNG"),
                    $('<img>').addClass("selt").attr("src","/resources/images/noimage.PNG"),
                    $('<img>').addClass("selt").attr("src","/resources/images/noimage.PNG")                    
                ),
                $('<div>').text("설정한 숙소 n개").append( $('<a>').text("편집") ),
                $('<div>').append(
                    $('<img>').addClass("sell").attr("src","/resources/images/noimage.PNG"),
                    $('<img>').addClass("sell").attr("src","/resources/images/noimage.PNG"),
                    $('<img>').addClass("sell").attr("src","/resources/images/noimage.PNG")
                ),
                ...arrDiv,
                $('<button>').text("일정생성").on('click', function() {
                    $(".view").attr("id","view5");                    
                    ViewPageModule.viewPageLoding();
                    SidebarModule.initialize();
                })
            )
        );
        
        parentElement.append(viewContainerDiv);
    }

    function step5Loding(){
        viewExistedCheck();

        let parentElement = $(".view").eq(0);

        let viewContainerDiv = $("<div>").addClass("view-container").attr("id", "viewContainer1").append(
            $("<div>").addClass("step5-header").attr("id","step5Header").append(
                $("<div>").append(
                    $("<div>").text("도시명"),
                    $("<div>").append("여행기간"),
                    $("<div>").append(
                        $("<button>").text("항공권")
                    )
                ),
                $("<div>").text("아이콘자리")
            ),
            $("<div>").append(
                $("<div>").append(
                    //n일차
                    createDays(1),
                    createDays(2),
                    createDays(3)
                )
            )
        )

        parentElement.append(viewContainerDiv);
        
    }

    function createDays(i){
        //n일차 일정
        let dayDiv = $("<div>").addClass("day"+i).append(
            $("<div>").append(
                $("<div>").text("1일차"),
                $("<div>").text("12.27(수)")
            ),
            createDayPlace()
        )

        return dayDiv;

    }

    function createDayPlace(){

        //장소
        let dayPlace = $("<div>").append(
            //순차 및 시간, 장소정보
            $("<div>").append(
                //번호 시간
                $("<div>").append(
                    //번호
                    $("<div>"),
                    //시간
                    $("<div>")
                ),//정보 및 이미지
                $("<div>").append(
                    //정보 프레임
                    $("<div>").append(
                        $("<div>").append(
                            //카테고리
                            $("<div>"),
                            //이름
                            $("<div>"),
                            //예약하기
                            $("<div>").append(
                                $("<a>")
                            )
                        )
                    ),
                    //이미지
                    $("<div>")
                )
            ),
            $("<div>").append(
                //이동시간
                $("<div>")
            )
        )

        return dayPlace;
    }

    function showView(viewId, btnId) {
        // $('.view').hide();
        // $(viewId).show();
        
        $('.sidebar-button').css({
            'color': 'gray',
            'opacity': '0.5',
            'fontSize': '12px'
        });

        $(btnId).css({
            'color': 'skyblue',
            'opacity': '1',
            'fontSize': '16px'
        });
        $('.view').attr("id","viewId");
    };

    return {
        showView: showView,
        viewPageLoding : viewPageLoding,
        createPlaceDiv : createPlaceDiv,
        createHotelDiv : createHotelDiv,
        sendAjaxRequest : sendAjaxRequest
        
    };
})();
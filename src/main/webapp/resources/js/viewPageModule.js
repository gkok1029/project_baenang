let ViewPageModule = (function () {

	function viewPageLoding(){
        
        let view = $(".view");
        
        let viewId;
        
        //유효성검사
        if(view.length>0){
            viewId = view.attr("id");
        }else{
            console.log("class가 view인 엘리먼츠가 없다");
            return;
        };
        
        //URL에 p_id가 있으면
        if( SidebarModule.getParametersByNameFromURL('p_id') ){
        	viewId = 'view5';
        	view.attr("id",'view5');
        }
        
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
    
	function getDay(day){
    	
    	switch (day) {
		  	case 0 :
		  	case "Sun" :
		    	return "(일)"
		    	break;
		  	case 1 :
		  	case "Mon" :
		    	return "(월)"
		    	break;
		  	case 2 :
		  	case "Tue" :
		    	return "(화)"
		    	break;
		  	case 3 :
		  	case "Wed" :
		    	return "(수)"
		    	break;
		  	case 4 :
		  	case "Thu" :
		    	return "(목)"
		    	break;
		  	case 5 :
		  	case "Fri" :
		    	return "(금)"
		    	break;
		  	case 6 :
		  	case "Sat" :
		    	return "(토)"
		    	break;		  
		}    	
    }
    
    
    
    //StartDate 부터 EndDate까지 날짜 구하기
    function getDates(startDate, endDate) {
		    let dateArray = [];
		    let currentDate = new Date(startDate);
		    console.log(startDate)
		    console.log(endDate)
		    while (currentDate <= endDate) {
		        dateArray.push(new Date(currentDate));
		        currentDate.setDate(currentDate.getDate() + 1);
		        console.log(dateArray)
		    }
			
		    return dateArray;
		}
		
    function step1Loding(){
    	if( !sessionStorage.getItem('startDate') && !sessionStorage.getItem('endDate') ){
    		$('#calendar-modal').fadeIn();
    		return
    	}
    	let startDate = sessionStorage.getItem("startDate");
        let endDate = sessionStorage.getItem("endDate");
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
		
		
        let dateDiv = $("<div>").attr("id", "date").text(startDate+getDay( new Date(startDate).getDay()) + " ~ " + endDate+getDay(new Date(endDate).getDay()) ).append(
            $("<div>").attr("id", "frame-calendar-button").append(
                $("<button>").attr(
                    {
                        type: "button",
                        class: "btn btn-primary btn-calendar",
                        "data-toggle": "modal",
                        "data-target": "#calendarModal"
                    }
                ).on('click',function(){

                    $('#calendar-modal').fadeIn();

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


        startDate = new Date(sessionStorage.getItem('startDate'));
        endDate = new Date(sessionStorage.getItem('endDate'));
 		
 		// startDate부터 endDate까지 날짜 구하기
		let dateArray = getDates(startDate, endDate);
		
		// 테이블 데이터 생성
		let tableData = dateArray.map(date => {
		    let dayNames = ['일', '월', '화', '수', '목', '금', '토'];
		    let formattedDate = [
		        `${date.getMonth() + 1}/${date.getDate()}`, // MM/DD 형식
		        dayNames[date.getDay()], // 요일
		        `${formatTime(date.getHours())}:${formatTime(date.getMinutes())}`, // 오전 시간
		        `${formatTime(date.getHours() + 12)}:${formatTime(date.getMinutes())}` // 오후 시간
		    ];
		
		    return formattedDate;
		});
		
		
		// 시간을 두 자리로 포맷팅하는 함수
		function formatTime(time) {
		    return time < 10 ? `0${time}` : `${time}`;
		}
 
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
        
        if( !sessionStorage.getItem('startDate') && !sessionStorage.getItem('endDate') ){
    		$('#calendar-modal').fadeIn();
    		return
    	}
    	let startDate = sessionStorage.getItem("startDate");
        let endDate = sessionStorage.getItem("endDate");
        
        let firstChildDiv = $("<div>").append(
            $("<div>").append(
                $("<div>").text(cityname),
                $("<div>").addClass("trip-date").attr("id","tripDate").text(startDate+getDay( new Date(startDate).getDay()) + " ~ " + endDate+getDay(new Date(endDate).getDay()) )
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
	            $.ajax({
	                type: "POST",
	                url: "/iwd",
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
                .click(function() { PlanModule.copyPlaceDiv("placeContainer"+content.contentid,content);
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
        
        if( !sessionStorage.getItem('startDate') && !sessionStorage.getItem('endDate') ){
    		$('#calendar-modal').fadeIn();
    		return
    	}
    	let startDate = sessionStorage.getItem("startDate");
        let endDate = sessionStorage.getItem("endDate");
        
        let firstChildDiv = $("<div>").append(
            $("<div>").append(
                $("<div>").text(cityname),
                $("<div>").addClass("trip-date").attr("id","tripDate").text(startDate+getDay(startDate) + " ~ " + endDate+getDay(endDate))
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
                    "type": "text",
                    "placeholder": "장소명을 입력하세요"
                }).keydown(function(event) {
                 var keyword = $("#searchBar").val();
                	sendAjaxRequest(keyword);
                }),
          		$("<ul>").attr("id", "dropBox")
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
                		  .click(function() {
                  window.open(url, "TourInfoPopup", "width=800, height=600, resizable=yes, scrollbars=yes");
                // PlanModule.openModal(url);
                })
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
                .click(function() { PlanModule.copyHotelDiv("hotelContainer"+content.contentid,content);
                					sendCountupRequest(content.contentid);
                })
            )
            
        )
                            
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

    function step5Loding(){
        viewExistedCheck();

        let parentElement = $(".view").eq(0);
		
		let sDateInSessionStorage = sessionStorage.getItem("startDate");
		let eDateInSessionStorage = sessionStorage.getItem("endDate");
		let sDate = new Date(sDateInSessionStorage);
		let eDate = new Date(eDateInSessionStorage);
		let days = getDates(sDate,eDate);
		
		let plans = '${dplvo}'
		
		let p_id;
		if(SidebarModule.getParametersByNameFromURL('p_id')){
			
		}
		
		
        let viewContainerDiv = $("<div>").addClass("view-container").attr("id", "viewContainer1").append(
            $("<div>").addClass("step5-header").attr("id","step5Header").append(
                $("<div>").addClass("step5-header-container").append(
                    $("<div>").text(cityname),
                    $("<div>").text()                   
                )
            ),
            $("<div>").addClass("step5-body").append(
                $("<div>").addClass("step5-body-container").append(
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
        $('.view').attr("id",viewId);
    };

    function getMyPlans(contentId){
        $.ajax({
			type : 'get',
			dataType : 'json',
			url : '?contentId=' + contentId,
			cache : false,
			processData : true,
			success : function(res) {
				PlanModule.tour(res.x, res.y);
				x=res.x;
				y=res.y;
			},
			error : function(err) {
				alert('error: ' + err.status);
			}

		})
    }

    return {
        showView: showView,
        viewPageLoding : viewPageLoding,
        createPlaceDiv : createPlaceDiv,
        createHotelDiv : createHotelDiv,
        sendAjaxRequest : sendAjaxRequest,
        step1Loding : step1Loding,
        getDates : getDates,
        getDay : getDay
    };
})();
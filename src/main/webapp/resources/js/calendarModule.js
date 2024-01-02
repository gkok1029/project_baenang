let CalendarModule = ( ()=>{

    function createCalendar(){
    
        let current_year = (new Date()).getFullYear();
        let current_month = (new Date()).getMonth()+1;
        
        let calendar = $('<div>').addClass("calendar-container").append(
            $('<div>').append(
                $('<div>').append(
                    $('<div>').text("여행 기간이 어떻게 되시나요?").css({ 'text-align' : 'center' }),
                    $('<div>').append(
                        $('<div>').html("* 여행 일자는 <b>최대 10일</b>까지 설정 가능합니다.").css({ 'text-align' : 'center' }),
                        $('<div>').html("현지 여행 기간<b>(여행지 도착 날짜, 여행지 출발 날짜)</b>으로 입력해 주세요.").css({ 'text-align' : 'center' })
                    )
                ),
                $('<div>').append(
                    $('<div>').css( { 'display' : 'flex' } ).append(
                    	$('<div>').css( { 'display' : 'flex' } ).append(
                    		$('<div>').append(
                    			$('<button>').addClass("arrow-button").attr("type","button").append(
                            		$('<i>').addClass("fa-solid fa-chevron-left")
                            	)
                    		),
                    		$('<span>').text(current_year + "년 " + current_month + "월")
                        ),                    	
                    	$('<div>').css( { 'display' : 'flex' } ).append(
                    		
                    		$('<span>').text(current_year + "년 " + (current_month+1) + "월"),
                    		$('<div>').append(
                    			$('<button>').addClass("arrow-button").attr("type","button").append(
                            		$('<i>').addClass("fa-solid fa-chevron-right")                          		
                            	)
                    		)
                    		
                    	)  
                    ),
                    $('<div>').append(
                        
                        $('<div>').css('display','flex').append(
                        	//왼쪽 달력
                            $('<table>').addClass("calendar-table calendar-table-bordered").append(
                                generateCalendarHeader(),
                                generateCalendar(current_year, current_month)
                            ),
                            //오른쪽 달력
                            $('<table>').addClass("calendar-table calendar-table-bordered").append(
                                generateCalendarHeader(),
                                generateCalendar(current_year, current_month+1)
                            )
                        )
                    ),
                    $('<div>').append(
                    	$('<button>').addClass("confirm-button").attr("type","button").text("선택").on('click',function(){
                    		
                    		ViewPageModule.step1Loding();
                    		$(".modal").hide();
                    		
                    	})
                    )
                )                
            )
        )
        
        $("#calendar-modal").append(calendar);
    }

    

    function checkLeapYear(year){
        return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);        
    }
	
	function generateCalendarHeader(){
		return $('<thead>').attr("id","calendarHeader").append(
                            $('<tr>').append(
                                $('<th>').css('color','red').text("일"),
                                $('<th>').text("월"),
                                $('<th>').text("화"),
                                $('<th>').text("수"),
                                $('<th>').text("목"),
                                $('<th>').text("금"),
                                $('<th>').css('color','blue').text("토")
                            )
					)
	}
	
        // 특정 월의 달력을 생성하는 함수
    function generateCalendar(year, month) {
    	
        let calendarBody = $('<tbody>').addClass("calendar-body").attr("id","calendarBody")
        calendarBody.empty(); // 기존 내용 초기화

        // 특정 월의 첫 날 구하기
        let firstDay = new Date(year, month - 1, 1);
        let lastDay = new Date(year, month, 0);
		
        // 첫 날의 요일과 마지막 날의 날짜 구하기
        let startDay = firstDay.getDay();
        let daysInMonth = lastDay.getDate();

        // 윤년이면 2월이 29일까지
        if (month === 2 && checkLeapYear(year)) {
            daysInMonth = 29;
        }

        // 테이블에 날짜 추가
        let date = 1;
        for (let i = 0; i < 6; i++) {
            let row = $("<tr>");
            
            for (let j = 0; j < 7; j++) {
            
            	let cell = $("<td>");
	            
            	if (i === 0 && j < startDay) {
                    row.append(cell);
                } else if (date > daysInMonth) {
                    break;
                } else {
                	let dayButton = $('<button>').attr("id",year+"-"+month+"-"+date).addClass("day-button").text(date).on('click',function(){
                		let id = $(this).attr("id");
                		dateClickEvent(id);
                		
                    }).on('mouseover',function(){
                    		
                    	});
                    // 일요일에는 글자 색을 빨간색으로 설정
		            if (j === 0) {
		                dayButton.css('color', 'red');
		            }
		            // 토요일에는 글자 색을 파란색으로 설정
		            else if (j === 6) {
		                dayButton.css('color', 'blue');
		            }
                    cell.append(dayButton);
                    row.append(cell);
                    date++;
                }
            }
            
            calendarBody.append(row);
            
        }
        return calendarBody
    }
	
	function dateMouseOverEvent(){
		
	}
	
	function dateClickEvent(id){
		
		let dateString = id;
		let dateParts = dateString.split("-");
		
		let year = dateParts[0];
		let month = dateParts[1];
		let date = dateParts[2];
		
		if(month<10){
			month = "0" + month;
		}
		if(date<10){
			date = "0" + date;
		}
		
		let result = year + "-" + month + "-" + date
		let existedStartDate = sessionStorage.getItem('startDate');
		let existedEndDate = sessionStorage.getItem('endDate');
		
		if( existedStartDate && existedEndDate ){
			sessionStorage.removeItem('endDate');
			sessionStorage.removeItem('startDate');
			sessionStorage.setItem('startDate',result);
			
		}else if( !existedEndDate ){
			sessionStorage.setItem('endDate',result);
			$('.confirm-button').prop('disabled',false);
			
		}

	}

    return {
        createCalendar : createCalendar        
    };
})();
let CalendarModule = ( ()=>{

    

    function createCalendar(){
    
        let current_year = (new Date()).getFullYear();
        let current_month = (new Date()).getMonth()+1;
        
        let calendar = $('<div>').addClass("calendar-container").append(
            $('<div>').append(
                $('<div>').append(
                    $('<div>').text("여행 기간이 어떻게 되시나요?"),
                    $('<div>').append(
                        $('<div>').html("* 여행 일자는 <b>최대 10일</b>까지 설정 가능합니다."),
                        $('<div>').html("현지 여행 기간<b>(여행지 도착 날짜, 여행지 출발 날짜)</b>으로 입력해 주세요.")
                    )
                ),
                $('<div>').append(
                    $('<div>').append(
                        $('<button>').attr("type","button").append(
                            $('<i>').addClass("fa fa-chevron-left")
                        ),
                        $('<input>',{
                            'type' : "number",
                            "id" : "year",
                            "value" : "2023",
                            "style" : "width:80px; display: initial;",
                            "class" : "form-control"
                        }),
                        $('<select>',{
                            "id" : "month",
                            "class" : "form-control",
                            "style" : "width:80px;display:initial;"
                        }).append(
                            $("<option>").attr("value","1").text("1월"),
                            $("<option>").attr("value","2").text("2월"),
                            $("<option>").attr("value","3").text("3월"),
                            $("<option>").attr("value","4").text("4월"),
                            $("<option>").attr("value","5").text("5월"),
                            $("<option>").attr("value","6").text("6월"),
                            $("<option>").attr("value","7").text("7월"),
                            $("<option>").attr("value","8").text("8월"),
                            $("<option>").attr("value","9").text("9월"),
                            $("<option>").attr("value","10").text("10월"),
                            $("<option>").attr("value","11").text("11월"),
                            $("<option>").attr("value","12").text("12월")
                        )
                        // $('<span>').addClass("form-control").attr("id","year").text("2023년 12월").css({
						// 	'width' : '80px',
                        //     'display' : 'initial'
                        // })
                    ),
                    $('<div>').append(
                        //왼쪽 달력
                        $('<div>').append(
                            $('<table>').addClass("calendar-table calendar-table-bordered").append(
                                $('<thead>').attr("id","calendarHeader").append(
                                    $('<tr>').append(
                                        $('<th>').text("일"),
                                        $('<th>').text("월"),
                                        $('<th>').text("화"),
                                        $('<th>').text("수"),
                                        $('<th>').text("목"),
                                        $('<th>').text("금"),
                                        $('<th>').text("토")
                                    )
                                ),
                                $('<tbody>').addClass("calendar-body").attr("id","calendarBody").append(
                                	generateCalendar(current_year, current_month)
                                )
                            )
                        )
                              
                    )                    
                )                
            )
        )
			
        $("#calendar-modal").append(calendar);
    }

    

    function checkLeapYear(year){
        return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);        
    }

        // 특정 월의 달력을 생성하는 함수
    function generateCalendar(year, month) {
    	
        let calendarBody = $("#calendarBody");
        calendarBody.empty(); // 기존 내용 초기화

        // 특정 월의 첫 날 구하기
        let firstDay = new Date(year, month - 1, 1);
        let lastDay = new Date(year, month, 0);
		
        // 첫 날의 요일과 마지막 날의 날짜 구하기
        let startDay = firstDay.getDay();
        let daysInMonth = lastDay.getDate();

        // 윤년이면 2월이 29일까지
        if (month === 2 && isLeapYear(year)) {
            daysInMonth = 29;
        }

        // 테이블에 날짜 추가
        let date = 1;
        for (let i = 0; i < 6; i++) {
            let row = $("<tr>");
            
            for (let j = 0; j < 7; j++) {
                if (i === 0 && j < startDay) {
                    let cell = $("<td>");
                    row.append(cell);
                } else if (date > daysInMonth) {
                    break;
                } else {
                    let cell = $("<td>").text(date);
                    row.append(cell);
                    date++;
                }
            }
            
            calendarBody.append(row);
            console.log(calendarBody.children());
            
        }
        return calendarBody
    }
	
	
    // function getFirstDayOfWeek(year,month){
	// 	if(month < 10) month = "0" + month;

	// 	return (new Date(year+"-"+month+"-01")).getDay();
    // }

    // function changeYearMonth(year, month){
    //     let month_day = [31,28,31,30,31,30,31,31,30,31,30,31];
			
	// 		// 윤년인지 확인
    //     if(month === 2){
    //         if(checkLeapYear(year)) month_day[1] = 29;
    //     }

    //     let first_day_of_week = getFirstDayOfWeek(year, month);
    //     let arr_calendar = [];
    //     for(let i=0 ; i<first_day_of_week ; i++){
    //         arr_calendar.push("");
    //     }

    //     for(let i=0 ; i<=month_day[month-1] ; i++){
    //         arr_calendar.push(String(i));
    //     }

    //     let remain_day = 7 - (arr_calendar.length%7);
    //     if(remain_day < 7){
    //         for(let i=0 ; i<remain_day ; i++){
    //             arr_calendar.push("");
    //         }
    //     }

    //     renderCalendar(arr_calendar);
    // }

    // function renderCalendar(data){
    //     let h = [];
    //     for(let i=0 ; i<data.length ; i++){
    //         if(i===0){
    //             h.push('<tr>');
    //         }else if(i%7===0){
    //             h.push('</tr>');
    //             h.push('<tr>');
    //         }

    //         h.push('</tr>');

            
    //     }

        

    //     loadCalendar();

    //     function loadCalendar(){

    //     }

    //     $('#year').val(current_year);
    //     $('#month').val(current_month);

    //     changeYearMonth(current_year,current_month);
    // }



    // function changeMonth(diff){
    //     if(diff === undefined){
    //         current_month = parseInt($('#month').val());
    //     }else{
    //         current_month = current_month + diff;

    //         if(current_month === 0){
    //             current_year = current_year - 1;
    //             current_month = 12;
    //         }else if(current_month === 13){
    //             current_year = current_year +1;
    //             current_month = 1;
    //         }
    //     }
    //     $('#year').val(current_year);
    //     $('#month').val(current_month);
    //     changeYearMonth(current_year,current_month);
    // }

    return {
        createCalendar : createCalendar        
    };
})();
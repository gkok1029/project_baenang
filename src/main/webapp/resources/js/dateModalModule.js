
let DateModalModule = (function () {

    //달력모달 열기
    function openCalendarModal(){
        let modal = document.getElementById("calendarModal");
        modal.style.display = 'block';
    }

    //달력모달 닫기
    function closeCalendarModal(){
        let modal = document.getElementById("calendarModal");
        modal.style.display = 'none';
    }
	
	function createCalendarModal(){
		//모달 엘리먼트 생성
        let modal = document.createElement("div");

        //요소 설정
        modal.className = "modal";
        modal.id = "calendar-modal";

        //모달 Container 생성
        let modalContainer = document.createElement("div");
        modalContainer.className = "modal-container";
        modalContainer.id = "calendar-container";

        //모달 Header 생성
        let modalHeader = document.createElement("div");
        modalHeader.className = "modal-header";
        modalHeader.id = "calendar-header";

        //모달 Body 생성
        let modalContent = document.createElement("div");
        modalContent.className = "modal-body";
        modalContent.id = "calendar-body";

        //모달 Footer 생성
        let modalFooter = document.createElement("div");
        modalFooter.className = "modal-footer";
        modalFooter.id = "calendar-footer";

        //조립
        modal.appendChild(modalContainer);
        modal.appendChild(modalHeader);
        modal.appendChild(modalContent);
        modal.appendChild(modalFooter);
        
	} 

    function initializeDateModal() {
        // 달력 모달을 표시할 때 Datepicker 초기화
        $('#calendarModal').on('shown.bs.modal', function () {
            // 출발 날짜 Datepicker 초기화
            $('#startDate').datepicker();
            // 도착 날짜 Datepicker 초기화
            $('#endDate').datepicker();
        });
    }

    function saveDates() {
        // 선택한 출발 날짜와 도착 날짜를 가져와서 콘솔에 출력
        let startDate = $('#startDate').val();
        let endDate = $('#endDate').val();        
        console.log('출발 날짜:', startDate);
        console.log('도착 날짜:', endDate);

        // 모달을 닫음
        // $('#calendarModal').modal('hide');
    }

    return {
        initializeDateModal: initializeDateModal,
        saveDates: saveDates,
        createCalendarModal : createCalendarModal,
        openCalendarModal : openCalendarModal,
        closeCalendarModal : closeCalendarModal
    };
})();
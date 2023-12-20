
let DateModalModule = (function () {
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
        saveDates: saveDates
    };
})();
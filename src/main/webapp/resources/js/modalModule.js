let ModalModule = ( ()=>{

    function initSaveCheckModal(){
        let modal = $('<div>',{
            'class' : 'modal',
            'id' : 'saveCheckModal',
        }).append(
            $('<div>').addClass('modal-content').append(
                $('<h2>').text("확인"),
                $('<p>').text("여행 계획을 저장하시겠습니까?"),
                $('<div>').append(
                    $('<button>').addClass('close-modal-btn').text("닫기"),
                    $('<button>').addClass('confirm-btn').text("확인")
                )
            )
        );

        $('.body').append(modal);

    }

    return {
        initSaveCheckModal : initSaveCheckModal
    };
})();
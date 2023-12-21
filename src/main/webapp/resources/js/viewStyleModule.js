let ViewStyleModule = (function () {
    function showView(viewId, btnId) {
        $('.view').hide();
        $(viewId).show();

        $('.sidebar_button').css({
            'color': 'gray',
            'opacity': '0.5',
            'fontSize': '12px'
        });

        $(btnId).css({
            'color': 'skyblue',
            'opacity': '1',
            'fontSize': '16px'
        });
    }

    return {
        showView: showView
    };
})();
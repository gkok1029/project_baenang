
let MapModule = (function () {
    let map;

    function initializeMap() {        
        
        let mapDiv = document.createAttribute('div');
        mapDiv.id="map";
        
        let mapOptions = {
            center: new naver.maps.LatLng(y, x),
            zoom: 4
        };
        
        map = new naver.maps.Map('map', mapOptions);
        
        // 페이지 크기 변경시 지도 크기 조절
        function resizeMap() {
            let page = getCurrentPageSize();
            let height = page.height;
            let width = page.width;

            map.setSize(new naver.maps.Size(width, height));
        }
        
        // 초기화 후 지도 크기 조절
        resizeMap();
        
        // 윈도우 리사이즈 이벤트에 리사이즈 함수 연결
        window.addEventListener('resize', resizeMap);
        
    }

    //페이지 사이즈 얻는 함수
    function getCurrentPageSize() {
        let width = window.innerWidth ||
            document.documentElement.clientWidth ||
            document.body.clientWidth;

        let height = window.innerHeight ||
            document.documentElement.clientHeight ||
            document.body.clientHeight;

        return { width: width, height: height };
    }

    function moveMap(lat, len) {
		var mapOptions = {
			center : new naver.maps.LatLng(len, lat),
			zoom : 10,
			mapTypeControl : true
		};
		map = new naver.maps.Map('map', mapOptions);
	}

    return {
        initializeMap: initializeMap,
        moveMap : moveMap
    };
})();
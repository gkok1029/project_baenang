<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <title>여행 일정</title>
  <style>
    /* 추가한 CSS */
    #tripPlan {
      display: flex;
      flex-wrap: nowrap;
      gap: 20px;
      overflow-x: auto; /* 스크롤을 사용해 넘치는 부분을 볼 수 있도록 설정 */
    }

    .dayContainer {
      display: flex;
      flex-direction: column;
      border: 1px solid #ccc;
      padding: 10px;
      min-width: 200px; /* 각 날짜의 최소 너비를 설정하여 스크롤 가능하도록 함 */
    }

    .place {
      margin-top: 10px;
    }
  </style>
</head>
<body>

<h1>여행 일정</h1>

<div>여행도시 : 제주</div>
<div>여행기간 : 2023.12.04 ~ 2023.12.05</div>

<div id="tripPlan">
  <!-- 여행 일정이 여기에 표시될 거에요 -->
</div>

<script>
  // 각 일자별 장소와 설명 텍스트
  const tripDetails = {
    "2023-12-04": {
      "day": "1일차",
      "places": [
        { "name": "서울", "description": "서울에 대한 설명입니다." },
        { "name": "경주", "description": "경주에 대한 설명입니다." }
      ]
    },
    "2023-12-05": {
      "day": "2일차",
      "places": [
        { "name": "경주", "description": "경주에 대한 설명입니다." },
        { "name": "부산", "description": "부산에 대한 설명입니다." },
        { "name": "여수", "description": "여수에 대한 설명입니다." }
      ]
    },
    "2023-12-06": {
      "day": "3일차",
      "places": [
        { "name": "부산", "description": "부산에 대한 설명입니다." },
        { "name": "제주", "description": "제주에 대한 설명입니다." }
      ]
    },
    "2023-12-07": {
      "day": "4일차",
      "places": [
        { "name": "제주", "description": "제주에 대한 설명입니다." }
      ]
    }
  };

  // 페이지 생성 함수
  function createTripPlan() {
    const tripPlanDiv = document.getElementById('tripPlan');

    Object.keys(tripDetails).forEach(dateString => {
      const dayData = tripDetails[dateString];

      const dayContainer = document.createElement('div');
      dayContainer.classList.add('dayContainer');

      const dayHeader = document.createElement('h2');
      dayHeader.textContent = dateString + " (" + dayData.day + ")";
      dayContainer.appendChild(dayHeader);

      dayData.places.forEach(place => {
        const placeDiv = document.createElement('div');
        placeDiv.classList.add('place');
        const placeName = document.createElement('h3');
        placeName.textContent = place.name;
        const placeDescription = document.createElement('p');
        placeDescription.textContent = place.description || "장소에 대한 설명이 없습니다.";
        placeDiv.appendChild(placeName);
        placeDiv.appendChild(placeDescription);
        dayContainer.appendChild(placeDiv);
      });

      tripPlanDiv.appendChild(dayContainer);
    });
  }

  // 페이지 생성 호출
  createTripPlan();
</script>

</body>
</html>

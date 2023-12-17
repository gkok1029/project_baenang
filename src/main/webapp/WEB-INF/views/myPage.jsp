<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 JavaScript (Popper.js와 jQuery 포함) -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=dsbc03s9xu&submodules=geocoder"></script>
<title>My Page</title>
<style>
	*{margin:0; padding:0;}
    a{text-decoration: none;}
    .cursor{cursor: pointer;}
    header{position: relative;}
	header #top{padding:10px 0; height:20px; width:100%; position:relative;}
	header #top .profile{position:absolute; right: 5%;}
	header #topbg{width:100%; height: 150px; background: skyblue;}
    header #topcenprowrap{width: 100%; height: auto;}
    header #topcenpro{
        width: 100%; height: auto; text-align: center; margin-bottom: 44px;
    }
    header #topcenpro p.profile_img span{
        width: 100px; border-radius: 50%; height: 100px; line-height: 100px; display: inline-block;
        background-color: gray;
    }
    header #topcenpro p.username{margin: 12px 0;}
    header #topcenpro p.username span{font-size: larger;}
    header #topcenpro p.profilemanage span{font-weight: 600;}


    main{width: 100%;}
    main #wrap{padding: 0 20%; }
    main #wrap .category{
        display: flex;
        padding-bottom: 80px;
    }
    main #wrap #innerwrap #myschedulewrap{display: block;}
    main #wrap .category div{width: 50%}
    main #wrap #innerwrap .myschedule{font-size: x-large; font-weight: 800; margin: 21px 0;}
    main #wrap #innerwrap .myschedule2{padding-bottom: 50px;}
    main #wrap #innerwrap .myschedule2 span:first-child{margin-right: 19px;}
    main #wrap #innerwrap .myschedule2 span:last-child{float: right;}


    main #section #schedule{display: flex; height: auto; padding-bottom: 33px;}
    main #section #schedule .schedule_img{
        width: 25%; text-align: center; background-color: gainsboro; margin-right: 1px;
        height: 175px; line-height: 175px;
    }
    main #section #schedule .schedule_content{
        width: 75%; background-color: gainsboro; margin-left: 1px; font-size: 12px;
        padding: 14px; position: relative;
    }
    main #section #schedule .schedule_content p{padding: 4px 0;}
    main #section #schedule .schedule_content .d_day{
        margin-right: 24px;
    }
    main #section #schedule .schedule_content p:nth-of-type(2){
        font-size: 20px; padding: 24px 0;
    }
    main #section #schedule .schedule_content p span.writeday{
        float: right; 
    }
    main #section #schedule .schedule_content p.schewritter{
        float: right;
    }

    #hamburger{
        position: absolute; right: 7px; top: 45%; z-index: 10;
    }
    #hamburger span{
        background: black; width: 5px; height: 5px; border-radius: 50%; display: block;
    }
    #hamburger span:nth-of-type(2){
        margin: 2px 0;
    }
</style>
</head>
<body>
	<header>
		<div id=top>
			<div class=profile>Profile</div>
		</div>
		<div id=topbg>
            
        </div>
		<div id="topcenprowrap">
            <div id=topcenpro>
                <p class="profile_img"><span>profile_img</span></p>
                <p class="username"><span>username_000001</span></p>
                <p class="profilemanage"><span><a href="#">프로필 관리</a></span></p>
            </div>
        </div>
	</header>
    <main>
        <div id="wrap">
            <div id="innerwrap">
                <div class="category">
                    <div class="cursor"><span>나의 일정</span></div>
                    <div class="cursor"><span>나의 여행 도시 목록</span></div>
                </div>


                <!--나의 일정 블럭 시작-->
                <div id="myschedulewrap">
                    <div class="myschedule">나의 일정</div>
                    <div class="myschedule2">
                        <span class="cursor">전체 일정</span>
                        <span class="cursor">공유 일정</span>
                        <span class="cursor">최근 수정일 순</span>
                    </div>


                    <!--전체 일정 섹션-->
                    <div id="section" style="display: none;">
                        <div id="schedule">
                            <div class="schedule_img">여행이미지</div>
                            <div class="schedule_content">
                                <p><span class="d_day">D-day</span><span class="tripname">여행지 이름</span></p>
                                <p class="schename">여행이름</p>
                                <p>
                                    <span class="scheday">2023.12.15 ~ 2023.12.20</span>
                                    <span class="writeday">최근 수정일  2023.12.15</span>
                                </p>
                                <p class="schewritter">작성자: 본인</p>
                                <div id="hamburger" class="cursor">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                        <div id="schedule">
                            <div class="schedule_img">여행이미지</div>
                            <div class="schedule_content">
                                <p><span class="d_day">D-day</span><span class="tripname">여행지 이름</span></p>
                                <p class="schename">여행이름</p>
                                <p>
                                    <span class="scheday">2023.12.15 ~ 2023.12.20</span>
                                    <span class="writeday">최근 수정일  2023.12.15</span>
                                </p>
                                <p class="schewritter">작성자: 본인</p>
                                <div id="hamburger" class="cursor">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--전체 일정 섹션-->


                    <!--공유 일정 섹션-->
                    <div id="section">
                        <div id="schedule">
                            <div class="schedule_img">여행이미지</div>
                            <div class="schedule_content">
                                <p><span class="d_day">D-day</span><span class="tripname">여행지 이름</span></p>
                                <p class="schename">여행이름</p>
                                <p>
                                    <span class="scheday">2023.12.15 ~ 2023.12.20</span>
                                    <span class="writeday">최근 수정일  2023.12.15</span>
                                </p>
                                <p class="schewritter">작성자: 길동</p>
                                <div id="hamburger" class="cursor">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                        <div id="schedule">
                            <div class="schedule_img">여행이미지</div>
                            <div class="schedule_content">
                                <p><span class="d_day">D-day</span><span class="tripname">여행지 이름</span></p>
                                <p class="schename">여행이름</p>
                                <p>
                                    <span class="scheday">2023.12.15 ~ 2023.12.20</span>
                                    <span class="writeday">최근 수정일  2023.12.15</span>
                                </p>
                                <p class="schewritter">작성자: 윤정</p>
                                <div id="hamburger" class="cursor">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--공유 일정 섹션-->


                </div>
                <!--나의 일정 블럭 종료-->


            </div>
        </div>
    </main>
</body>
</html>
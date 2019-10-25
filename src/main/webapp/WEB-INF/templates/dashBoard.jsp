<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
<title>OIL ODI</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" href="css/main.css">

<style type="text/css">
.임시클래스{
 border:1px solid black;
}

.navbar{
	margin-bottom:20px;
}

</style>
</head>
<body class="text-center">
<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
	    <div class="row">
	        <div class="col-md-4 임시클래스">전국 주유소 평균</div>
	        <div class="col-md-4 임시클래스">최근 7일 전국 일일 평균가</div>
	        <div class="col-md-4 임시클래스">최근 1주간 주간 평균가</div>
	        <div class="col-md-6 임시클래스">시도별 주유소 평균가격(현재)</div>
	        <div class="col-md-6 임시클래스">시군구별 주유소 평균가격(현재)</div>
	        <div class="col-md-6 임시클래스">이미지를 넣는다.(top10)주유소</div>
	        <div class="col-md-6 임시클래스">전국 /지역별 최저가 주유소(Top10)</div>
	        <div class="col-md-6 임시클래스">반경내 주유소</div>
	        <div class="col-md-6 임시클래스">주유소 상세정보</div>
	    </div>
	    <div class = "row">
	    <div id="maplist" class="col-md-6 임시클래스" style="min-height:500px">
	    	<ul id="mlist"></ul>
	    </div>
	    <div id="map" class="col-md-6 임시클래스" style="min-height:500px"></div>
	    </div>
	    
	</div>
</div>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.3.3/proj4-src.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d47821d08c14a3b647e14eafa6ab215&libraries=services"></script>
    <script>
    	var menu = document.getElementById("menu");
    	menu.className="nav-link dropdown-toggle active";
    </script>
  <script type="text/javascript">

  var data = {};
  var key = "F612190920";
	var from = 'WGS84';
	var to = 'TM128';
	proj4.defs('WGS84', "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs");
	proj4.defs('TM128', '+proj=tmerc +lat_0=38 +lon_0=128 +ellps=bessel +x_0=400000 +y_0=600000 +k=0.9999 +towgs84=-146.43,507.89,681.46 +units=m +no_defs');
	var map;
	var position= [];

  $(document).ready(function(){
// 	    loadData();
	    ready();
	});
  function movemap(x,y){
		console.log(x+" "+ y);
      map.setCenter(new kakao.maps.LatLng(x,y));
  }
  function ready(){
		console.log(typeof(position));
		var container = document.getElementById('map');
		 if(navigator.geolocation){
			navigator.geolocation.getCurrentPosition(function(position) {
				var x = position.coords.latitude;
			    var y = position.coords.longitude;
			    var options = { //지도를 생성할 때 필요한 기본 옵션
			           center: new kakao.maps.LatLng(x, y), //지도의 중심좌표.
			           level: 6 //지도의 레벨(확대, 축소 정도)
			        };
	
			    map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
			    // 마커가 표시될 위치입니다
			    var icon = new kakao.maps.MarkerImage(
			              "https://image.flaticon.com/icons/svg/106/106128.svg",
			              new kakao.maps.Size(31,35),
			              new kakao.maps.Point(13,34)
			    );
		
			    var markerPosition  = new kakao.maps.LatLng(x, y);
		
			    // 마커를 생성한 후 마커가 지도 위에 표시되도록 설정합니다
			   	new kakao.maps.Marker({
			              position: markerPosition,
			              image: icon
			              }).setMap(map);
			    var geocoder = new kakao.maps.services.Geocoder();
				console.log(x+" " +y);
				var xy = [y,x];
				var result = proj4(from, to, xy);
				console.log(result) // result: [ 324317.673778079, 547700.4604186672 ]
				
				var coord = new kakao.maps.LatLng(x, y);	
			    $.ajax({
			      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
				      contentType: "application/json; charset=utf-8", 
				      data: {'requesturl': "http://www.opinet.co.kr/api/aroundAll.do?code=" +key+ "&&x=+"+result[0]+"&y="+result[1]+"&radius=5000&sort=2&prodcd=B027&out=json"}, //HTTP 요청과 함께 서버로 보낼 데이터 
				      method: "GET" //HTTP 요청 메소드
				})
				.done(function(res){
					console.log(res);
			          var arr = res.RESULT.OIL;
			          var length = arr.length<10?arrlength:10;
			          for(var a =0; a<length; a++){
			            var stationinfo = new Object();
			            stationinfo.title = arr[a].OS_NM;
			            var reprojectedCoords = proj4(to, from, [arr[a].GIS_X_COOR,arr[a].GIS_Y_COOR]);
			            stationinfo.latlng = new kakao.maps.LatLng(reprojectedCoords[1],reprojectedCoords[0]);
			            console.log(stationinfo);
			            position[a] = stationinfo;
			            var elem = document.createElement('li');
			            elem.innerHTML = '<a style="cursor:pointer" onclick="movemap(' + reprojectedCoords[1] +','+reprojectedCoords[0] +');">'+stationinfo.title+'</a>';
			            document.getElementById('mlist').appendChild(elem);

			          }
			          var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			          for (var i in position) {
			              // console.log(this.position[i]);
			              // 마커 이미지의 이미지 크기 입니다
			              var imageSize = new kakao.maps.Size(24, 35); 
			              
			              // 마커 이미지를 생성합니다    
			              var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			              
			              // 마커를 생성합니다
			              
			              // var customOverlay = new daum.maps.CustomOverlay(
			              // {
			              //   map : map,
			              //   position : this.position[i].latlng,
			              //   content : this.position[i].title,	
			              //   yAnchor : 1
			              // });
			              // console.log(this.position[i].latlng)
			              var marker = new kakao.maps.Marker({
			                  map: map, // 마커를 표시할 지도
			                  position: position[i].latlng, // 마커를 표시할 위치
			                  title : position[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			                  image : markerImage // 마커 이미지
			              });
			          }
				});
			});
		}	
	}
	function loadData()
	{	
		var lowTop10 ={};
	    $.ajax({
		      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
		      contentType: "application/json; charset=utf-8", 
		      data: {'requesturl': "http://www.opinet.co.kr/api/lowTop10.do?out=json&code="+key+"8&prodcd=B027" }, //HTTP 요청과 함께 서버로 보낼 데이터 
		      method: "GET" //HTTP 요청 메소드
		})
		.done(function(res){
			lowTop10.gasoline = res.RESULT.OIL;
		    $.ajax({
			      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
			      contentType: "application/json; charset=utf-8", 
			      data: {'requesturl': "http://www.opinet.co.kr/api/lowTop10.do?out=json&code="+key+"&prodcd=D047" }, //HTTP 요청과 함께 서버로 보낼 데이터 
			      method: "GET" //HTTP 요청 메소드
			})
			.done(function(res){
				lowTop10.diesel = res.RESULT.OIL;
			    $.ajax({
				      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
				      contentType: "application/json; charset=utf-8", 
				      data: {'requesturl': "http://www.opinet.co.kr/api/lowTop10.do?out=json&code="+key+"&prodcd=B034" }, //HTTP 요청과 함께 서버로 보낼 데이터 
				      method: "GET" //HTTP 요청 메소드
				})
				.done(function(res){
					lowTop10.finegasoline = res.RESULT.OIL;
				    $.ajax({
					      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
					      contentType: "application/json; charset=utf-8", 
					      data: {'requesturl': "http://www.opinet.co.kr/api/lowTop10.do?out=json&code="+key+"&prodcd=K015" }, //HTTP 요청과 함께 서버로 보낼 데이터 
					      method: "GET" //HTTP 요청 메소드
					})
					.done(function(res){
						lowTop10.lpg = res.RESULT.OIL;
					    data.lowTop10 = lowTop10;
					    $.ajax({
						      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
						      contentType: "application/json; charset=utf-8", 
						      data: {'requesturl': "http://www.opinet.co.kr/api/avgLastWeek.do?code="+key+"&out=json" }, //HTTP 요청과 함께 서버로 보낼 데이터 
						      method: "GET" //HTTP 요청 메소드
						})
						.done(function(res){
							data.avgLastWeek = res.RESULT.OIL;
							$.ajax({
							      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
							      contentType: "application/json; charset=utf-8", 
							      data: {'requesturl': "http://www.opinet.co.kr/api/avgRecentPrice.do?out=json&code="+key}, //HTTP 요청과 함께 서버로 보낼 데이터 
							      method: "GET" //HTTP 요청 메소드
							})
							.done(function(res){
								data.sevendays = res.RESULT.OIL;
								$.ajax({
								      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
								      contentType: "application/json; charset=utf-8", 
								      data: {'requesturl': "http://www.opinet.co.kr/api/avgSidoPrice.do?out=json&code="+key}, //HTTP 요청과 함께 서버로 보낼 데이터 
								      method: "GET" //HTTP 요청 메소드
								})
								.done(function(res){
									data.sido = res.RESULT.OIL;
									$.ajax({
									      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
									      contentType: "application/json; charset=utf-8", 
									      data: {'requesturl': "http://www.opinet.co.kr/api/avgSidoPrice.do?out=json&code="+key}, //HTTP 요청과 함께 서버로 보낼 데이터 
									      method: "GET" //HTTP 요청 메소드
									})
									.done(function(res){
										data.sido = res.RESULT.OIL;
										//시군구별 일단 PASS API요청횟수 초과날거임
										http://www.opinet.co.kr/api/avgAllPrice.do?out=xml&code=XXXXXX
											$.ajax({
											      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
											      contentType: "application/json; charset=utf-8", 
											      data: {'requesturl': "http://www.opinet.co.kr/api/avgSidoPrice.do?out=json&code="+key}, //HTTP 요청과 함께 서버로 보낼 데이터 
											      method: "GET" //HTTP 요청 메소드
											})
											.done(function(res){
												data.sido = res.RESULT.OIL;
												//시군구별 일단 PASS API요청횟수 초과날거임
												
												$.ajax({
												      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
												      contentType: "application/json; charset=utf-8", 
												      data: {'requesturl': "http://www.opinet.co.kr/api/avgAllPrice.do?out=json&code="+key}, //HTTP 요청과 함께 서버로 보낼 데이터 
												      method: "GET" //HTTP 요청 메소드
												})
												.done(function(res){
													data.avgprice = res.RESULT.OIL;
													
												});	
											});		
									});
								});
							});
						});
					});
				});
			});
		});

	    
		console.log(data);
	}

  </script>

</body>
</html>
</layoutTag:layout>
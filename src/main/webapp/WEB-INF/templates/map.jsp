<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
<title>Demo</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" href="css/dashBoard.css">

<style type="text/css">
.임시클래스{
 border:1px solid black;
}

.navbar{
	margin-bottom:20px;
}
</style>
</head>
 <body>
<nav class="navbar navbar-expand-md bg-dark navbar-dark">
  <a class="navbar-brand" href="#">Oil Navigation(가제)</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
   <ul class="navbar-nav">
		<li class="nav-item dropdown">
		  <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
		    Back To Home
		  </a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="/">Home</a>
		    <a class="dropdown-item" href="/about">About</a>
		    <a class="dropdown-item" href="/contact">Contact</a>
		  </div>
		</li>
		
		<li class="nav-item">
		  <a class="nav-link" href="/map">Map</a>
		</li>    
		<li class="nav-item">
		  <a class="nav-link" href="/dashBoard">GasStation Info</a>
		</li>    
	</ul>
  </div>  
</nav>

	<div class="container">
	    <div class="row">
	        <div class="col-md-6 임시클래스">가격순 top10,거리순 top10, 최적순 top10</div>
	        <div class="col-md-6 임시클래스">주유소 상세정보</div>
	        <div id="map" class="col-md-12 임시클래스" style="min-height:500px">
	        </div>
	    </div>
	</div>
	
	
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d47821d08c14a3b647e14eafa6ab215&libraries=services"></script>
	<script>
		 var container = document.getElementById('map');
		 if(navigator.geolocation){
			navigator.geolocation.getCurrentPosition(function(position) {
			var x = position.coords.latitude;
		    var y = position.coords.longitude;
			var options = { //지도를 생성할 때 필요한 기본 옵션
		           center: new kakao.maps.LatLng(x, y), //지도의 중심좌표.
		           level: 4 //지도의 레벨(확대, 축소 정도)
		        };

		    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
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

		    var coord = new kakao.maps.LatLng(x, y);
		    
			geocoder.coord2Address(coord.getLng(), coord.getLat(), function(result, status) {
		    	console.log(result)
				if (status === kakao.maps.services.Status.OK) {
				    var area_name = result[0].address.region_1depth_name;
				    $.ajax({
				      url: "/change/code", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
				      contentType: "application/json; charset=utf-8", 
				      data: {'area_name': area_name }, //HTTP 요청과 함께 서버로 보낼 데이터 
				      method: "GET", //HTTP 요청 메소드
				      sucess:function(res){
				    	  console.log(res)
				      },
				      error:function(err){
				    	  console.log(err);
				      }
				    })
				    
				}
			});
		 });
		}
</script>

</body>
</html>
</layoutTag:layout>
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
	        <div class="col-md-6 임시클래스">가격순 top10,거리순 top10, 최적순 top10</div>
	        <div class="col-md-6 임시클래스">주유소 상세정보</div>
	        <div id="map" class="col-md-12 임시클래스" style="min-height:500px"></div>
	        <div id="result">result</div>
	    </div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>
	<script>
		var menu = document.getElementById("menu");
		menu.className="nav-link dropdown-toggle active";
	</script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d47821d08c14a3b647e14eafa6ab215&libraries=services"></script>
	<script  type="text/javascript">
	$(document).ready(function(){
		ready();			
	});
	var KPL = 0;
	function ready(){
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
		  			$.ajax({
		  				url:'/loginCheck',
		  			    method: "GET"
		  			})
		  			.done(function(res){
		  				console.log(res);
		  				if(res.email != null){
		  					//로그인했을때
				  			$.ajax({
				  				url:'/getKPL',
				  			    method: "GET"
				  			})
				  			.done(function(res){
				  				KPL = res;
		    					console.log(KPL);
				  			});
		  				}else{
		  					//로그인 안했을때
		  				}
		  			});
		  			console.log(KPL);
				}
		 	});
			});
		}	
	}
</script>

</body>
</html>
</layoutTag:layout>
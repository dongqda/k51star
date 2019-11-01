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
	        
<div class="col-md-6 임시클래스" onclick="sort('PRICE')">가격순 top10</div>
<div class="col-md-6 임시클래스" onclick="sort('DISTANCE')">거리순 top10</div>
<div class="col-md-6 임시클래스" onclick="sort('COST')">최적순 top10</div>
	        <div class="col-md-6 임시클래스">주유소 상세정보
	        	<ul id="mlist"></ul>
	        </div>
	        <div id="map" class="col-md-12 임시클래스" style="min-height:500px"></div>
	    </div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>
	<script>
		var menu = document.getElementById("menu");
		menu.className="nav-link dropdown-toggle active";
	</script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d47821d08c14a3b647e14eafa6ab215&libraries=services"></script>
	<script  type="text/javascript">
	var key = "F612190920";
	//var key = "F632191018";
	var from = 'WGS84';
	var to = 'TM128';
	proj4.defs('WGS84', "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs");
	proj4.defs('TM128', '+proj=tmerc +lat_0=38 +lon_0=128 +ellps=bessel +x_0=400000 +y_0=600000 +k=0.9999 +towgs84=-146.43,507.89,681.46 +units=m +no_defs');
	var map;
	var headers = {}; 
	headers["appKey"]="6abd255e-4445-4c51-953e-eda3e6496d22";
	var nowx;
	var nowy;
	var stationList={};
	var KPL = 10;
	var fuel="B027";
	var oilList={
			"휘발유" : "B027", 
			"경유" : "D047",
			"LPG" : "K015",
			"전기+휘발유":"B027",
			};
	var requesturl ;
	
	$(document).ready(function(){
		ready();			
	});
	function ready(){
		var container = document.getElementById('map');
		 if(navigator.geolocation){
			navigator.geolocation.getCurrentPosition(function(position) {
				nowx = position.coords.latitude;
				nowy = position.coords.longitude;
				var options = { //지도를 생성할 때 필요한 기본 옵션
			           center: new kakao.maps.LatLng(nowx, nowy), //지도의 중심좌표.
			           level: 4 //지도의 레벨(확대, 축소 정도)
			        };
	
			    map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
			    // 마커가 표시될 위치입니다
			    var icon = new kakao.maps.MarkerImage(
			              "https://image.flaticon.com/icons/svg/106/106128.svg",
			              new kakao.maps.Size(31,35),
			              new kakao.maps.Point(13,34)
			    );
		
			    var markerPosition  = new kakao.maps.LatLng(nowx, nowy);
			    
			    var xy = [nowy,nowx];
				var result = proj4(from, to, xy);
			    // 마커를 생성한 후 마커가 지도 위에 표시되도록 설정합니다
			   	new kakao.maps.Marker({
			   		position: markerPosition,
			   		image: icon
			   		}).setMap(map);
	
			    $.ajax({
				  url:'/loginCheck',
				  method: "GET",
				  async : false,
				})
				.done(function(res){
				  	if(res.email != null){//로그인했을때
						$.ajax({
						  	url:'/getCarinfo',
						  	 method: "GET",
						  	 async : false
						 })
						 .done(function(res){
							 if(res.ct != 0){
								 fuel=oilList[res.fuel];
								 KPL=res.kpl;
							 }
							 requesturl ="http://www.opinet.co.kr/api/aroundAll.do?code=" +key+ "&x=+"+result[0]+"&y="+result[1]+"&radius=5000&sort=1&prodcd="+fuel+"&out=json"
						 })
				  	}else{
				  		requesturl= "http://www.opinet.co.kr/api/aroundAll.do?code=" +key+ "&x=+"+result[0]+"&y="+result[1]+"&radius=5000&sort=1&prodcd="+fuel+"&out=json"
				  	}
				})
				.always(function(){
					$.ajax({
						url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
						contentType: "application/json; charset=utf-8", 
						data: {'requesturl': requesturl}, //HTTP 요청과 함께 서버로 보낼 데이터 
						method: "GET" //HTTP 요청 메소드
					})
					.done(function(res){
						console.log(res.RESULT.OIL);
						 stationList = res.RESULT.OIL;
				      	
				         for(var a in stationList){
				            var reprojectedCoords = proj4(to, from, [stationList[a].GIS_X_COOR,stationList[a].GIS_Y_COOR]);
	            			
					        var cost = 20*stationList[a].PRICE+((stationList[a].DISTANCE/1000)/KPL)*stationList[a].PRICE;
					        stationList[a].COST = cost;
				          }
					});	
				});
			});
		 }
	}
	function sort(sortingField){
		stationList.sort(function(a,b){
        	 return a[sortingField] -b[sortingField];
        });
		showList();
	}
	function showList(){
		position=[];
		var length = stationList.length>10?10:stationList.length;
		document.getElementById('mlist').innerHTML='';
		for(var index =0; index<length; index++){
			 var stationinfo = new Object();
			 stationinfo.title = stationList[index].OS_NM;
			 var reprojectedCoords = proj4(to, from, [stationList[index].GIS_X_COOR,stationList[index].GIS_Y_COOR]);
             stationinfo.latlng = new kakao.maps.LatLng(reprojectedCoords[1],reprojectedCoords[0]);
             position[index] = stationinfo;
             
			 var elem = document.createElement('li');
			 var liItem = document.createElement('a');
	         liItem.setAttribute('style',"cursor:pointer");
	         liItem.setAttribute('onclick',"movemap('"+index+"');");
	         liItem.innerText=stationinfo.title;
	         elem.appendChild(liItem);
	         document.getElementById('mlist').appendChild(elem);
		}
		
		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
        for (var i in position) {
             // 마커 이미지의 이미지 크기 입니다
             var imageSize = new kakao.maps.Size(24, 35); 
             
             // 마커 이미지를 생성합니다    
             var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
             
             // 마커를 생성합니다
             var marker = new kakao.maps.Marker({
                 map: map, // 마커를 표시할 지도
                 position: position[i].latlng, // 마커를 표시할 위치
                 title : position[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
                 image : markerImage // 마커 이미지
             });
         }
	}
	function movemap(a){
		console.log(stationList[a]);
		var reprojectedCoords = proj4(to, from, [stationList[a].GIS_X_COOR,stationList[a].GIS_Y_COOR]);
	    map.setCenter(new kakao.maps.LatLng(reprojectedCoords[1],reprojectedCoords[0]));
	}

</script>

</body>
</html>
</layoutTag:layout>
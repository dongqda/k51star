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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9234e36a207c8d4f664ad499c1f69d08&libraries=services"></script>
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
	var overlay =new kakao.maps.CustomOverlay({});
	
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
             });
             
          	// 마커에 click 이벤트를 등록합니다
            kakao.maps.event.addListener(marker, 'click', showMarker(marker));
         }
	}
	function showMarker(marker){
		return function(){
			closeOverlay();
			var id = marker.pd.id;
			id = parseInt(id.substring(id.length-1,id.length),16)-1;
			var reprojectedCoords = proj4(to, from, [stationList[id].GIS_X_COOR,stationList[id].GIS_Y_COOR]);
		    var	iwPosition = new kakao.maps.LatLng(reprojectedCoords[1],reprojectedCoords[0]); //인포윈도우 표시 위치입니다
			var content = '<div class="wrap">' + 
	          '    <div class="info">' + 
	          '        <div class="title">' + 
	          				stationList[id].OS_NM +
	          '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
	          '        </div>' + 
	          '        <div class="body">' + 
	          '            <div class="desc">' + 
	          '                <div class="ellipsis"> 가격 : '+ 
	          					stationList[id].PRICE +
	          '                <div><a onclick="goStation('+
	        		  			id+
	          ')" target="_blank" class="link">여기로 안내하기</a></div>' + 
	          '            </div>' + 
	          '        </div>' + 
	          '    </div>' +    
	          '</div>';
			 overlay =new kakao.maps.CustomOverlay({
			        content: content,
			    	map:map,
			        position : iwPosition, 
			    });
		}
	}
	function movemap(a){
		closeOverlay();
		var reprojectedCoords = proj4(to, from, [stationList[a].GIS_X_COOR,stationList[a].GIS_Y_COOR]);
	    var	iwPosition = new kakao.maps.LatLng(reprojectedCoords[1],reprojectedCoords[0]); //인포윈도우 표시 위치입니다
	    	// 커스텀 오버레이에 표시할 컨텐츠 입니다
	    	// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
	    	// 별도의 이벤트 메소드를 제공하지 않습니다 
	    var content = '<div class="wrap">' + 
	    	          '    <div class="info">' + 
	    	          '        <div class="title">' + 
	    	          				stationList[a].OS_NM +
	    	          '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
	    	          '        </div>' + 
	    	          '        <div class="body">' + 
	    	          '            <div class="desc">' + 
	    	          '                <div class="ellipsis"> 가격 : '+ 
	    	          					stationList[a].PRICE +
	    	          '                <div><a  onclick="goStation('+a+')" target="_blank" class="link">여기로 안내하기</a></div>' + 
	    	          '            </div>' + 
	    	          '        </div>' + 
	    	          '    </div>' +    
	    	          '</div>';
	    map.setCenter(iwPosition);
	 	// 인포윈도우를 생성하고 지도에 표시합니다
	    overlay =new kakao.maps.CustomOverlay({
	        content: content,
	    	map:map,
	        position : iwPosition, 
	    });
	}

 	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
	function closeOverlay() {
	    overlay.setMap(null);     
    }
 	
 	Kakao.init('9234e36a207c8d4f664ad499c1f69d08');
 	function goStation(id){
 		console.log(stationList[id]);
		var reprojectedCoords = proj4(to, from, [stationList[id].GIS_X_COOR,stationList[id].GIS_Y_COOR]);
        Kakao.Navi.start({
            name: stationList[id].OS_NM,
            x: reprojectedCoords[0],
            y: reprojectedCoords[1],
            coordType: 'wgs84'
        });

 	}
</script>
</body>
<style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
</style>
</html>
</layoutTag:layout>
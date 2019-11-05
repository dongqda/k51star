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
.oilInfo_p{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 200px;
  height: 30px;
}
</style>
</head>
<body class="text-center">
<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
   <jsp:include page="header.jsp"></jsp:include>
   <div class="container map_wrap">
           <div class="row ">
           <div id="map" class="col-sm-12" style="width:100%;min-height:500px;position:relative;overflow:hidden;"></div>
         <div class="col-sm-12 desktopHidden">
            <div class="card ">
               <div class="card-header" style="background: #444">
                  <ul class="nav nav-tabs card-header-tabs pull-right"  id="myTab" role="tablist">
                     <li class="nav-item">
                        <a style="padding: 10px;" class="nav-link active" id="home-tab" data-toggle="tab" href="#tab" role="tab" aria-controls="tab" aria-selected="true" onclick="sort('PRICE')">가격 Top10</a>
                     </li>
                     <li class="nav-item">
                        <a style="padding: 10px;" class="nav-link" id="profile-tab" data-toggle="tab" href="#tab" role="tab" aria-controls="tab" aria-selected="false" onclick="sort('DISTANCE')">거리 Top10</a>
                     </li>
                     <li class="nav-item">
                        <a style="padding: 10px;" class="nav-link" id="contact-tab" data-toggle="tab" href="#tab" role="tab" aria-controls="tab" aria-selected="false" onclick="sort('COST')">최적 Top10</a>
                     </li>
                  </ul>
               </div>
               <div class="card-body">
                  <div class="tab-content" id="myTabContent">
                     <div class="tab-pane fade show active" style="background: none;" id="tab" role="tabpanel" aria-labelledby="tab-tab">
                            <div class="card">
                              <ul class="list-group list-group-flush" id="mlist" style="=list-style: none;"></ul>
                            </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
            <div id="menu_wrap" class="bg_white mobileHidden" >
              <div class="option">
                  <div>
                          <button onclick="sort('PRICE')">가격</button> 
                          <button onclick="sort('DISTANCE')">거리</button> 
                          <button onclick="sort('COST')">최적</button> 
                  </div>
              </div>
              <hr>
              <ul id="placesList"></ul>
          </div>
      </div>
   <jsp:include page="footer.jsp"></jsp:include>
   </div>
</div>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9234e36a207c8d4f664ad499c1f69d08&libraries=services"></script>
   <script  type="text/javascript">
   Kakao.init('9234e36a207c8d4f664ad499c1f69d08');

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
   var markers = [];
   
   $(document).ready(function(){
      ready();
   });
   function ready(){
      var container = document.getElementById('map');
       if(navigator.geolocation){
         navigator.geolocation.getCurrentPosition(function(position) {
            nowx = position.coords.latitude;
            nowy = position.coords.longitude;
            var container = document.getElementById('map'), // 지도를 표시할 div 
               options = { //지도를 생성할 때 필요한 기본 옵션
                    center: new kakao.maps.LatLng(nowx, nowy), //지도의 중심좌표.
                    level: 4 //지도의 레벨(확대, 축소 정도)
                 };
   
             map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
             kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
           	    closeOverlay();
           	    console.log("click event call! ");
           	});
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
      displayPlaces();
   }
   
   // 검색 결과 목록과 마커를 표출하는 함수입니다
   function displayPlaces() {
       var listEl = document.getElementById('placesList'), 
       menuEl = document.getElementById('menu_wrap'),
       fragment = document.createDocumentFragment(), 
       bounds = new kakao.maps.LatLngBounds(), 
       listStr = '';
       
       // 검색 결과 목록에 추가된 항목들을 제거합니다
       removeAllChildNods(listEl);

       // 지도에 표시되고 있는 마커를 제거합니다
       removeMarker();
       
       for ( var i=0; i<10; i++ ) {
           var reprojectedCoords = proj4(to, from, [stationList[i].GIS_X_COOR,stationList[i].GIS_Y_COOR]);
           // 마커를 생성하고 지도에 표시합니다
           var placePosition = new kakao.maps.LatLng(reprojectedCoords[1], reprojectedCoords[0]),
               itemEl = getListItem(i, stationList[i]), // 검색 결과 항목 Element를 생성합니다
               marker = addMarker(placePosition, i, stationList[i].OS_NM);

           // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
           // LatLngBounds 객체에 좌표를 추가합니다
           bounds.extend(placePosition);
           fragment.appendChild(itemEl);
       }

       // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
       listEl.appendChild(fragment);
       menuEl.scrollTop = 0;

       // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
       map.setBounds(bounds);
   }
   
   // 검색결과 항목을 Element로 반환하는 함수입니다
   function getListItem(index, places) {
       var el = document.createElement('li');
       el.onclick =function(){
    	   movemap(index);
       };

       var itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                   '<div class="info">' +
                   '   <h5>' + places.OS_NM + '</h5>';

       itemStr += '  <span class="tel">' + places.PRICE  + '원</span>' +
                   '</div>';
                   
         itemStr +='<a style="color: black;padding: 0 10 0 10;" onclick="goStation('+
                  index+        
                   ')" target="_blank" class="link btn btn-lg btn-secondary">여기로 안내하기</a></div>';

       el.innerHTML = itemStr;
       el.className = 'item';
       return el;
   }
   
    function goStation(id){
        if(confirm("네비게이션으로 연결됩니다.") == true){
      var reprojectedCoords = proj4(to, from, [stationList[id].GIS_X_COOR,stationList[id].GIS_Y_COOR]);
        Kakao.Navi.start({
            name: stationList[id].OS_NM,
            x: reprojectedCoords[0],
            y: reprojectedCoords[1],
            coordType: 'wgs84'
        });
        
        }
    }

   
   // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
   function addMarker(position, idx,title) {
       var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
           imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
           imgOptions =  {
               spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
               spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
               offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
           },
           markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
               marker = new kakao.maps.Marker({
               position: position, // 마커의 위치
               image: markerImage,
               title: title
           });

       kakao.maps.event.addListener(marker, 'click', showMarker(marker));
       marker.setMap(map); // 지도 위에 마커를 표출합니다
       markers.push(marker);  // 배열에 생성된 마커를 추가합니다

       return marker;
   }
	function showMarker(marker){
		return function(){
			closeOverlay();
// 			var id = marker.pd.id;
// 			id = parseInt(id.substring(id.length-1,id.length),16)-1;
			console.log(marker.mc);
			var markerinfo;
			var id;
			for(var i in stationList){
				if(marker.mc == stationList[i].OS_NM){
					markerinfo = stationList[i];
					id = i;
					break;
				}
			}
			var reprojectedCoords = proj4(to, from, [stationList[id].GIS_X_COOR,stationList[id].GIS_Y_COOR]);
		    var	iwPosition = new kakao.maps.LatLng(reprojectedCoords[1],reprojectedCoords[0]); //인포윈도우 표시 위치입니다
			var content = '<div class="wrap">' + 
	          '    <div class="info" style="border: none;padding: 5px;background:#333">' + 
	          '        <div class="title" style="background: #333;"><p class="oilInfo_p">' + 
	          markerinfo.OS_NM +
	          '            </p><div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
	          '        </div>' + 
	          '        <div class="body" style="padding: 10px;background:#333">' + 
	          '            <div class="ellipsis" style="font-size: 20px;"> 가격 : '+ 
	          markerinfo.PRICE +
			  '				<div><a style="color: black;padding: 0 10 0 10;" onclick="goStation('+
			  					id+		  
	          '				)" target="_blank" class="link btn btn-lg btn-secondary">여기로 안내하기</a></div>' + 
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
	    	          '    <div class="info" style="border: none;padding: 5px;background:#333">' + 
	    	          '        <div class="title" style="background: #333;"><p class="oilInfo_p">' + 
	    	          				stationList[a].OS_NM +
	    	          '            </p><div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
	    	          '        </div>' + 
	    	          '        <div class="body" style="padding: 10px;background:#333">' + 
	    	          '            <div class="desc">' + 
	    	          '                <div class="ellipsis" style="font-size: 20px;"> 가격 : '+ 
	    	          					stationList[a].PRICE +
	    	          '                <div><a style="color: black;padding: 0 10 0 10;"  onclick="goStation('+a+')" target="_blank" class="link btn btn-lg btn-secondary">여기로 안내하기</a></div>' + 
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


    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
   function removeAllChildNods(el) {   
       while (el.hasChildNodes()) {
           el.removeChild (el.lastChild);
       }
   }
	function closeOverlay() {
	    overlay.setMap(null);     
    }
   // 지도 위에 표시되고 있는 마커를 모두 제거합니다
   function removeMarker() {
       for ( var i = 0; i < markers.length; i++ ) {
           markers[i].setMap(null);
       }   
       markers = [];
   }
</script>
</body>
 <style>
 .info h5 {color : black; font-weight: bold;}
.info {opacity:0.7;}
.info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>
</html>
</layoutTag:layout>
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
.임시클래스 {
	border: 1px solid black;
}

.navbar {
	margin-bottom: 20px;
}
</style>
</head>
<body class="text-center">
	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
		<jsp:include page="header.jsp"></jsp:include>
		<div class="container">
			<div class="row">
				<div class="col-md-6임시클래스">
					<canvas id="myChart" width="400" height="400"></canvas>
				</div>
				<div class="col-md-6 임시클래스">최근 1주간 주간 평균가
					<div id="avgWeek"></div>
				</div>
				<div class="col-md-6 임시클래스">시도별 주유소 평균가격(현재)
					<div class="  slideshow-container" id="container"></div>
				</div>	
				<div class="col-md-6 임시클래스">전국 /지역별 최저가 주유소(고급휘발유)
					<div id="finegasoline"></div>
				</div>
				<div class="col-md-6 임시클래스">전국 /지역별 최저가 주유소(휘발유)
					<div id="gasoline"></div>
				</div>
				<div class="col-md-6 임시클래스">전국 /지역별 최저가 주유소(경유)
					<div id="diesel"></div>
				</div>
				<div class="col-md-6 임시클래스">전국 /지역별 최저가 주유소(LPG)
					<div id="lpg"></div>
				</div>
				<div class="col-md-6 임시클래스">주유소 상세정보</div>
			</div>
			<div class="col-md 임시클래스">최근 7일 전국 일일 평균가
				<canvas id="chart_seven" ></canvas>
			</div>
			<div class="row">
				<div id="maplist" class="col-md-6 임시클래스" style="min-height: 500px">
					<ul id="mlist"></ul>
				</div>
				<div id="map" class="col-md-6 임시클래스" style="min-height: 500px"></div>
			</div>

		</div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.3.3/proj4-src.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d47821d08c14a3b647e14eafa6ab215&libraries=services"></script>
	<script>
    	var menu = document.getElementById("menu");
    	menu.className="nav-link dropdown-toggle active";
    </script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.js"></script>
	<script type="text/javascript">

  var data = {};
  var key = "F632191018";
	var from = 'WGS84';
	var to = 'TM128';
	proj4.defs('WGS84', "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs");
	proj4.defs('TM128', '+proj=tmerc +lat_0=38 +lon_0=128 +ellps=bessel +x_0=400000 +y_0=600000 +k=0.9999 +towgs84=-146.43,507.89,681.46 +units=m +no_defs');
	var map;
	var position= [];
	var sido=[];
	var slideIndex = 0;
	var oilList={
		"B027" : "휘발유", 
		"B034" : "고급 휘발유", 
		"C004" : "실내 등유",
		"D047" : "경유",
		"K015" : "LPG",
		"diesel":"경유",
		"finegasoline":"고급 휘발유",
		"gasoline":"휘발유",
		"lpg":"LPG",
		};

  $(document).ready(function(){
 	    loadData();
	    ready();
	});
  var updateChartTicks = function(scale) { 
      var incrementAmount = 0; var previousAmount = 0; var newTicks = []; 
      newTicks = scale.ticks; 
      for (x=0;x<newTicks.length;x++) { 
       incrementAmount = (previousAmount - newTicks[x]); 
       previousAmount = newTicks[x]; 
      } 
      if (newTicks.length > 2) { 
       if (newTicks[0] - newTicks[1] != incrementAmount) { 
        newTicks[0] = newTicks[1] + incrementAmount;      
       } 
      }   
      return newTicks;
     }; 

  function drawSevendays(){
      var ctx = document.getElementById('chart_seven').getContext('2d');
      var days =[];
      var max =0;
      var min =10000;
      for(var i=0 ; i<7;i++){
		days[i] = data.sevendays[i*5].DATE;
		var price = data.sevendays[i*5].PRICE;
		if(max < price) max = price;
		if(min > price) min = price
      }
      var myChart = new Chart(ctx, {
    	    type: 'line',
          data: {
              labels: days,
              datasets: [
              {
                  label: '휘발유',
                  data: [0,0,0,0,0,0,0],
                  backgroundColor: [
                      'rgba(255, 99, 132, 0.2)'
                  ],
                  borderColor: [
                      'rgba(255, 99, 132, 1)'
                  ],
              },
              {
                  label: '고급휘발유',
                  data: [0,0,0,0,0,0,0],
                  backgroundColor: [
                	  'rgba(54, 162, 235, 0.2)'
                  ],
                  borderColor: [
                	  'rgba(54, 162, 235, 1)'
                  ],
              },
              {
                  label: '경유',
                  data: [0,0,0,0,0,0,0],
                  backgroundColor: [
                	  'rgba(255, 206, 86, 0.2)'
                  ],
                  borderColor: [
                	  'rgba(255, 206, 86, 1)'
                  ],
              },
              {
                  label: '등유',
                  data: [0,0,0,0,0,0,0],
                  backgroundColor: [
                	  'rgba(75, 192, 192, 0.2)'
                  ],
                  borderColor: [
                	  'rgba(75, 192, 192, 1)'
                  ],
              },
              {
                  label: 'LPG',
                  data: [0,0,0,0,0,0,0],
                  backgroundColor: [
                	  'rgba(153, 102, 255, 0.2)'
                  ],
                  borderColor: [
                	  'rgba(153, 102, 255, 1)'
                  ],
              }
              ]
          },
          options: {
        	  tooltips: {
        	      mode: null
        	    },
              scales: {
            	  yAxes: [{ 
                      afterBuildTicks: function(scale) { 
                       scale.ticks = updateChartTicks(scale); 
                       return; 
                      }, 
                      beforeUpdate: function(oScale) { 
                       return; 
                      }, 
                      ticks: {  
                       beginAtZero:false, 
                       maxTicksLimit: 10 
                      } 
                     }] 
              },
              onClick: function(evt, activeElements) {

              }
          }
      });
      var comp_data = myChart.data.datasets[0].data;
      var comp_data2 = myChart.data.datasets[1].data;
      var comp_data3 = myChart.data.datasets[2].data;
      var comp_data4 = myChart.data.datasets[3].data;
      var comp_data5 = myChart.data.datasets[4].data;

      for(var i=0 ; i<7;i++){
    	  for(var j=0; j<5; j++){
    		  if(j==0){
		         comp_data[i] =  data.sevendays[i*5+j].PRICE;
    		  }else if(j==1){
 		         comp_data2[i] =  data.sevendays[i*5+j].PRICE;
    		  }else if(j==2){
  		         comp_data3[i] =  data.sevendays[i*5+j].PRICE;
    		  }else if(j==3){
  		         comp_data4[i] =  data.sevendays[i*5+j].PRICE;
    		  }else if(j==4){
  		         comp_data5[i] =  data.sevendays[i*5+j].PRICE;
    		  }
    	  }
      }
      
	  myChart.getDatasetMeta(1).hidden=true;
	  myChart.getDatasetMeta(2).hidden=true;
      myChart.getDatasetMeta(3).hidden=true;
      myChart.getDatasetMeta(4).hidden=true;
      myChart.update();
	}
  
  function movemap(x,y){
// 		console.log(x+" "+ y);
      map.setCenter(new kakao.maps.LatLng(x,y));
  }
  function ready(){
		var container = document.getElementById('map');
		 if(navigator.geolocation){
			navigator.geolocation.getCurrentPosition(function(position) {
				var x = position.coords.latitude;
			    var y = position.coords.longitude;
			    var options = { //지도를 생성할 때 필요한 기본 옵션
			           center: new kakao.maps.LatLng(x, y), //지도의 중심좌표.
			           level: 6	 //지도의 레벨(확대, 축소 정도)
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
// 				console.log(x+" " +y);
				var xy = [y,x];
				var result = proj4(from, to, xy);
// 				console.log(result) // result: [ 324317.673778079, 547700.4604186672 ]
				
				var coord = new kakao.maps.LatLng(x, y);	
			    $.ajax({
			      url: "/parsing", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소
				      contentType: "application/json; charset=utf-8", 
				      data: {'requesturl': "http://www.opinet.co.kr/api/aroundAll.do?code=" +key+ "&&x=+"+result[0]+"&y="+result[1]+"&radius=5000&sort=2&prodcd=B027&out=json"}, //HTTP 요청과 함께 서버로 보낼 데이터 
				      method: "GET" //HTTP 요청 메소드
				})
				.done(function(res){
			          var arr = res.RESULT.OIL;
			          var length = arr.length<10?arrlength:10;
			          for(var a =0; a<length; a++){
			            var stationinfo = new Object();
			            stationinfo.title = arr[a].OS_NM;
			            var reprojectedCoords = proj4(to, from, [arr[a].GIS_X_COOR,arr[a].GIS_Y_COOR]);
			            stationinfo.latlng = new kakao.maps.LatLng(reprojectedCoords[1],reprojectedCoords[0]);
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
		      data: {'requesturl': "http://www.opinet.co.kr/api/lowTop10.do?out=json&code="+key+"&prodcd=B027" }, //HTTP 요청과 함께 서버로 보낼 데이터 
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
									var index=0;
									while(index<res.RESULT.OIL.length/5){
										var tmp = [];
										for(var j=0;j<5;j++){
											tmp.push(res.RESULT.OIL[5*index+j]);
										}
										sido.push(tmp);
										index+=1;
									}
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
													drawSevendays();
													showSlides();
													drawAvg();
													drawAvgWeek();
													topTenList();
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
	function topTenList(){
		for(var item in data.lowTop10){
			var insert = document.getElementById(item);
			var kategorie = document.createElement("div");
			kategorie.innerText=oilList[item];
			for(var j=0; j<10; j++){
				var top10 = document.createElement("div");
				top10.innerText=data.lowTop10[item][j].OS_NM + " " + data.lowTop10[item][j].PRICE + "원";
				kategorie.appendChild(top10);
			}
			insert.appendChild(kategorie);
		}
	}
	function drawAvgWeek(){
		var container = document.getElementById('avgWeek');
		container.innerHTML="";
		for(var i=0; i<data.avgLastWeek.length; i++){
			var txt=document.createElement("div");
			var key = data.avgLastWeek[i].PRODCD;
			txt.innerText = oilList[key]+ " : " + data.avgLastWeek[i].PRICE;
			container.appendChild(txt);
		}
	}
	function drawAvg(){
        var ctx = document.getElementById('myChart').getContext('2d');
        
        var myChart = new Chart(ctx, {
           
            type: 'bar',
            data: {
                labels: ['고급휘발유', '휘발유', '경유', '등유', 'LPG'],
                datasets: [{
                    label: '#Price',
                    data: [0,0,0,0,0],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true,
                        }
                    }]
                }
            }
        });
        var comp_data = myChart.data.datasets[0].data;
        for(var i=0 ; i<data.avgprice.length;i++){
           comp_data[i] =  data.avgprice[i].PRICE;
        }
        myChart.data.datasets[0].data = comp_data;
        myChart.update();
	}
	
	function showSlides() {
		    var container = document.getElementById("container");
		    container.innerHTML="";
		    for(var index=0; index<sido.length; index++){
		    	var card = document.createElement("div");
		    	card.setAttribute("class","mySlides fade");
		    	
		    	var areanm = document.createElement("div");
		    	areanm.setAttribute("class","numbertext");
		    	areanm.innerText = sido[index][0].SIDONM;
		    	card.appendChild(areanm);
		    	
		    	for(var j=0;j<5;j++){
		    		var text = document.createElement("div");
		    		var key = sido[index][j].PRODCD;
		    		text.setAttribute("calss","text");
		    		text.innerText = oilList[key]+ " : " + sido[index][j].PRICE;
		    		card.appendChild(text);
		    	}
		    	container.appendChild(card);
		    }
		    var slides = document.getElementsByClassName("mySlides");
		    for (var i = 0; i < slides.length; i++) {
		      
		    	slides[i].style.display = "none";  
		    }
		    slideIndex++;
		    if (slideIndex > slides.length) {
		    	slideIndex = 1
		    }    
		    slides[slideIndex-1].style.display = "block";  
		    setTimeout(showSlides,4000); // Change image every 2 seconds
	}
  </script>

</body>
<style>
.mySlides {display: none;}

/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: relative;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 16px;
  padding: 8px 12px;
  position: relative;
  top: 0;
}

/* The dots/bullets/indicators */
.active {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: slidein;
  -webkit-animation-duration: 3.5s;
  animation-name: slidein;
  animation-duration: 4s;
}

@-webkit-keyframes slidein {
  from {opacity: 1} 
  to {opacity: 1}
}

@keyframes slidein {
  from {opacity: 1} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .text {font-size: 11px}
}
</style>
	</html>
</layoutTag:layout>
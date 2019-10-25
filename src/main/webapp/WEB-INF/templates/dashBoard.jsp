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
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>



    <script>
    	var menu = document.getElementById("menu");
    	menu.className="nav-link dropdown-toggle active";
    </script>
  <script type="text/javascript">
  var data = {};
  var key = "F632191018";
  $(document).ready(function(){
	    loadData();
	});
	
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
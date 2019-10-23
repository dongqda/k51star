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
    <div class="row"></div>
    <div class="row">
        <div class="col-md-4 임시클래스" id="avgprice">전국 주유소 평균</div>
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
  <script type="text/javascript">
  var data = {};
  $(document).ready(function(){
	    loadData();
	});
	
	function loadData()
	{	
	    $.ajax({
	        crossOrigin: true,
	        url: "http://www.opinet.co.kr/api/avgAllPrice.do?out=json&code=F632191018",
	 		dataType:"JSON",
	        success: function(data) {
	          console.log(JSON.parse(data));
	        }
	      });

// 	    $.ajax({
// 	    url : "http://www.opinet.co.kr/api/avgAllPrice.do?out=json&code=F632191018"
// 		,crossDomain: true
// 		,type: 'GET'
// 		,dataType:"JSON"
// 		})
//         .done(function(msg) {
//           //console.log(msg);
// 			console.log(msg.RESULT.OIL);
// //     	    document.getElementById('avgprice').innerHTML +="<br>"+ msg;
//         })
//         .fail(function() {
//           alert("fail");
//         });
	}

  </script>


</body>
</html>
</layoutTag:layout>
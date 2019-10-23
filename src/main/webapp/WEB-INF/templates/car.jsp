<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
<title> Car</title>
</head>
<body>
	<div>
	<div class="dropdown">
	  <p class="dropbtn">유종의 미</p>
	  <div id="feulList" class="dropdown-content"></div>
	</div>
	<input type="text" id="search" name="searchCar"/>
	</div>
<script type="text/javascript">
  var oldVal="";
  $(document).ready(function(){
	  $.ajax({
	    	url:'/car/fuel',
		    method: "GET",
	    })
	    .done(function(result){
	    	var selectList = document.getElementById("feulList");
	    	
	        for (var i in result) {
	            var option = document.createElement("sl");
	            option.setAttribute("name", "fuel");
	            option.innerText = result[i];
	            selectList.appendChild(option);
	        }
	    })
  });
  
  	$("#search").on("propertychange change keyup paste input", function() {
	    var currentVal = $(this).val();
	    if(currentVal == oldVal) {
	        return;
	    }
	    oldVal = currentVal;
	    $.ajax({
	    	url:'/car/search',
	    	contentType: "application/json; charset=utf-8", 
		    data: {'car_model': oldVal }, //HTTP 요청과 함께 서버로 보낼 데이터 
		    method: "GET",
	    })
	    .done(function(res){
	    	console.log(res)
	    })
	});
  	
  	$("#fuel").hover(function(){
  		
  	});
	 
  </script>
</body>
<style>
.dropbtn {
  background-color: #4CAF50;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover .dropbtn {background-color: #3e8e41;}
</style>
</html>
</layoutTag:layout>
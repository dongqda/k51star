<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
<title>OIL ODI</title>
</head>
<body>
	<div>
	  	<select name="fuel" id="feulList">
	  		<option  value="default" selected>유종의 미</option>
	  	</select>
		<input type="text" id="search" name="searchCar"/>
	</div>
	<div>----선택한 리스트---</div>
	<div id="selectList"></div>
	<div>----리스트----</div>
	<div id="carList"></div>
<script type="text/javascript">
	var carList=[];
	var selectList=[];
	var oldVal="";

  	$(document).ready(function(){
	  $.ajax({
	    	url:'/car/fuel',
		    method: "GET",
	    })
	    .done(function(result){
	    	var selectList = document.getElementById("feulList");
	    	
	        for (var i in result) {
	            var option = document.createElement("option");
	            option.setAttribute("value",result[i]);
	            option.innerText = result[i];
	            selectList.appendChild(option);
	        }
	    })
  	});
  
  	$("#feulList").on("propertychange change", function(){
  		var fuel = $("select[name=fuel]").val();
		if(fuel=="default"){
			fuel="";
		}
		search(fuel,oldVal);
  	})
  
  	$("#search").on("propertychange keyup paste input", function() {
  		var fuel = $("select[name=fuel]").val();
  		var currentVal = $(this).val();
  		
	    if(currentVal == oldVal) {
	        return;
	    }
	    oldVal = currentVal;
	    
	    if(fuel=="default"){
			fuel="";
		}
	    search(fuel,oldVal);
	});
  	

  	function listshow(){
	  var list = document.getElementById("carList");
	  var slist = document.getElementById("selectList");
	  list.innerHTML="";
	  slist.innerHTML="";
	  for (var i in carList) {
		  var line = document.createElement("p");
		  var el_name = document.createElement("a");
		  el_name.setAttribute("href","#")
		  el_name.setAttribute("style","text-decoration:none")
		  el_name.setAttribute("onclick","listClick(this)")
		  el_name.setAttribute("id",carList[i].car_id);
		  el_name.setAttribute("title",carList[i].manufacturer);
		  el_name.innerText=carList[i].car_model;
		  line.appendChild(el_name);
		  list.appendChild(line);
      }
	  for (var i in selectList) {
		  var line = document.createElement("p");
		  var el_name = document.createElement("a");
// 		  el_name.setAttribute("href","#")
// 		  el_name.setAttribute("style","text-decoration:none")
// 		  el_name.setAttribute("onclick","listClick(this)")
		  el_name.setAttribute("id",selectList[i].car_id);
		  el_name.setAttribute("title",selectList[i].manufacturer);
		  el_name.innerText=selectList[i].car_model;
		  line.appendChild(el_name);
		  slist.appendChild(line);
      }
  	}
  	
  	function listClick(a){
  		var index = carList.findIndex(function(item, i){
  			if(item.car_id == a.id){
  				selectList.push(item);
  			    index = i;
  			    return i;
  			  }
		});
  		if (index !== undefined) carList.splice(index, 1);
  		listshow();
  	}
  	
  	function search(fuel, car_model){
  		if(fuel==""&&car_model==""){
  			carList=[];
  			document.getElementById("carList").innerHTML="";
  		}else{
  			$.ajax({
  				url:'/car/search',
  		    	contentType: "application/json; charset=utf-8", 
  			    data: {
  			    	'fuel': fuel,
  			    	'car_model': car_model,
  			    	}, //HTTP 요청과 함께 서버로 보낼 데이터 
  			    method: "GET",
  			    dataType: "json",
  			})
  			.done(function(res){
  				console.log(res);
  				carList=res;
  				listshow();
  			})
  		}
  	} 
  </script>
</body>
</html>
</layoutTag:layout>
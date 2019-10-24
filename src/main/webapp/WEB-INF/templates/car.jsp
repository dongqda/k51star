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
	<div>----리스트----</div>
	<div id="carList"></div>
<script type="text/javascript">
	var carList=[];
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
			if(oldVal != ""){
				console.log("default고 oldVal이 있음.")
				fuel="";
			}else{
				console.log("default고 oldVal이 없음.")
			}
		}else {
			if(oldVal != ""){
				console.log("default가 아니고 oldVal이 있음.")
			}else{
				console.log("default가 아니고 oldVal이 없음.")
			}
		}
  	})
  
  	$("#search").on("propertychange keyup paste input", function() {
  		var fuel = $("select[name=fuel]").val();
  		var currentVal = $(this).val();
  		
	    if(currentVal == oldVal) {
	        return;
	    }
	    oldVal = currentVal;
	    
	    if(fuel=="default"){
			if(oldVal != ""){
				console.log("default고 oldVal이 있음.")
			}else{
				console.log("default고 oldVal이 없음.")
			}
		}else {
			if(oldVal != ""){
				console.log("default가 아니고 oldVal이 있음.")
			}else{
				console.log("default가 아니고 oldVal이 없음.")
			}
		}
	});

  	function listshow(){
	  var list = document.getElementById("carList");
	  
	  for (var i in carList) {
		  var line = document.createElement("p");
		  var el_name = document.createElement("span");
		  el_name.innerText=carList[i].car_model;
		  line.appendChild(el_name);
		  list.appendChild(line);
      }
  	}
	 
  </script>
</body>
</html>
</layoutTag:layout>
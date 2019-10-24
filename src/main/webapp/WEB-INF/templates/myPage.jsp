<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
<title>OIL ODI</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/main.css">
<script> 
$(document).ready(function(){
  $("#flip").click(function(){
    $("#panel").slideToggle("slow");
  });
});
</script>
<style> 
#panel, #flip {
  padding: 5px;
  text-align: center;
  border: 3px solid white;
}

#panel {
  padding: 50px;
  display: none;
}
</style>
</head>
<body class="text-center">
<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
	<jsp:include page="header.jsp"></jsp:include>
	<main role="main" class="inner cover">
		<div id="flip" class="btn btn-lg btn-secondary" style="width: 100%;margin-bottom:10px">자동차 등록</div>
		<input type="hidden" name="email" value="${user.email}"/>
		<div id="panel" style="margin-bottom:10px;">
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

		</div>
		<form class="form-signin" method="post" action="/updateMember" style="border:3px solid white;padding:50px;">
			<img class="mb-4" src="https://image.flaticon.com/icons/svg/1476/1476715.svg" alt="" width="72" height="72">
			<h1 class="h5 mb-3 font-weight-normal">[${user.name}]님의 마이페이지<br></h1>
			<label for="inputEmail" class="sr-only">Email address</label>
			<input type="email" id="inputEmail" class="form-control" placeholder="Email address" autofocus="autofocus" name="email" value="${user.email}" readonly="readonly" required="required">
			<label for="inputEmail" class="sr-only">Email address</label>
			<input type="text" id="inputName" class="form-control" placeholder="Name" autofocus="autofocus" name="name" value="${user.name}" required="required">
			<label for="inputPassword" class="sr-only">Password</label>
			<input type="password" id="inputPassword" class="form-control" placeholder="Password" name="password" value="" required="required">
			<input type="hidden" name="role" value="ROLE_USER" />
			<input class="blueButton" type="submit" data-toggle="modal" data-target="#myModal2" value="수정완료"/>
			<input class="redButton" type="reset" value="정정"/>
			<hr style="background:white">
			 <a data-toggle="modal" data-target="#myModal1">탈퇴하기</a>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<p class="mt-5 mb-3 text-muted">© 2019</p>
		</form>
		
		
	
		<!-- The Modal1 -->
		<div class="modal fade" id="myModal1">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title" style="color: black;text-shadow: none;">탈퇴 확인</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<p style="color: black;text-shadow: none;">정말 탈퇴하시겠습니까?</p>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="blueButton" data-dismiss="modal" onclick="location.href='/deleteMember'">확인</button>
						<button type="button" class="redButton" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
		<!-- The Modal2 -->
		<div class="modal fade" id="myModal2">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title" style="color: black;text-shadow: none;">회원정보 수정</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<p style="color: black;text-shadow: none;">회원수정이 완료되었습니다.</p>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="blueButton" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
		
	</main>
</div>
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
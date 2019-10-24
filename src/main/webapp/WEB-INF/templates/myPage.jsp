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
		<div id="panel" style="margin-bottom:10px;">
			여기에 자동차 등록을 만들어주세요
			<input type="hidden" name="email" value="${user.email}"/>
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
</body>
</html>
</layoutTag:layout>
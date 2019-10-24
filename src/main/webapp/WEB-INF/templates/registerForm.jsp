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
</head>
<body class="text-center">
<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
	<jsp:include page="header.jsp"></jsp:include>
	<main role="main" class="inner cover">
		<form class="form-signin" method="post" action="/register" style="border:3px solid white;padding:50px;">
			<img class="mb-4" src="https://image.flaticon.com/icons/svg/1476/1476715.svg" alt="" width="72" height="72">
			<h1 class="h3 mb-3 font-weight-normal">Please Sign Up</h1>
			<label for="inputEmail" class="sr-only">Email address</label>
			<input type="email" id="inputEmail" class="form-control" placeholder="Email address" autofocus="autofocus" name="email" >
			<label for="inputEmail" class="sr-only">Email address</label>
			<input type="text" id="inputName" class="form-control" placeholder="Name" autofocus="autofocus" name="name" >
			<label for="inputPassword" class="sr-only">Password</label>
			<input type="password" id="inputPassword" class="form-control" placeholder="Password" name="password" >
			<input type="hidden" name="role" value="ROLE_USER" />
			<div class="checkbox mb-3">
				<label>
					<input type="checkbox" value="remember-me"> Remember me
				</label>
			</div>
			<input class="blueButton" type="submit" value="회원가입"/>
			<input class="redButton" type="button" onclick="location.href='/'" value="취소"/>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<p class="mt-5 mb-3 text-muted">© 2019</p>
		</form>
	</main>
</div>
</body>
</html>
</layoutTag:layout>
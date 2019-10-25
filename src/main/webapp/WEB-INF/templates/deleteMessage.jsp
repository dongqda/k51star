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
<meta http-equiv="refresh" content="5;url=/">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/main.css">
</head>
<body class="text-center">
	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
		<jsp:include page="header.jsp"></jsp:include>

		<main role="main" class="inner cover">
		<h1 class="cover-heading">회원탈퇴 완료</h1>
		<br>
		<p class="lead">그동안 이용해주셔서 감사합니다</p>
		<br>
		<p class="lead">5초후 자동으로 이동합니다</p>
		<br>
		<p class="lead">
			<a href="/" class="btn btn-lg btn-secondary">홈으로</a>
		</p>
		</main>

		<jsp:include page="footer.jsp"></jsp:include>
	</div>

<script>
	var home = document.getElementById("home");
	
	home.className="nav-link active";
</script>

</body>
</html>
</layoutTag:layout>
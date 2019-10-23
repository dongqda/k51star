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
<link rel="stylesheet" href="css/main.css">
</head>
<body class="text-center">
	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
		<jsp:include page="header.jsp"></jsp:include>

		<main role="main" class="inner cover">
		<h1 class="cover-heading">Home</h1>
		<br>
		<p class="lead">좋은 기름 원해요?</p>
		<p class="lead">가깝고 저렴한 기름 원해요?</p>
		<p class="lead">그럼 들어와요.</p>
		<br>
		<p class="lead">
			<a href="/map" class="btn btn-lg btn-secondary">Enter</a>
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
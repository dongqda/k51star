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

</head>
<body class="text-center">
	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
		<jsp:include page="header.jsp"></jsp:include>

		<main role="main" class="inner cover">
		<h1 class="cover-heading">About</h1>
		<br>
		<p class="lead">첫번째, 가장 저렴한 주유소 </p>
		<p class="lead">두번째, 가장 가까운 주유소</p>
		<p class="lead">세번째, 만여개의 DB를 활용 최적 주유소</p>
		<br>
		<p class="lead">
			<a href="/map" class="btn btn-lg btn-secondary">Enter</a>
		</p>
		</main>

		<jsp:include page="footer.jsp"></jsp:include>
	</div>

<script>
	var about = document.getElementById("about");
	about.className="nav-link active";
</script>

</body>
	</html>
</layoutTag:layout>
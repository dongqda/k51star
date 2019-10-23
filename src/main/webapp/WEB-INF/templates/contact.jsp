<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>
	<!DOCTYPE html>
	<html>
<head>
<title>Oil Navigation(가제)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" href="css/main.css">

</head>
<body class="text-center">
	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
		<jsp:include page="header.jsp"></jsp:include>

		<main role="main" class="inner cover">
		<h1 class="cover-heading">Contact</h1>
		<br>
		<p class="lead">dongq 010-9800-7755</p>
		<p class="lead">garden 010-4324-5468</p>
		<p class="lead">beomhyun 010-5324-3239</p>
		<br>
		<p class="lead">
			<a href="/map" class="btn btn-lg btn-secondary">Enter</a>
		</p>
		</main>

		<jsp:include page="footer.jsp"></jsp:include>
	</div>

<script>
	var contact = document.getElementById("contact");
	
	contact.className="nav-link active";
</script>

</body>
	</html>
</layoutTag:layout>
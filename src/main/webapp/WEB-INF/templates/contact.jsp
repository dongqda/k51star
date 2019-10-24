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
		<h1 class="cover-heading">Contact</h1>
		<div class="container">
			<form class="form-signin" method="post" action="/mailSending">
				<div align="center"><!-- 받는 사람 이메일 -->
					<input type="hidden" name="tomail" size="120" style="width:100%" placeholder="상대의 이메일" class="form-control" value="dglee012@naver.com" >
				</div>     
				<div align="center"><!-- 제목 -->
					<input type="text" name="title" size="120" style="width:100%" placeholder="제목을 입력해주세요" class="form-control" >
				</div>
				<p>
					<div align="center"><!-- 내용 --> 
						<textarea name="content" cols="100" rows="12" style="width:100%; resize:none" placeholder="문의사항" class="form-control"></textarea>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</div>
				<p>
				<div align="center">
					<input type="submit" value="메일 보내기" class="btn btn-lg btn-secondary">
				</div>
			</form>
		</div>
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
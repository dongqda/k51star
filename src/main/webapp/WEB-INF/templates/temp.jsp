<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>Oil Navigation(가제)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" href="css/login.css">
</head>
<body>
<jsp:include page="navbar.jsp"></jsp:include>
<div class="login-page">
 	<div class="form">
		<c:url value="/login" var="loginUrl" />
		<form class="login-form" action="${loginUrl}" method="post">
			<c:if test="${param.error != null}">        
				<p>
					Invalid username and password.
				</p>
			</c:if>
			<c:if test="${param.logout != null}">       
				<p>
					You have been logged out.
				</p>
			</c:if>
			<input type="text" id="user_login" name="username" placeholder="Email or Username" autocomplete="off"> 
			<input type="password" id="login_pass" name="password" placeholder="Password" autocomplete="off"> 
			<a onclick="login_eye();">
				<i style="color: white" id="login_eye" class="fa fa-eye-slash fa-lg"></i>
			</a>
			<%--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
			<sec:csrfInput />
			<button>login</button>
			<p class="message">Password forgotton? <a href="#">Request help here</a></p>
	    </form>
	    <div class="alert alert-danger" role="alert">
	     Username or password is wrong!
	  	</div>
	</div>
</div>
</body>
</html>
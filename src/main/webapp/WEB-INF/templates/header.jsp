<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<nav class="navbar navbar-expand-md bg-none navbar-dark ">
	<a class="navbar-brand" href="/"><h3>OIL ODI</h3></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav ml-auto topnav">
			<li class="nav-item">
				<a id="home" class="nav-link" href="/">Home</a>
			</li>
			<li class="nav-item">
				<a id="about" class="nav-link" href="/about">About</a>
			</li>
			<li class="nav-item">
				<a id="contact" class="nav-link" href="/contact">Contact</a>
			</li> 
			<li class="nav-item dropdown">
	        	<a id="menu" class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Menu</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="/map">지도</a>
					<a class="dropdown-item" href="/dashBoard">주유소 정보</a>
				</div>
			</li>
			<!-- 로그인중 -->
			<sec:authorize access="isAuthenticated()">
				<li class="nav-item">
					<form action="/logout" method="post">
						<input type="submit" class="btn btn-lg btn-secondary" value="로그아웃">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					</form>
				</li>
			</sec:authorize>
			<!-- 로그아웃중 -->
			<sec:authorize access="isAnonymous()">
				<li class="nav-item">
					<form style="display: contents" action="/login" method="post">
						<input type="submit" class="btn btn-lg btn-secondary" value="로그인">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</li>
			</sec:authorize>   
		</ul>
	</div>  
</nav>


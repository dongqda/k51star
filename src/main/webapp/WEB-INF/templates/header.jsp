<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<header class="masthead">
	<div class="inner">
		<a class="navbar-brand" href="/"><h3>OIL ODI</h3></a>
		<!-- 로그인중 -->
		<sec:authorize access="isAuthenticated()">
			<form style="display: contents" action="/logout" method="post">
				<input type="submit" class="btn btn-lg btn-secondary" style="padding: .3rem 1rem;margin-bottom: 10px;" value="로그아웃">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</form>
		</sec:authorize>
		<!-- 로그아웃중 -->
		<sec:authorize access="isAnonymous()">
			<form style="display: contents" action="/login" method="post">
				<input type="submit" class="btn btn-lg btn-secondary" style="padding: .3rem 1rem;margin-bottom: 10px;" value="로그인">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</sec:authorize>   
		<nav class="nav nav-masthead justify-content-center">
			<a id="home" class="nav-link" href="/">Home</a>
			<a id="about" class="nav-link" href="/about">About</a>
			<a id="" class="nav-link" href="/contact">Contact</a>
			<a id="menu" class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Menu</a>
			<div class="dropdown-menu">
				<sec:authorize access="isAuthenticated()">
					<a class="dropdown-item" href="/myPage">마이페이지</a>
					<hr style="color:black">
				</sec:authorize>
				<a class="dropdown-item" href="/map">지도</a>
				<a class="dropdown-item" href="/dashBoard">주유소 정보</a>
			</div>
		</nav>
	</div>
</header>

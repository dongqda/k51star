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
	<style type="text/css">
	</style>
	</head>
	<body>
		<h1>test Message</h1>
		<h1>${testMessage}</h1>
	
	</body>
	</html>
</layoutTag:layout>
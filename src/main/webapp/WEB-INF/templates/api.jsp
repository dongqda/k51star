<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="layoutTag" tagdir="/WEB-INF/tags"%>
<layoutTag:layout>
<!DOCTYPE html>
<html>
<head>
<title>OIL ODI </title>
</head>
<body>
	<div>
	<ul>
	</ul>
	</div>
  <script type="text/javascript">
  $(document).ready(function(){
	    loadData();
	});
	      
	function loadData()
	{	
	    $.ajax({
	    url : "http://www.opinet.co.kr/api/lowTop10.do?out=json&code=F632191018&prodcd=B027"
		,crossDomain: true
		,type: 'GET'
		})
        .done(function(msg) {
          console.log(msg);
        })
        .fail(function() {
          alert("fail");
        });
	}

  </script>
<button id = "button"> click</button>
<form action="/logout" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="로그아웃">
</form>


</body>
</html>
</layoutTag:layout>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Yonsei KingDom </title>
</head>
<body>
<form action="Alrert.jsp" method ="POST">
	ID : <input type = "text" name = "adminID"><br>
	Password: <input type = "password" name="adminPassword"><br>
	<input type = "submit" value = "Login">
</form>
<form action="search.jsp">
<input type = "submit" value = "Using without login">
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Yonsei Kingdom</title>
</head>
<body>
<%
	session.removeAttribute("adminID");
	response.sendRedirect("login.jsp");
%>
</body>
</html>
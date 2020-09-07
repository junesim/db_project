<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
<%
	DB login = new DB();
	String ID, password;
	ID = request.getParameter("adminID").toString();
	password = request.getParameter("adminPassword").toString();
	if(login.checkAdmin(ID, password)){
		out.print("연세 왕국에 오신 것을 환영합니다.");
		out.print("<br><form action= 'search.jsp'><input type = 'submit' value = '확인'></form>");
		session.setAttribute("adminID", ID );
	}
	else{
		out.print("ID와 비밀번호가 잘못 되었습니다.");
		out.print("<br><form action= 'login.jsp'><input type = 'submit' value = '다시 로그인 하기'></form>"
				+"<form action= 'search.jsp'><input type = 'submit' value = 'Using without login'></form>");
	}
	login.disconnect();
%>
</body>
</html>
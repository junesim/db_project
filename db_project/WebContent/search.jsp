<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "Project.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Yonsei DataBase</title>
</head>
<body>
<%
	boolean login = true;
	String ID = "비회원";
	try{
		ID = session.getAttribute("adminID").toString();
	}catch(NullPointerException e){
		login = false;
	}
	out.print(ID);
	out.print("<form action = execution.jsp><input type = 'hidden' name = 'types' value = 'hero'>"+
				"<input type = 'submit' value = 'Hero'></form>");
	out.print("<form action = execution.jsp><input type = 'hidden' name = 'types' value = 'item'>"
				+"<input type = 'submit' value = 'Item'></form>");
	out.print("<form action = execution.jsp><input type = 'hidden' name = 'types' value = 'kind'>"
				+"<input type = 'submit' value = 'Kind'></form>");
	out.print("<form action = execution.jsp><input type = 'hidden' name = 'types' value = 'skill'>"
				+"<input type = 'submit' value = 'Skill'></form>");
	out.print("<form action = execution.jsp><input type = 'hidden' name = 'types' value = 'general'>"
				+"<input type = 'submit' value = 'General'></form>");
	out.print("<form action = execution.jsp><input type = 'hidden' name = 'types' value = 'corps'>"
				+"<input type = 'submit' value = 'Corps'></form>");
	out.print("<form action = analize.jsp><input type = \"submit\" value = 'Analize' name = 'option'></form>");
	if(login){	
		out.print("<form action = execution.jsp><input type = 'hidden' name = 'types' value = 'administer'>"
				+"<input type = 'submit' value = 'Administer'></form>");
		out.print("<form action = 'logout.jsp'><input type = 'submit' value = 'Logout' ></form>");		
	}
%>
</body>
</html>
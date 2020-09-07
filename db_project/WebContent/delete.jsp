<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>
	<%
	String pk =  "";
	String attr = "";
	String type = "";
	DB a = new DB();
	String sql = "";
	try{
		type = request.getParameter("type");
		pk = request.getParameter("value");
		attr = request.getParameter("primarykey");
	}catch(NullPointerException e){
		response.sendRedirect("logout.jsp");
	}
	if(type.equals("hero")){
		sql = "UPDATE item set heroID = null where heroID = " + pk;
		a.execute(sql);
		sql = "DELETE FROM " +type +" WHERE id = "+pk;
	}else if(type.equals("skill")){
		sql = "UPDATE HERO set skillname = null where skillname = " + pk;
		a.execute(sql);
		sql = "DELETE FROM " + type + " WHERE name = " + pk;
	}else if(type.equals("kind")){
		sql = "UPDATE general set naturalenemy = null where naturalenemy = " + pk;
		a.execute(sql);
		sql = "UPDATE hero set kindname = null where kindname = " + pk;
		a.execute(sql);
		sql = "DELETE FROM " + type + " WHERE name = " +pk;
	}else if(type.equals("corps")){
		sql = "DELETE FROM commander where namecorps = " + pk;
		a.execute(sql);
		sql = "DELETE FROM " +type +" where name = " + pk;
	}else if(type.equals("general")){
		sql = "DELETE FROM commander where namegeneral = " + pk;
		a.execute(sql);
		sql = "DELETE FROM " +type +" where name = " + pk;
	}else if(type.equals("administer")){
		sql = "DELETE FROM "+type +" where id = " +pk;
	}else if(type.equals("item")){
		sql = "DELETE FROM " + type + " WHERE name = " + pk;
	}
	a.execute(sql);
	sql = "SELECT * FROM " +type; 
	a.connect();
	Statement stmt = a.getStmt();
	ResultSet rs = stmt.executeQuery(sql);
	ResultSetMetaData rsmd = rs.getMetaData();
	out.print("<table border = 1><caption>결과</caption>");
	for(int i = 1; i <= rsmd.getColumnCount();i++){
		out.print("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.print("<tr>");
		for(int i =1; i<=rsmd.getColumnCount();i++){
			out.print("<td>"+rs.getString(i)+"</td>");
		}
		out.print("</tr>");
	}
	a.disconnect(stmt);
	rs.close();
	
%>
<input type = button value = "닫기" onclick = "self.close()">
</body>
</html>
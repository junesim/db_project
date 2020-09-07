<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Correct</title>
</head>
<body>
<%	
	Statement stmt;
	ResultSet rs;
	String type = "";
	String pk= "";
	String attr = "";
	String sql = "";
	DB a = new DB();
	try{
		type = request.getParameter("type");
		pk = request.getParameter("value");
		attr = request.getParameter("primarykey");
	}catch(NullPointerException e){
		out.print("잘못된 경로입니다.");
		response.sendRedirect("search.jsp");
	}
	session.setAttribute("cortypes", type);
	session.setAttribute("corvalue", pk );
	session.setAttribute("corprimarykey", attr );
	if(type.equals("hero")){
%>
<form action = "additional.jsp" id = "x">
	Password : <input type = "password" name = "password"><br>
	Name : <input type = "text" name = "name">
	Age : <input type = "number" name = "age"><br>
	Home : <input type = "text" name = "hometown">
	Kind : <select name = "kindname" form = "x">
				<option value = ""  selected>--선택--</option>
				<% a.connect();
					stmt = a.getStmt();
					sql = "SELECT name FROM kind";
					rs = stmt.executeQuery(sql);
					while(rs.next()){%>
					<option value  = "<%=rs.getString("name")%>"><%out.print(rs.getString("name")); %></option>
				<%
					}
					a.disconnect(stmt);
					%>
					</select><br>
	Skill : <select name = "skillname" form = "x">
				<option value = "" selected>--선택--</option>
				<% a.connect();
					stmt = a.getStmt();
					sql = "SELECT name from skill where name not in " +
							" (select skill.name from skill, hero where "+
							" skill.name = hero.skillname) ";
				    rs = stmt.executeQuery(sql);
				   while(rs.next()){
				%>
				<option value = "<%= rs.getString("name") %>"><%out.print(rs.getString("name")); %></option>
				<%
					}
				   a.disconnect(stmt);
				%>
			</select>
	ATK : <input type = "number" name = "atk"><br>
	DEF : <input type = "number" name = "def">
	CON : <input type = "number" name = "con"><br>
	STR : <input type = "number" name = "str">
	INT : <input type = "number" name = "inte"><br>
	Skill Point: <input type = "number" name = "sp" step = "any">
	<input type = "submit" value = "수정" name = "option">
</form>
<%
	}else if(type.equals("item")){
	%>
<form action = "additional.jsp" id = "x">
	Kind : <input type = "text" name = "kind"><br>
	ATK : <input type = "number" name = "addatk">
	DEF : <input type = "number" name = "adddef"><br>
	STR : <input type = "number" name = "addstr">
	INT : <input type = "number" name = "addint"><br>
	Hero ID : <select  name = "heroid" form = "x">
				<option value = "" selected>--선택--</option>
				<%
					a.connect();
					stmt = a.getStmt();
					rs = stmt.executeQuery("select id from hero");
					while(rs.next()){
				%>
				<option value = "<%= rs.getString("id") %>"><%out.print(rs.getString("id")); %></option>
				<%
					}
					a.disconnect(stmt);
				%>
	</select>
	<input type = "submit" value = "수정" name = "option">
</form>
<%
	}else if(type.equals("kind")){
%>
<form action = "additional.jsp">
	ATK : <input type = "number" name = "addatk" step = "any"><br>
	DEF : <input type = "number" name = "adddef" step = "any">
	STR : <input type = "number" name = "addstr" step = "any"><br>
	INT : <input type = "number" name = "addint" step = "any">
	CON : <input type = "number" name = "addcon" step = "any"><br>
	Skill Point: <input type = "number" name = "addsp" step = "any">
	<input type = "submit" value = "수정" name = "option">
</form>
	<%}else if(type.equals("general")){ %>
<form action = "additional.jsp" id = "x">
		Age : <input type = "number" name = "age"><br>
		ATK : <input type = "number" name = "addatk">
		Speed : <input type = "number" name ="addspeed"><br>
		Morale : <input type = "number" name = "addmorale">
		DEF : <input type = "number" name = "adddef">
		Natural Enemy : <select name = "naturalEnemy" form = "x">
						<option value = "" selected>--선택--</option>
						<% a.connect();
						   stmt = a.getStmt();
						   sql = "SELECT name from kind";
						   rs =  stmt.executeQuery(sql);
						   while(rs.next()){
						%>
						<option value = "<%=rs.getString("name")%>"><%out.print(rs.getString("name"));%></option>
						<%
						   }
						   a.disconnect(stmt);
						%>
						</select>
		Army : <select name = "namecorps" form = "x">
			   <option value = "" selected>--선택--</option>
			   <%
			   		a.connect();
			   		stmt = a.getStmt();
			   		sql = "SELECT name from corps where name not in (select namecorps as name from commander where namegeneral = "+pk+" )";
			   	 	rs =  stmt.executeQuery(sql);
				   while(rs.next()){
			   %>
			   <option value = "<%=rs.getString("name")%>"><%out.print(rs.getString("name"));%></option>
				<%
				  }
				   a.disconnect(stmt);
				%>
				</select>
		<input type = "submit" value = "수정" name = "option">
</form>
<%
	}else if(type.equals("corps")){
%>
<form action = "additional.jsp" id = "x">
		Total Number : <input type = "number" name ="totalnumber">
		ATK : <input type = "number" name = "atk"><br>
		DEF : <input type = "number" name = "def">
		Speed : <input type = "number" name ="speed"><br>
		Morale : <input type = "number" name = "morale">
		General : <select name = "namegeneral" form = "x">
		 <option value = "" selected>--선택--</option>
			   <%
			   		a.connect();
			   		stmt = a.getStmt();
			   		sql = "SELECT name from general where name not in (select namegeneral as name from commander where namecorps = "+pk+" )";
			   	 	rs =  stmt.executeQuery(sql);
				   while(rs.next()){
			   %>
			   <option value = "<%=rs.getString("name")%>"><%out.print(rs.getString("name"));%></option>
				<%
				  }
				   a.disconnect(stmt);
				%>
				</select>
		<input type = "submit" value = "수정" name = "option">
</form>
<% }else if(type.equals("skill")){ %>
<form action = "additional.jsp">
		CON : <input type = "number" name = "addcon">
		SP : <input type = "number" name = "addsp">
		<input type = "submit" value = "수정" name = "option">
</form>
<%}else if(type.equals("administer")){%>
<form action = "additional.jsp">
		Password : <input type = "password" name = "password">
		<input type = "submit" value = "수정" name = "option">
</form>
<% } %>
</body>
</html>
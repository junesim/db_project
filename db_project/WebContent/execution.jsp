<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Yonsei DataBase</title>
</head>
<body>
<%! Statement stmt;
	ResultSet rs;
	DB a = new DB();
	String sql;
	%>
<script type = "text/javascript">
	function selectDiv(value){//select 값에 따라 출력하는 div가 다름
		if(value == 'search'){
			document.getElementById("search").style.display ="block";
			document.getElementById("insert").style.display = "none";
		}else if(value =='insert'){
			document.getElementById("search").style.display = "none";
			document.getElementById("insert").style.display = "block";
		}else{
			document.getElementById("search").style.display = "none";
			document.getElementById("insert").style.display = "none";
		}
	}
</script>
<%
	String ID = "비회원";
	String type = null;
	boolean login = true;
	try{
		ID = session.getAttribute("adminID").toString();
	}catch(NullPointerException e){
		login = false;
	}
	try{
		type = request.getParameter("types").toString();
	}catch(NullPointerException e){
		response.sendRedirect("search.jsp");
	}
	
	session.setAttribute("types",type);
	out.print(ID+"<br>");
	out.print(type +"<br>");
	if(login){
%>
<form action = "admin.jsp">
<div class = "select">
<select class = "formControl" name = "option" id = "option" onChange = "selectDiv(this.value)">
	<option value = '' selected>-- 선택 -- </option>
	<option value = 'search' > 검색 </option>
	<option value = 'insert' > 데이터 추가 </option>
</select>
</div>
</form>
<%
	}else{
%>
<form action = "admin.jsp">
<div class = "select">
<select class = "formControl" name = "option" id = "option" onChange = "selectDiv(this.value)">
	<option value = '' selected>-- 선택 -- </option>
	<option value = 'search' > 검색 </option>
</select>
</div>
</form>		
<%
	}
%>
<form action = "admin.jsp" id = "x"> 
<%
	if(type.equals("hero")){
%>
<div name = "insert" id = "insert" style = "display:none" class = "select">
	ID : <input type = "text" name = "id">
	Password : <input type = "password" name = "password"><br>
	Name : <input type = "text" name = "name">
	Age : <input type = "number" name = "age"><br>
	Home : <input type = "text" name = "hometown">
	Kind : <select name="kindname" form = "x" >
				<option value = "" selected>--선택--</option>
				<% a.connect();
					stmt = a.getStmt();
					sql = "SELECT name FROM kind";
					rs = stmt.executeQuery(sql);
					while(rs.next()){%>
					<option value = "<%=rs.getString("name")%>"><%out.print(rs.getString("name")); %></option>
				<%
					}
					a.disconnect(stmt);
					%>
					</select><br>
	Skill : <select  name = "skillname" form = "x">
				<option value = "" selected>--선택--</option>
				<% a.connect();
					stmt = a.getStmt();
					sql = "SELECT name from skill where name not in " +
							" (select skill.name from skill, hero where "+
							" skill.name = hero.skillname) ";
				    rs = stmt.executeQuery(sql);
				   while(rs.next()){
				%>
				<option value = "<%=rs.getString("name")%>"><%out.print(rs.getString("name")); %></option>
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
	SP : <input type = "number" name = "sp">
	<input type = "submit" value = "Insert" name = "option">
</div>
<div name = "search" id = "search" style = "display:none" class = "select">
	<select form = "x" name = "attr">
		<option value = "" selected>--선택--</option>
		<option value = "id">ID</option>
		<option value = "name">Name</option>
		<option value = "age">Age</opiton>
		<option value = "hometown">Hometown</option>
		<option value = "kind">Kind</option>
		<option value = "skill">Skill</option>
	</select>
	<input type = "text" name = "segtype">
	<input type = "submit" value = "Search" name = "option">
</div>
<% 		
	}else if(type.equals("item")){
%>
<div name = "insert" id = "insert" style = "display:none" class ="select">

	Name : <input type = "text" name = "name">
	Kind : <input type = "text" name = "kind"><br>
	ATK : <input type = "number" name = "addatk">
	DEF : <input type = "number" name = "adddef"><br>
	STR : <input type = "number" name = "addstr">
	INT : <input type = "number" name = "addint"><br>
	Hero ID : <select form = "x" name = "heroid">
				<option value = "" selected>--선택--</option>
				<%
					a.connect();
					stmt = a.getStmt();
					rs = stmt.executeQuery("select id from hero");
					while(rs.next()){
				%>
				<option value = "<%=rs.getString("id") %>"><%out.print(rs.getString("id")); %></option>
				<%
					}
					a.disconnect(stmt);
				%>
	</select>
	<input type = "submit" value = "Insert" name = "option">
</div>
<div name = "search" id = "search" style = "display:none" class ="select">

		<select form = "x" name = "attr">
			<option value = "" selected>--선택--</option>
			<option value = "name">Name</option>
			<option value = "kind">Kind</option>
			<option value = "heroid">Owner</option>
		</select>
	<input type = "text" name = "segtype">
	<input type ="submit" value ="Search" name = "option">	
</div>
<%
	}else if(type.equals("kind")){
%>

<div name = "insert" id = "insert" style = "display:none" class ="select">
	Name : <input type ="text" name = "name">
	ATK : <input type = "number" name = "addatk" step = "any"><br>
	DEF : <input type = "number" name = "adddef" step = "any">
	STR : <input type = "number" name = "addstr" step = "any"><br>
	INT : <input type = "number" name = "addint" step = "any">
	CON : <input type = "number" name = "addcon" step = "any"><br>
	Skill Point: <input type = "number" name = "addsp" step = "any">
	<input type = "submit" value = "Insert" name = "option">
</div>
<div name ="search" id="search" style = "display:none" class = "select">
	Name : <input type = "text" name = "segtype">
	<input type = "submit" value = "Search" name = "option">
</div>

<%
	}else if (type.equals("general")){
%>
	<div name = "insert" id = "insert" style = "display:none" class ="select">
		Name : <input type = "text" name = "name">
		Age : <input type = "number" name = "age"><br>
		ATK : <input type = "number" name = "addatk">
		Speed : <input type = "number" name ="addspeed"><br>
		DEF : <input type = "number"  name = "adddef">
		Morale : <input type = "number" name = "addmorale">
		Natural Enemy : <select form = "x" name = "naturalEnemy">
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
		<input type ="submit" value = "Insert" name = "option">
	</div>
	<div name = "search" id ="search" style = "display:none" class ="select">
		<select form = "x" name = "attr">
			<option value = "" selected>--선택--</option>
			<option value = "name">Name</option>
			<option value = "age">Age</option>
			<option value = "naturalenemy">Natural Enemy</option>
			<option value = "corpsname">Army Name</option>
		</select>
		<input type ="text" name ="segtype">
		<input type ="submit" value ="Search" name = "option">
	</div>

<%
	}else if(type.equals("corps")){
%>
	<div name = "insert" id = "insert" style = "display:none" class ="select">
		Name : <input type = "text" name = "name">
		Total Number : <input type = "number" name ="totalnumber">
		ATK : <input type = "number" name = "atk"><br>
		DEF : <input type = "number" name = "def">
		Speed : <input type = "number" name ="speed"><br>
		Morale : <input type = "number" name = "morale">
		<input type ="submit" value = "Insert" name = "option">
	</div>
	<div name = "search" id = "search" style = "display:none" class ="select">
		<select form = "x" name = "attr">
			<option value = "" selected>--선택--</option>
			<option value = "name">Name</option>
			<option value = "commandername">Commander</option>
		</select>
		<input type = "text" name = "segtype">
		<input type = "submit" value ="Search" name = "option">
	</div>
<%
	}else if(type.equals("skill")){
%>

	<div name = "insert" id  ="insert" style = "display:none" class ="select">
		Name : <input type = "text" name ="name">
		CON : <input type = "number" name = "addcon">
		SP : <input type = "number" name = "addsp">
		<input type = "submit" value = "Insert" name = "option">
	</div>
	<div name = "search" id = "search" style = "display:none" class ="select">
		Name : <input type = "text" name = "segtype">
		<input type = "submit" value = "Search" name = "option">
	</div> 

<%
	}else if(type.equals("administer")){
%>

	<div name = "insert" id  ="insert" style = "display:none" class ="select">
		ID : <input type = "text" name ="id">
		Password : <input type = "password" name = "password">
		<input type = "submit" value = "Insert" name = "option">
	</div>
	<div name = "search" id = "search" style = "display:none" class ="select">
		ID : <input type = "text" name = "id">
		<input type = "submit" value = "Search" name = "option">
	</div> 
<%
	}
%>
</form>
<form action = "main.jsp">
<input type = "submit" value = "main">
</form>
</body>
</html>
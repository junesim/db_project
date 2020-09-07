<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전투 분석</title>
</head>
<body>
<script type = "text/javascript">
	function selectDiv(value){//select 값에 따라 출력하는 div가 다름
		if(value == 'hero'){
			document.getElementById("hero").style.display ="block";
			document.getElementById("corps").style.display = "none";
		}else if(value =='corps'){
			document.getElementById("hero").style.display = "none";
			document.getElementById("corps").style.display = "block";
		}else{
			document.getElementById("hero").style.display = "none";
			document.getElementById("corps").style.display = "none";
		}
	}
</script>
<%
	String ID;
	try{
		ID = session.getAttribute("adminID").toString();
	}catch(NullPointerException e){
		ID = "비회원";
	}
%>
<div class = "select">
<select class = "formControl" name = "option" id = "option" onChange = "selectDiv(this.value)">
	<option value = '' selected>-- 선택 -- </option>
	<option value = 'hero' > 영웅 </option>
	<option value = 'corps' > 마물군단 </option>
</select>
</div>
<div id = "hero" style = "display:none" class = "select">
	<table border = 1>
		<caption>용사들의 통계</caption>
			<th>총 수</th>
			<th>총 공격력</th>
			<th>총 방어력</th>
			<th>총 지능</th>
			<th>총 체력</th>
			<th>총 마력</th>
			
<%
	DB a = new DB();
	String sql="";
	String hero,x,y;
	Statement stmt;
	ResultSet rs;
	a.connect();
	stmt = a.getStmt();
	sql  = "SELECT count(id) from hero";
	rs = stmt.executeQuery(sql);
	int atk=0;int def= 0;int str = 0;int inte = 0;int con= 0; int sp = 0;
	if(rs.next()){
		out.print("<tr><td>"+rs.getString("count(id)")+"</td>");
	}
	sql = "SELECT sum(NVL(atk,0)),sum(NVL(def,0)),sum(NVL(str,0)) as c,sum(NVL(inte,0)) as d,sum(NVL(sp,0)) as e,sum(NVL(con,0)) as f FROM hero";
	rs = stmt.executeQuery(sql);
	if(rs.next()){
		atk = Integer.valueOf(rs.getString("sum(NVL(atk,0))")); def = Integer.valueOf(rs.getString("sum(NVL(def,0))"));
		inte = Integer.valueOf(rs.getString("d")); con = Integer.valueOf(rs.getString("f")); sp = Integer.valueOf(rs.getString("e"));
	}
	out.print("<td>"+atk+"</td>"+"<td>"+def+"</td>"+"<td>"+inte+"</td>"+"<td>"+con+"</td>"+"<td>"+sp+"</td></tr>");
%>
	</table>
	<table border = 1>
		<caption>종족 현황</caption>
			<th>종족</th>
			<th>인원 수</th>
<%
	sql = "SELECT kindname,count(id) FROM HERO natural join (select name as kindname from kind) group by kindname";
	rs = stmt.executeQuery(sql);
	while(rs.next()){
		out.print("<tr><td>"+rs.getString("kindname")+"</td><td>"+rs.getString("count(id)")+"</td></tr>");
	}
		
	
%>
	</table>
</div>
<div  id ="corps" style = "display:none" class = "select">
</div>
<%
	if(!ID.equals("비회원")){
		out.print("<form action = 'logout.jsp'><input type = 'submit' value = 'Logout'></form>");
	}
%>
<form action = "main.jsp">
<input type = "submit" value = "main">
</form>
</body>
</html>
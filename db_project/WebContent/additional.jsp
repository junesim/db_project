<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update</title>
</head>
<body>
<%
	String pk =  "";
	String attr = "";
	String type = "";
	DB a = new DB();
	String sql = "";
	try{
		pk = session.getAttribute("corvalue").toString();
		type = session.getAttribute("cortypes").toString();
		attr = session.getAttribute("corprimarykey").toString();
	}catch(NullPointerException e){
		response.sendRedirect("logout.jsp");
	}
	out.print(attr);
	if(type.equals("hero")){
		String password = a.check(request.getParameter("password").toString(),0);
		String name = a.check(request.getParameter("name").toString(),0);
		String age = a.check(request.getParameter("age").toString(),1);
		String hometown = a.check(request.getParameter("hometown").toString(),0);
		String att =  a.check(request.getParameter("atk").toString(),1);
		String def =  a.check(request.getParameter("def").toString(),1);
		String con =  a.check(request.getParameter("con").toString(),1);
		String str =  a.check(request.getParameter("str").toString(),1);
		String inte = a.check(request.getParameter("inte").toString(),1);
		String sp = a.check(request.getParameter("sp"),1);
		String kindname = a.check(request.getParameter("kindname"),0);
		String skillname = a.check(request.getParameter("skillname").toString(),0);
		if(!password.equals("null")){sql = "UPDATE " + type + " SET password = " + password + " where id = " + pk; a.execute(sql);}
		if(!name.equals("null")){sql = "UPDATE " + type + " SET name = " + name + " where id = " + pk; a.execute(sql);}
		if(!age.equals("null")){sql = "UPDATE " + type + " SET age = " + age + " where id = " + pk; a.execute(sql);}
		if(!hometown.equals("null")){sql = "UPDATE " + type + " SET hometown = " + hometown + " where id = " + pk; a.execute(sql);}
		if(!att.equals("null")){sql = "UPDATE " + type + " SET atk = " + att + " where id = " + pk; a.execute(sql);}
		if(!def.equals("null")){sql = "UPDATE " + type + " SET def = " + def + " where id = " + pk; a.execute(sql);}
		if(!con.equals("null")){sql = "UPDATE " + type + " SET con = " + con + " where id = " + pk; a.execute(sql);}
		if(!str.equals("null")){sql = "UPDATE " + type + " SET str = " + str + " where id = " + pk; a.execute(sql);}
		if(!inte.equals("null")){sql = "UPDATE " + type + " SET inte = " + inte + " where id = " + pk; a.execute(sql);}
		if(!sp.equals("null")){sql = "UPDATE " + type + " SET sp = " + sp + " where id = " + pk; a.execute(sql);}
		if(!kindname.equals("null")){sql = "UPDATE " + type + " SET kindname = " + kindname + " where id = " + pk; a.execute(sql);}
		if(!skillname.equals("null")){sql = "UPDATE " + type + " SET skillname = " + skillname + " where id = " + pk; a.execute(sql);}
	}else if(type.equals("item")||type.equals("kind")){
		String addatk  = a.check(request.getParameter("addatk").toString(),1);
		String adddef = a.check(request.getParameter("adddef").toString(),1);
		String addstr = a.check(request.getParameter("addstr").toString(),1);
		String addint = a.check(request.getParameter("addint").toString(),1);
		if(!addatk.equals("null")){sql="UPDATE " + type + " SET addatk = " + addatk + " where name = " + pk; a.execute(sql);}
		if(!adddef.equals("null")){sql="UPDATE " + type + " SET adddef = " + adddef + " where name = " + pk; a.execute(sql);}
		if(!addstr.equals("null")){sql="UPDATE " + type + " SET addstr = " + addstr + " where name = " + pk; a.execute(sql);}
		if(!addint.equals("null")){sql="UPDATE " + type + " SET addint = " + addint + " where name = " + pk; a.execute(sql);}
		if(type.equals("item")){
			String kind = a.check(request.getParameter("kind").toString(),0);
			String heroid = a.check(request.getParameter("heroid").toString(),0);
			if(!kind.equals("null")){sql="UPDATE " + type + " SET kind = " + kind + " where name = " + pk; a.execute(sql);}
			if(!heroid.equals("null")){sql="UPDATE " + type + " SET heroid = " + heroid + " where name = " + pk; a.execute(sql);}
		}else{
			String addcon=a.check(request.getParameter("addcon"),1);
			String addsp=a.check(request.getParameter("addsp"),1);
			if(!addcon.equals("null")){sql="UPDATE " + type + " SET addcon = " + addcon + " where name = " + pk; a.execute(sql);}
			if(!addsp.equals("null")){sql="UPDATE " + type + " SET addsp = " + addsp + " where name = " + pk; a.execute(sql);}
		}
	}else if(type.equals("general")){
		String age = a.check(request.getParameter("age"),1);
		String addatk = a.check(request.getParameter("addatk"),1);
		String speed = a.check(request.getParameter("addspeed"),1);
		String morale = a.check(request.getParameter("addmorale"),1);
		String def = a.check(request.getParameter("adddef"),1);
		String naturalenemy = a.check(request.getParameter("naturalEnemy"),0);
		String namecorps = a.check(request.getParameter("namecorps"),0);
		if(!namecorps.equals("null")){sql="INSERT INTO commander values( " + namecorps+ " , " +pk+")"; a.execute(sql);}
		if(!addatk.equals("null")){sql="UPDATE " + type + " SET addatk = " + addatk + " where name = " + pk; a.execute(sql);}
		if(!age.equals("null")){sql = "UPDATE " + type + " SET age = " + age + " where name = " + pk; a.execute(sql);}
		if(!speed.equals("null")){sql = "UPDATE " + type + " SET addspeed = " + speed + " where name = " + pk; a.execute(sql);}
		if(!def.equals("null")){sql = "UPDATE " + type + " SET adddef = " + def + " where name = " + pk; a.execute(sql);}
		if(!morale.equals("null")){sql = "UPDATE " + type + " SET addmorale = " + morale + " where name = " + pk; a.execute(sql);}
		if(!naturalenemy.equals("null")){sql = "UPDATE " + type + " SET naturalenemy = " + naturalenemy + " where name = " + pk; a.execute(sql);}
	}else if(type.equals("corps")){
		String totalnumber = a.check(request.getParameter("totalnumber"),1);
		String atk = a.check(request.getParameter("atk"),1);
		String def = a.check(request.getParameter("def"),1);
		String speed = a.check(request.getParameter("speed"),1);
		String morale = a.check(request.getParameter("morale"),1);
		String namegeneral = a.check(request.getParameter("namegeneral"),0);
		if(!namegeneral.equals("null")){sql="INSERT INTO commander values( " + pk+ " , " +namegeneral+")"; a.execute(sql);}
		if(!atk.equals("null")){sql = "UPDATE " + type + " SET atk = " + atk + " where name = " + pk; a.execute(sql);}		
		if(!totalnumber.equals("null")){sql = "UPDATE " + type + " SET totalnumber = " + totalnumber + " where name = " + pk; a.execute(sql);}
		if(!def.equals("null")){sql = "UPDATE " + type + " SET def = " + def + " where name = " + pk; a.execute(sql);}
		if(!speed.equals("null")){sql = "UPDATE " + type + " SET speed = " + speed + " where name = " + pk; a.execute(sql);}
		if(!morale.equals("null")){sql = "UPDATE " + type + " SET morale = " + morale + " where name = " + pk; a.execute(sql);}
	}else if(type.equals("skill")){
		String con = a.check(request.getParameter("addcon"),1);
		String sp = a.check(request.getParameter("addsp"),1);
		if(!con.equals("null")){sql = "UPDATE " + type + " SET addcon = " + con + " where name = " + pk; a.execute(sql);}
		if(!sp.equals("null")){sql = "UPDATE " + type + " SET addsp = " + sp + " where name = " + pk; a.execute(sql);}
	}else if(type.equals("administer")){
		String password = a.check(request.getParameter("password").toString(),0);
		if(!password.equals("null")){sql = "UPDATE " + type + " SET password = " + password + " where id = " + pk; a.execute(sql);}
	}
	sql = "SELECT * FROM " + type + " WHERE " + attr + " = " + pk;
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script>
function error(msg){
	alert(msg);
}
</script>
<%
	String type = "";
	String ID = "비회원";
	String option = "";
	String sql = "";
	DB a = new DB();
	boolean login = true;
	try{
		ID = session.getAttribute("adminID").toString();
	}catch(NullPointerException e){
		login = false;
	}
	try{
		type = session.getAttribute("types").toString();
	}catch(NullPointerException e){
		response.sendRedirect("login.jsp");
	}
	try{
		option = request.getParameter("option");
	}catch(NullPointerException e){
		e.printStackTrace();
	}
	out.print(ID + "<br>"+ type +" "+option);
	if(option.equals("Search")){
		String segtype="";
		String attr = "";
		try{
			segtype = request.getParameter("segtype").toString();
		}catch(NullPointerException e){
			segtype = "";
		}
		try{
			if(type.equals("administer")){
				attr = "id";
			}
			else if(type.equals("skill") || type.equals("kind")){
				attr = "name";
			}
			else{
				attr = request.getParameter("attr").toString();
			}
		}catch(NullPointerException e){
			attr = "";
		}if(attr.isEmpty()||segtype.isEmpty()){
			sql = "SELECT * FROM " +type;
			out.print("<script>error('전체검색을 실행합니다.',1)</script>");
		}else{
			sql = a.search(attr,segtype,type);
		}
	}else if(option.equals("Insert")){
		if(type.equals("hero") || type.equals("administer")){
			String id = "";
			String password = "";
			try{
				id = request.getParameter("id").toString();
				password = request.getParameter("password").toString();
			}catch(NullPointerException e){
				out.print("<script>error('ID와 Password는 입력되어야 합니다.')</script>" +
						  "<form action = 'search.jsp'><input type = 'submit' value = '돌아가기'></form>");
			}
			if(id.isEmpty()||password.isEmpty()){
				out.print("<script>error('ID와 Password는 입력되어야 합니다.')</script>" +
						  "<form action = 'search.jsp'><input type = 'submit' value = '돌아가기'></form>");
			}else{
				if(type.equals("hero")){
					String name = a.check(request.getParameter("name").toString(),0);
					String age = a.check(request.getParameter("age").toString(),1);
					String hometown = a.check(request.getParameter("hometown").toString(),0);
					String att =  a.check(request.getParameter("atk").toString(),1);
					String def =  a.check(request.getParameter("def").toString(),1);
					String con =  a.check(request.getParameter("con").toString(),1);
					String str =  a.check(request.getParameter("str").toString(),1);
					String inte = a.check(request.getParameter("inte").toString(),1);
					String kindname = a.check(request.getParameter("kindname").toString(),0);
					String skillname = a.check(request.getParameter("skillname").toString(),0);
					String sp = a.check(request.getParameter("sp").toString(),1);
					id = "'" + id +"'";
					password = "'" + password +"'";
					sql = "INSERT INTO " + type + " values( " + id;
					sql = a.makeSql(sql,name); sql = a.makeSql(sql,password); sql = a.makeSql(sql,age); 
					sql = a.makeSql(sql,hometown); sql = a.makeSql(sql,att); sql = a.makeSql(sql,def);
					sql = a.makeSql(sql,con); sql = a.makeSql(sql,str); sql = a.makeSql(sql,inte);
					sql = a.makeSql(sql,kindname); sql = a.makeSql(sql,skillname);
					sql = a.makeSql(sql,sp) + ")";
				}
				else{
					id = "'" + id + "'";
					password = "'" + password + "'";
					sql = "INSERT INTO " + type + " values( " +id + " , " +password+")" ;
				}
			}
		}else if(type.equals("item")||type.equals("kind")){
			String name = "";
			name = request.getParameter("name").toString();
			if(name.isEmpty()){
				out.print("<script>error('name은 입력되어야 합니다.')</script>" +
						  "<form action = 'search.jsp'><input type = 'submit' value = '돌아가기'></form>");
			}else{
				name = a.check(name, 0);
				String addatk  = a.check(request.getParameter("addatk").toString(),1);
				String adddef = a.check(request.getParameter("adddef").toString(),1);
				String addstr = a.check(request.getParameter("addstr").toString(),1);
				String addint = a.check(request.getParameter("addint").toString(),1);
				sql="INSERT INTO "+type+" values( " + name;sql=a.makeSql(sql, addatk);
				sql=a.makeSql(sql,adddef);
				if(type.equals("item")){
					String kind = a.check(request.getParameter("kind").toString(),0);
					String heroid = a.check(request.getParameter("heroid").toString(),0);
					 sql=a.makeSql(sql,addstr); sql=a.makeSql(sql,addint);
					sql=a.makeSql(sql,kind);sql=a.makeSql(sql,heroid) + ")";
				}else{
					String addcon=a.check(request.getParameter("addcon"),1);
					String addsp=a.check(request.getParameter("addsp"),1);
					sql = a.makeSql(sql,addcon); sql = a.makeSql(sql,addsp);
					sql = a.makeSql(sql,addstr); sql = a.makeSql(sql,addint) + ")";
				}
			}
		}else if(type.equals("general")){
			String name = "";
			name = request.getParameter("name").toString();
			if(name.isEmpty()){
				out.print("<script>error('name은 입력되어야 합니다.')</script>" +
						  "<form action = 'search.jsp'><input type = 'submit' value = '돌아가기'></form>");
			}else{
				name = a.check(name,0);
				String age = a.check(request.getParameter("age"),1);
				String addatk = a.check(request.getParameter("addatk"),1);
				String speed = a.check(request.getParameter("addspeed"),1);
				String morale = a.check(request.getParameter("addmorale"),1);
				String def = a.check(request.getParameter("adddef"),1);
				String naturalenemy = a.check(request.getParameter("naturalEnemy"),0);
				sql = "INSERT INTO " +type+ " values( " + name;
				sql = a.makeSql(sql,age); sql = a.makeSql(sql,addatk); sql = a.makeSql(sql,speed);
				sql = a.makeSql(sql,morale); sql = a.makeSql(sql,naturalenemy); 
				sql = a.makeSql(sql,def)+")";
			}
		}else if(type.equals("corps")){
			String name ="";
			name = request.getParameter("name");
			if(name.isEmpty()){
				out.print("<script>error('name은 입력되어야 합니다.')</script>" +
						  "<form action = 'search.jsp'><input type = 'submit' value = '돌아가기'></form>");
			}else{
				name = a.check(name,0);
				String totalnumber = a.check(request.getParameter("totalnumber"),1);
				String atk = a.check(request.getParameter("atk"),1);
				String def = a.check(request.getParameter("def"),1);
				String speed = a.check(request.getParameter("speed"),1);
				String morale = a.check(request.getParameter("morale"),1);
				sql = "INSERT INTO "+type+" values( "+name;
				sql = a.makeSql(sql,totalnumber); sql = a.makeSql(sql,atk);
				sql = a.makeSql(sql,def); sql = a.makeSql(sql,speed);
				sql = a.makeSql(sql,morale) + ")";
			}
		}else if(type.equals("skill")){
			String name = "";
			name = request.getParameter("name");
			if(name.isEmpty()){
				out.print("<script>error('name은 입력되어야 합니다.')</script>" +
						  "<form action = 'search.jsp'><input type = 'submit' value = '돌아가기'></form>");
			}else{
				name = a.check(name,0);
				String con = a.check(request.getParameter("addcon"),1);
				String sp = a.check(request.getParameter("addsp"),1);
				sql = "INSERT INTO " + type + " values( "+name; 
				sql = a.makeSql(sql,con);
				sql = a.makeSql(sql,sp) + ")";
			}
		}
		if(!sql.isEmpty()){
		a.connect();
		Statement stmt = a.getStmt();
		stmt.executeQuery(sql);
		a.disconnect(stmt);
		}
		sql = "SELECT * FROM " +type;
	}
	a.connect();
	Statement stmt = a.getStmt();
	ResultSet rs = stmt.executeQuery(sql);
	ResultSetMetaData rsmd = rs.getMetaData();
	out.print("<table border = 1>");
	for(int i = 1; i <= rsmd.getColumnCount();i++){
		out.print("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.print("<tr>");
		for(int i =1; i<=rsmd.getColumnCount();i++){
			if(i ==1){
				out.print("<td><a href = \"detail.jsp?value="+rs.getString(i)+"&primarykey="+rsmd.getColumnName(1)
				+"&type="+type+"\" target=\"_blank\">"+rs.getString(i)+"</a></td>");
			}else{
				out.print("<td>"+rs.getString(i)+"</td>");
			}
		}
		out.print("</tr>");
	}
	a.disconnect(stmt);
	rs.close();
	if(login){
		out.print("<form action = \"logout.jsp\"><input type = 'submit' value = 'Logout' ></form>");
	}
%>
<form action = "main.jsp">
<input type = "submit" value = "main">
</form>
</body>
</html>
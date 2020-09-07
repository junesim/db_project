<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
</head>
<body>
<%
	String type = "";
	String ID = "" ;
	String pk= "";
	String attr = "";
	String sql="";
	DB a = new DB();
	try{
		ID = session.getAttribute("adminID").toString();
	}catch(NullPointerException e){
		ID = "비회원";
	}
	try{
		type = request.getParameter("type");
		pk = request.getParameter("value");
		attr = request.getParameter("primarykey");
	}catch(NullPointerException e){
		out.print("잘못된 경로입니다.");
		response.sendRedirect("logout.jsp");
	}
	pk = "\'" + pk + "\'";
	sql = "SELECT * FROM " + type + " Where "+ attr + " = " + pk ;
	a.connect();
	Statement stmt = a.getStmt();
	ResultSet rs = stmt.executeQuery(sql);
	ResultSetMetaData rsmd = rs.getMetaData();
	out.print("<table border = 1>");
	String [] herostat = new String [6];
	String [] corpstat = new String [4];
	int k = 0;
	for(int i = 1; i <= rsmd.getColumnCount();i++){
		if(type.equals("hero")){
			if(5 < i && i < 11 ){
			}else if(i ==13){
			}else{
				out.print("<th>"+rsmd.getColumnName(i)+"</th>");
			}
		}else if(type.equals("corps") && 2<i){
		}
		else{
			out.print("<th>"+rsmd.getColumnName(i)+"</th>");
		}
	}
	while(rs.next()){
		out.print("<tr>");
		for(int i =1; i<=rsmd.getColumnCount();i++){
				if(type.equals("hero")){
					if(i == 11){//kind
						out.print("<td><a href = \"detail.jsp?value="+rs.getString(i)+"&primarykey=name"
						+"&type=kind"+"\" target=\"_blank\">"+rs.getString(i)+"</a></td>");
					}else if(i==12){//skill
						out.print("<td><a href = \"detail.jsp?value="+rs.getString(i)+"&primarykey=name"
								+"&type=skill"+"\" target=\"_blank\">"+rs.getString(i)+"</a></td>");
					}else if(5 < i && i < 11){
						herostat[k] = rs.getString(i);
						k++;
					}else if(i==13){
						herostat[k] = rs.getString(i);
					}
					else{
						out.print("<td>"+rs.getString(i)+"</td>");
					}
				}else if(type.equals("general")&& i ==6){//kind
					out.print("<td><a href = \"detail.jsp?value="+rs.getString(i)+"&primarykey=name"
							+"&type=kind"+"\" target=\"_blank\">"+rs.getString(i)+"</a></td>");
				}else if(type.equals("item")&&i==7){//heroid
					out.print("<td><a href = \"detail.jsp?value="+rs.getString(i)+"&primarykey=id"
							+"&type=hero"+"\" target=\"_blank\">"+rs.getString(i)+"</a></td>");
				}else if(type.equals("corps") && 2 < i){
					corpstat[k] = rs.getString(i);
					k++;
				}
				else{
					out.print("<td>"+rs.getString(i)+"</td>");
				}
		}
		out.print("</tr>");
	}
	out.print("</table>");
	a.disconnect(stmt);
	rs.close();
	if(type.equals("general")||type.equals("corps")){//지휘관 정보
		String foreign;
		out.print("<table border = 1>");
		if(type.equals("general")){
			out.print("<caption>지휘 부대</caption>");
			sql = "SELECT namecorps FROM commander where namegeneral = " +pk;
			out.print("<th>지휘 부대명</th>");
			foreign = "corps";
		}else{
			out.print("<caption>지휘관</caption>");
			out.print("<th>지휘관</th>");
			sql = "SELECT namegeneral FROM commander where namecorps = " +pk;
			foreign = "general";
		}
		a.connect();
		stmt = a.getStmt();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			out.print("<tr><td><a href = \"detail.jsp?value="+rs.getString(1)+"&primarykey=name"
					+"&type="+foreign+"\" target=\"_blank\">"+rs.getString(1)+"</a></td></tr>");
		}
		out.print("</table>");
		if(type.equals("corps")){
			int [] val = new int [4];
			sql = "SELECT addatk,addspeed,addmorale,adddef from general where name in (select namegeneral " +
					" from commander where namecorps = " + pk + ")";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				try{
					for(int i = 1; i <= 4;i++){
						val[i-1] = val[i-1] +  a.status(rs.getString(i));
					}
				}catch(NullPointerException e){
				}
			}
			for(int i = 0 ; i < 4 ;i++){
				if(val[i]==0) val[i] = 1;
			}
			sql = "SELECT atk,speed,morale,def from corps where name = " + pk;
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				for(int i = 1; i <= 4;i++){
					try{
						val[i-1] = val[i-1] *  a.status(rs.getString(i));
					}catch(NullPointerException e){
						val[i-1] = 0;
					}
				}
			}
			out.print("<table border = 1><caption>스탯</caption><th></th><th>보정 전</th><th>보정 후</th>"+
					"<tr><td>ATK</td><td>"+corpstat[0]+"</td><td><a href = \"number.jsp?value=corps&primarykey="+pk+"&type=atk"+
					"\" target=\"_blank\">"+val[0]+"</a></td></tr>"+
					"<tr><td>DEF</td><td>"+corpstat[1]+"</td><td><a href = \"number.jsp?value=corps&primarykey="+pk+"&type=def"+
					"\" target=\"_blank\">"+val[3]+"</a></td></tr>"+
					"<tr><td>SPEED</td><td>"+corpstat[2]+"</td><td><a href = \"number.jsp?value=corps&primarykey="+pk+"&type=speed"+
					"\" target=\"_blank\">"+val[1]+"</a></td></tr>"+
					"<tr><td>MORALE</td><td>"+corpstat[3]+"</td><td><a href = \"number.jsp?value=corps&primarykey="+pk+"&type=morale"+
					"\" target=\"_blank\">"+val[2]+"</a></td></tr></table>");
		}
		a.disconnect(stmt);
		rs.close();
	}else if(type.equals("hero")){//보정 스탯 및 착용 아이템
		sql = "SELECT ATK,DEF,CON,STR,INTE,KINDNAME,SKILLNAME,SP FROM "+ type +" WHERE " + attr +" = "+ pk;
		String kindname,skillname;
		int atk = 0; 
		int def = 0; 
		int con =0;  
		int str = 0; 
		int inte= 0; 
		int sp = 0; 
		a.connect();
		stmt = a.getStmt();
		rs = stmt.executeQuery(sql);
		if(rs.next()){
			kindname = rs.getString("KINDNAME");
			skillname = rs.getString("SKILLNAME");
			try{
				atk = a.status(rs.getString("atk"));
			}catch(NullPointerException e){
				atk = 0;
			}
			try{
				def = a.status(rs.getString("def"));
			}catch(NullPointerException e){
				def = 0;
			}
			try{
				con = a.status(rs.getString("con"));
			}catch(NullPointerException e){
				con = 0;
			}
			try{
				str = a.status(rs.getString("str"));
			}catch(NullPointerException e){
				str = 0;
			}
			try{
				inte = a.status(rs.getString("inte"));
			}catch(NullPointerException e){
				inte = 0;
			}
			try{
				sp = a.status(rs.getString("sp"));
			}catch(NullPointerException e){
				sp = 0;
			}
			sql = "SELECT * FROM item WHERE heroId = " + pk;
			ResultSet rs2 = stmt.executeQuery(sql);//item 능력치 상승 및 장착 아이템 출력
			out.print("<table border = 1><th>장착중인 아이템</th>");
			while(rs2.next()){
				out.print("<tr><td><a href = \"detail.jsp?value="+rs2.getString("name")+"&primarykey=name"
						+"&type=item"+"\" target=\"_blank\">"+rs2.getString("name")+"</a></td></tr>");
				try{
					atk = atk + a.status(rs2.getString("addatk"));
				}catch(NullPointerException e){
				}
				try{
					def = def + a.status(rs2.getString("adddef"));
				}catch(NullPointerException e){
				}
				try{
					str = str + a.status(rs2.getString("addstr"));
				}catch(NullPointerException e){
				}
				try{
					inte = inte + a.status(rs2.getString("addint"));
				}catch(NullPointerException e){
				}
				
			}
			out.print("</table>");
			sql = "SELECT addcon,addsp FROM skill WHERE name = '"+skillname+"'";
			rs2=stmt.executeQuery(sql);//skill 능력치 상승
			if(rs2.next()){
				try{
					con = con + a.status(rs2.getString("addcon"));
				}catch(NullPointerException e){
				}
				try{
					sp = sp + a.status(rs2.getString("addsp"));
				}catch(NullPointerException e){
				}
			}
			sql = "SELECT addatk,adddef,addstr,addint,addcon,addsp FROM kind WHERE name = '" + kindname+"'";
			rs2=stmt.executeQuery(sql);//kind 보정
			if(rs2.next()){
				try{
					atk = atk * a.status(rs2.getString("addatk"));
				}catch(NullPointerException e){
				}
				try{
					def = def * a.status(rs2.getString("adddef"));
				}catch(NullPointerException e){
				}
				try{
					str = str * a.status(rs2.getString("addstr"));
				}catch(NullPointerException e){
				}
				try{
					inte = inte * a.status(rs2.getString("addint"));
				}catch(NullPointerException e){
				}
				try{
					con = con * a.status(rs2.getString("addcon"));
				}catch(NullPointerException e){
				}
				try{
					sp = sp * a.status(rs2.getString("addsp"));
				}catch(NullPointerException e){
				}
			}
			rs2.close();
		}
		a.disconnect(stmt);
		rs.close();
		out.print("<table border = 1><caption>보정 스탯</caption><th></th><th>보정전 </th><th>보정 후</th>"+
				"<tr><td>ATK</td><td>"+herostat[0]+"</td><td><a href = \"number.jsp?value=hero&primarykey="+pk+"&type=atk"+
				"\" target=\"_blank\">"+atk+"</a></td></tr>"+
				"<tr><td>DEF</td><td>"+herostat[1]+"</td><td><a href = \"number.jsp?value=hero&primarykey="+pk+"&type=def"+
				"\" target=\"_blank\">"+def+"</a></td></tr>"+
				"<tr><td>CON</td><td>"+herostat[2]+"</td><td><a href = \"number.jsp?value=hero&primarykey="+pk+"&type=con"+
				"\" target=\"_blank\">"+con+"</a></td></tr>"+
				"<tr><td>STR</td><td>"+herostat[3]+"</td><td><a href = \"number.jsp?value=hero&primarykey="+pk+"&type=str"+
				"\" target=\"_blank\">"+str+"</a></td></tr>"+
				"<tr><td>INT</td><td>"+herostat[4]+"</td><td><a href = \"number.jsp?value=hero&primarykey="+pk+"&type=inte"+
				"\" target=\"_blank\">"+inte+"</a></td></tr>"+
				"<tr><td>SP</td><td>"+herostat[5]+"</td><td><a href = \"number.jsp?value=hero&primarykey="+pk+"&type=sp"+
				"\" target=\"_blank\">"+sp+"</a></td></tr></table>");
	}
	
	if(!ID.equals("비회원")){
	out.print("<form action = 'correct.jsp'><input type = 'hidden' value =\""+ type+"\" name = \"type\">"+
			"<input type = 'hidden' value =\""+pk+"\" name = \"value\"><input type = 'hidden' value=\""+attr+"\"name =\"primarykey\">"+
			"<input type = 'submit' value = '수정'></form>");
	out.print("<form action = 'delete.jsp'><input type = \"hidden\" value =\""+ type+"\" name = \"type\">"+
			"<input type = \"hidden\" value =\""+pk+"\" name = \"value\"><input type = \"hidden\" value=\""+attr+"\"name\" =\"primarykey\">"+
			"<input type = 'submit' value = '삭제'></form>");
	out.print("<form action = 'logout.jsp'><input type = \"submit\" value = \"Logout\"'>");
	}
%>
	<input type = button value = "닫기" onclick = "self.close()">
</body>
</html>
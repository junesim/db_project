<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "Project.*" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calculate</title>
</head>
<body>
<%
	String type = "";
	String pk = "";
	String value = "";
	Statement stmt;
	ResultSet rs = null;
	String sql;
	String original = "";
	String kindname = "";
	String typename = "";
	String msg = "";
	String line = "";
	int result = 0;
	DB a = new DB();
	a.connect();
	stmt = a.getStmt();
	try{
		type = request.getParameter("type");
		value = request.getParameter("value");
		pk = request.getParameter("primarykey");
	}catch(NullPointerException e){
	}
	if(value.equals("hero")){//atk,def,con,str,int,sp
		if(type.equals("atk")||type.equals("def")||type.equals("str")||type.equals("inte")){
			String itemname;
			sql = "SELECT kindname, " + type + " FROM hero WHERE ID = " +pk;
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				original = rs.getString(type);
				kindname = rs.getString("kindname");
				line = original;
				try{
					result = a.status(original); msg = "";
				}catch(NullPointerException e){
					result = 0; msg = "(null)";
				}
			}
			out.print("수정 전 " + type + ": "+ result+ msg +"<br>" );
			typename="";
			if(type.equals("inte")){
				sql = "SELECT name,addint FROM item where heroid = " + pk;
				typename = "addint";
			}
			else{
				sql = "SELECT name,add" + type +" FROM item where heroid = " +pk;
				typename = "add"+type;
			}
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				String itemstat;
				try{
					result = result+a.status(rs.getString(typename)); msg = "";
					
				}catch(NullPointerException e){
					result = result + 0; msg = "(null)";
				}
				line = "(" + line + " + " + rs.getString(typename) ;
				out.print("더해질 " + rs.getString("name") +"의 " + type + " : " + rs.getString(typename)+"<br>");
			}
		}else{
			String skillname = "";
			sql = "SELECT skillname, kindname, " + type +" FROM HERO WHERE ID = " +pk;
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				original = rs.getString(type);
				kindname = rs.getString("kindname");
				skillname = rs.getString("skillname");
				line = "( " + original;
			}
			try{
				result = a.status(original); msg = "";
			}catch(NullPointerException e){
				result = 0; msg = "(null)";
			}
			out.print("수정 전 " + type + ": "+ result +msg +"<br>" );
			typename= "add" + type;
			sql = "SELECT "+typename + " FROM skill where name = '" + skillname+"'";
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				
				try{
					result = result+a.status(rs.getString(typename)); msg = "";
				}catch(NullPointerException e){
					result = result + 0;  msg = "(null)";
				}
				out.print("더해질 " + skillname +"의 " + type + " : " + rs.getString(typename) + msg +"<br>");
				line = line +" + "+ rs.getString(typename);
			}else{
				 msg = "(null)";
			}
		}
		sql = "SELECT " + typename +" FROM KIND WHERE name = '"+ kindname+"'" ;
		rs = stmt.executeQuery(sql);
		int x =0;
		if(rs.next()){
			try{
				x = a.status(rs.getString(typename)); msg = "";
			}catch(NullPointerException e){
				x = 1;  msg = "(null)";
			}
			result = result * x;
			
		}else{
			msg = "(null)";
		}
		line = line + " ) * " + String.valueOf(x) + " = ";
		out.print("곱해질 " + kindname +"의 " + type + " : " + x+msg+"<br>");
		out.print("결과  : "+ line + result);
	}else{
		sql = "SELECT "+ type+" from " + value +" where name = " + pk;
		rs = stmt.executeQuery(sql);
		if(rs.next()){
			original = rs.getString(type);
		try{
			result = a.status(original); msg = "";
		}catch(NullPointerException e){
			result = 0; msg = "(null)";
		}
		}else{
			msg = "(null)"; result = 0;
		}
		line = String.valueOf(result) + "*(";
		out.print("수정 전 " + type + " : " + original + msg+"<br>");
		String stype = "add" + type;
		sql = "SELECT name, "+stype+" from general where name in (select namegeneral " +
				" from commander where namecorps = " + pk + ")";
		rs = stmt.executeQuery(sql);
		int x=0;
		while(rs.next()){
			out.print("곱해야 할 " + rs.getString("name") + "의 " +type+ " : " + rs.getString(stype) + "<br>" );
			try{
				x = x + a.status(rs.getString(stype));
			}catch(NullPointerException e){
			}
			line = line + rs.getString(stype) + " + ";
		}
		line = line + " 0 ) = ";
		result = result * x;
		out.print(line + result);
	}
	a.disconnect(stmt);
	rs.close();
%>
<input type = button value = "닫기" onclick = "self.close()">
</body>
</html>
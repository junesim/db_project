package Project; 
import java.sql.*;
public class DB {
	private Connection con= null;
	private Statement stmt = null;
	public int status(String value) {
		if(value.isEmpty()) {
			return 0;
		}else {
			return Integer.valueOf(value);
		}
	}
	public void execute(String sql) {
		this.connect();
		try {
		stmt.executeQuery(sql);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		this.disconnect();
	}
	public Statement getStmt() {
		return this.stmt;
	}
	public String makeSql(String sql,String attr) {
		sql = sql + " , " +attr;
		return sql;
	}
	public String check(String type,int a) {
		if(type.isEmpty()) {
			type = "null";
		}
		else {
			if(a  == 0 ) {
				type = "'" + type +"'" ;
			}
		}
		return type;
	}
	public String search(String name,String value,String type) {
		String sql;
		sql = "SELECT * FROM " + type + " WHERE " + name + " = " ;
		if(name.equals("age")) {
			sql = sql + value;
		}else {
			sql = sql + "\'" + value + "\'";
		}
		return sql;
	}
	public boolean checkAdmin(String inputID,String inputPassword) {
		this.connect();
		String ID = null;
		String password = null;
		boolean result = false;
		try {
			String sql;
			ResultSet rs;
			sql = "SELECT * FROM Administer";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ID = rs.getString("ID");
				password = rs.getString("Password");
				if(ID.equals(inputID)) {
					result = password.equals(inputPassword);
				}
			}
			rs.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		this.disconnect();
		return result;
	}
	public void connect() {
		try {
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","system","QKRwnstn773");
			stmt = con.createStatement();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void disconnect(Statement a) {
		try {
			con.close();
			stmt.close();
			a.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void disconnect() {
		try {
			con.close();
			stmt.close();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
}

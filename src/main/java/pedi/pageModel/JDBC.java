package pedi.pageModel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import pedi.pageModel.Configuration;

public class JDBC {
	
	public static Connection conn = getConn();
	
	private  static Connection getConn() {
		
		// Loading the driver
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(-1);
		}
		
		Connection conn = null;
		
		// 读入配置文件，获取数据库连接信息
		Configuration config = new Configuration("resources/default.properties");
		String ip = config.getValue("ip");
		String dbName = config.getValue("dbName");
		String dbUser = config.getValue("dbUser");
		String dbPwd = config.getValue("dbPwd");
		
		String url = "jdbc:postgresql://" + ip + "/" + dbName + "?user=" + dbUser + "&password=" + dbPwd;
		
		try {
			conn = DriverManager.getConnection(url);
		} catch (SQLException e) {
			System.out.println("连接失败，请检查网络是否连通或者配置文件是否正确！");
			e.printStackTrace();
			System.exit(-1);
		}
		return conn;
	}
	
	public static void close(){
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return;
	}
}

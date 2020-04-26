package pedi.util;

import org.apache.commons.dbcp2.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * 
 */
public class JdbcUtils_DBCP {
    private static DataSource ds = null;

    static {
        try {
            InputStream in = JdbcUtils_DBCP.class.getClassLoader().getResourceAsStream("dbcpConfig.properties");
            Properties prop = new Properties();
            prop.load(in);

            //BasicDataSourceFactory factory = new BasicDataSourceFactory();
            ds = BasicDataSourceFactory.createDataSource(prop);
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Connection getConnection(){
    	Connection conn =null;
    	try {
    		conn =ds.getConnection();
    	}catch(SQLException e) {
    		e.printStackTrace();
    	}
        return conn;
    }

    public static void release(Connection conn, Statement st, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();   //throw new
            } catch (Exception e) {
                e.printStackTrace();
            }
            rs = null;
        }
        if (st != null) {
            try {
                st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            st = null;
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
      public static void main(String[] args) {
    	  getConnection();
      }
}

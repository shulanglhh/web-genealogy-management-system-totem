package pedi.util;

import java.sql.*;

/**
 * 
 */
public class JdbcUtils {

    //add update delete
    // sql="insert into account(id,name,money) values(?,?,?) Object[]{1,"a",100}"
    public static void update(String sql, Object params[]) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement(sql);
            //Object params[]替换sql里面的参数
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
    }
    
    public static int count(String sql, Object params[]) {
    	int count=0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement(sql);
            //Object params[]替换sequel里面的参数
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            rs=ps.executeQuery();
            if(rs.next())
            {
            	count=rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
		return count;
    }

    public static Object query(String sql, Object params[], ResultSetHandler handler) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement(sql);
            //Object params[]替换sql里面的参数
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            //不知道sql语句是怎样的，也就不知道怎么处理rs，但是用户知道怎么处理
            rs = ps.executeQuery();
            return handler.handler(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return null;
    }
}

package pedi.dao.impl;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pedi.dao.UserDaoI;
import pedi.model.TOwner;

import pedi.util.BeanHandlerImpl;
import pedi.util.JdbcUtils;
import pedi.util.JdbcUtils_DBCP;

@Repository("userDao")
public class UserDaoImpl implements UserDaoI {
	@Override
    public TOwner find(String sql,Object params[]) {
        return (TOwner)JdbcUtils.query(sql,params,new BeanHandlerImpl(TOwner.class));
    }
	public void save(TOwner owner) {
        String sql = "insert into owner(uid,username,password) values(?,?,?)";
        Object params[] = {owner.getUid(),owner.getUsername(), owner.getPassword()};
        JdbcUtils.update(sql, params);
    }
	public void update(TOwner owner) {
		String sql = "update owner set sex=?,tel=?,qq=?,address=?,email=? where uid=?";
		Object params[] = {owner.getSex(),owner.getTel(),owner.getQq(),owner.getAddress(),owner.getEmail(),owner.getUid()};
		JdbcUtils.update(sql, params);
	}
	public int find() {
		int max=0;
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql="select max(uid) from owner";
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next())
            {
            	max=rs.getInt("max");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
		return max;
	}
}

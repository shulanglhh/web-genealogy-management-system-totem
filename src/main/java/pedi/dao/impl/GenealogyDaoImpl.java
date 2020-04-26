package pedi.dao.impl;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pedi.dao.GenealogyDaoI;
import pedi.model.TGenealogy;

import pedi.util.BeanHandlerImpl;
import pedi.util.JdbcUtils;
import pedi.util.JdbcUtils_DBCP;

@Repository("genealogyDao")
public class GenealogyDaoImpl implements GenealogyDaoI {
	@Override
    public TGenealogy find(String sql,Object params[]) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        TGenealogy genealogy=new TGenealogy();
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement(sql);
            //Object params[]替换sql里面的参数
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            //不知道sql语句是怎样的，也就不知道怎么处理rs，但是用户知道怎么处理
            rs = ps.executeQuery();
            while(rs.next())
            {
                genealogy.setGid(rs.getInt("gid"));
                genealogy.setGname(rs.getString("gname"));
                genealogy.setFamilyname(rs.getString("familyname"));
                genealogy.setTangname(rs.getString("tagname"));
                genealogy.setLocation(rs.getString("location"));
                genealogy.setDescription(rs.getString("GenDesc"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return genealogy;
    }
    public List<TGenealogy> findlist(String sql,Object params[]) {
    	Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TGenealogy>list=new ArrayList<TGenealogy>();
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement(sql);
            //Object params[]替换sql里面的参数
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
            //不知道sql语句是怎样的，也就不知道怎么处理rs，但是用户知道怎么处理
            rs = ps.executeQuery();
            while(rs.next())
            {
            	TGenealogy genealogy=new TGenealogy();
                genealogy.setGid(rs.getInt("gid"));
                genealogy.setGname(rs.getString("gname"));
                genealogy.setFamilyname(rs.getString("familyname"));
                genealogy.setTangname(rs.getString("tagname"));
                genealogy.setLocation(rs.getString("location"));
                genealogy.setDescription(rs.getString("GenDesc"));
                list.add(genealogy);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
    }
	public void save(TGenealogy genealogy) {
        String sql = "ADD ANY INTO Genealogy FROM owner WHERE uid =?";
        Object params[] = {genealogy.getUid()};
        JdbcUtils.update(sql, params);
    }
	public void update(TGenealogy genealogy) {
		int max=find(genealogy);
		String sql = "UPDATE Genealogy SET Gid=?,gname=?,Familyname=?, Tagname=?,Location=?,GenDesc=? WHERE uid =? and gid IS NULL";
		Object params[] = {max+1,genealogy.getGname(),genealogy.getFamilyname(),genealogy.getTangname(),genealogy.getLocation(),genealogy.getDescription(),genealogy.getUid()};
		JdbcUtils.update(sql, params);
	}
	public void excute(String sql,Object params[]) {
		JdbcUtils.update(sql, params);
	}
	public int count(String sql,Object params[]) {
		return JdbcUtils.count(sql,params);
	}
	
	public int find(TGenealogy t) {
		int max=0;
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql="select max(gid) from genealogy";
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
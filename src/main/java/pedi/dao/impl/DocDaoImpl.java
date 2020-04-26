package pedi.dao.impl;

import java.io.Serializable;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pedi.dao.DocDaoI;
import pedi.dao.UserDaoI;
import pedi.model.TDocument;
import pedi.model.TGenealogy;
import pedi.util.BeanHandlerImpl;
import pedi.util.JdbcUtils;
import pedi.util.JdbcUtils_DBCP;

@Repository("docDao")
public class DocDaoImpl implements DocDaoI {
	public List<TGenealogy> getPediListForService(int currentuser){
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TGenealogy> list=new ArrayList<TGenealogy>();
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement("select * from Genealogy where uid =?");
            ps.setInt(1,currentuser);
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
	public List<TDocument> getUsersDocListbygid(int gid) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TDocument> list=new ArrayList<TDocument>();
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement("select * from document where gid =?");
            ps.setInt(1, gid);
            rs = ps.executeQuery();
            while(rs.next())
            {
            	TDocument document=new TDocument();
                document.setGid(rs.getInt("gid"));
                document.setDid(rs.getInt("did"));
                document.setDtname(rs.getString("dtname"));
                document.setContenttype(rs.getString("conttype"));
                document.setDocmodifydate(rs.getDate("docmodifydate"));
                list.add(document);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
	}
	public void modifyDocDescriForService(int did,String new_descri) {
		Object[] params= {new_descri,did};
		String sql="update document set dtname=? where did =?";
		JdbcUtils.update(sql, params);
	}
	public void insertNewDoc(int doc_creator, String doc_descri, String doc_pedi, String content_type) {
		
			String current_date = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
			String sql1="ADD ANY INTO document FROM genealogy WHERE gid =?";
			Object[] params1={Integer.parseInt(doc_pedi)};
			JdbcUtils.update(sql1,params1);
			int max=0;
			Connection conn = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
	        String sql="select max(did) from document";
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
			String sql2="update document set did=?,dtname=?,docmodifydate=?,doccreator=?,conttype=? where gid=? and did IS NULL";
			Object[] params2= {max+1,doc_descri,Date.valueOf(current_date),doc_creator,content_type,Integer.parseInt(doc_pedi)};
			JdbcUtils.update(sql2,params2);
	}
	public List<TDocument> getDocByNameAndPedi(String docname, int docpedi) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TDocument> list=new ArrayList<TDocument>();
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement("select * from document where dtname=? and gid=?");
            ps.setString(1,docname);
            ps.setInt(2, docpedi);
            rs = ps.executeQuery();
            while(rs.next())
            {
            	TDocument document=new TDocument();
                document.setGid(rs.getInt("gid"));
                document.setDtname(rs.getString("dtname"));
                document.setContenttype(rs.getString("conttype"));
                document.setDocmodifydate(rs.getDate("docmodifydate"));
                list.add(document);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
	}
	
	public void deleteDocdata(int did) {
		String sql="delete from document where did=?";
		Object[] params= {did};
		JdbcUtils.update(sql,params);
	}
	
	public List getUsersDocListbylocalbyname(String name,int gid) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TDocument> list=new ArrayList<TDocument>();
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement("select * from document where dtname=? and gid=?");
            ps.setString(1,name);
            ps.setInt(2,gid);
            rs = ps.executeQuery();
            while(rs.next())
            {
            	TDocument document=new TDocument();
                document.setGid(rs.getInt("gid"));
                document.setDtname(rs.getString("dtname"));
                document.setContenttype(rs.getString("conttype"));
                document.setDocmodifydate(rs.getDate("docmodifydate"));
                list.add(document);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
	}
	
	public void saveDoc(String dtname,String cont) {
		String sql="update document set cont=? where dtname=?";
		Object[] params= {cont,dtname};
		JdbcUtils.update(sql, params);
	}
	
	public String findDoccont(String dtname) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String content = null;
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement("select * from document where dtname=?");
            ps.setString(1,dtname);
            rs = ps.executeQuery();
            while(rs.next())
            {
            	content=rs.getString("cont");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
		return content;
	}
}
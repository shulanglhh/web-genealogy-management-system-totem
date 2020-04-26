package pedi.dao.impl;

import java.io.Serializable;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pedi.dao.DocDaoI;
import pedi.dao.PersonDaoI;
import pedi.model.TPerson;
import pedi.model.TSpouse;
import pedi.model.TChild;
import pedi.model.TChildex;
import pedi.model.TGenealogy;
import pedi.model.TOwner;
import pedi.util.BeanHandlerImpl;
import pedi.util.JdbcUtils;
import pedi.util.JdbcUtils_DBCP;

@Repository("personDao")
public class PersonDaoImpl implements PersonDaoI {
	public void save(TPerson person) {
        String sql1 = "add any into men from genealogy where gid=?";
        Object params[] = {person.getGid()};
        String sql2 = "add any into women from genealogy where gid=?";
        String sql3 = "update men set bid=1,pid=?,familyname=?,name=?,birth=?,birthlocation=?,islive=?,deathtime=?,gender='男',gennum=?,intros=?where gid=? and pid IS NULL";
        Object params1[] = {person.getPid(),person.getFamilyname(),person.getname(),person.getBirthdate(),person.getBirthlocation(),person.getlive(),person.getDeathdate(),person.getGennum(),person.getIntros(),person.getGid()};
        String sql4 = "update women set bid=1,pid=?,familyname=?,name=?,birth=?,birthlocation=?,islive=?,deathtime=?,gender='女',gennum=?,intros=?where gid=? and pid IS NULL";
        String sex=person.getGender();
        if(sex.contains("男")) {
        	JdbcUtils.update(sql1, params);
        	JdbcUtils.update(sql3, params1);
        }
        else{
        	JdbcUtils.update(sql2, params);
        	JdbcUtils.update(sql4, params1);
        }
    }
	
	public void update(TPerson person) {
		String sql1 = "update men set familyname=?,name=?,birth=?,birthlocation=?,islive=?,deathtime=?,gennum=?,intros=?where pid=?";
        Object params[] = {person.getFamilyname(),person.getname(),person.getBirthdate(),person.getBirthlocation(),person.getlive(),person.getDeathdate(),person.getGennum(),person.getIntros(),person.getPid()};
        String sql2 = "update women set familyname=?,name=?,birth=?,birthlocation=?,islive=?,deathtime=?,gennum=?,intros=?where pid=?";
        String sex=person.getGender();
        if(sex.contains("男"))
        	JdbcUtils.update(sql1, params);
        else
        	JdbcUtils.update(sql2, params);
    }
	
	public void root(TPerson person) {
		String sql1 ="add into spouse from genealogy where gid=?";
		Object[] params1= {person.getGid()};
		JdbcUtils.update(sql1, params1);
		String sql2="update spouse set sid=0,manid=0 where sid IS NULL";
		Object[] params2= {};
		JdbcUtils.update(sql2, params2);
		String sql3 ="add any into child from person,spouse where person.pid=? and spouse.sid=0";
		Object[] params3 = {person.getPid()};
		JdbcUtils.update(sql3, params3);
		String sql4 ="update child set sort=0 where pid=?";
		JdbcUtils.update(sql4, params3);
	}
	
	public TPerson find(String sql,Object params[]) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        TPerson person=new TPerson();
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
            	person.setBirthdate(rs.getString("birth"));
            	person.setBirthlocation(rs.getString("birthlocation"));
            	person.setDeathtime(rs.getString("deathtime"));
            	person.setFamilyname(rs.getString("familyname"));
            	person.setGender(rs.getString("gender"));
            	person.setGennum(rs.getInt("gennum"));
            	person.setGid(rs.getInt("gid"));
            	person.setIntros(rs.getString("intros"));
            	person.setname(rs.getString("name"));
            	person.setislive(rs.getBoolean("islive"));
            	person.setPid(rs.getInt("pid"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return person;
    }
	
	public int findmax(String sql,Object params[]) {
		int max=0;
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtils_DBCP.getConnection();
            ps = conn.prepareStatement(sql);
            for (int i = 0; i < params.length; i++) {
                ps.setObject(i + 1, params[i]);
            }
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
	
	public List<Map> findcount(String sql,Object params[]){
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Map>list=new ArrayList<Map>();
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
            	Map m=new HashMap();
            	m.put("count", rs.getInt("count"));
            	m.put("gender", rs.getString("gender"));
            	m.put("islive", rs.getBoolean("islive"));
            	list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
	}
	
	public List<TPerson> findlist(String sql,Object params[]) {
    	Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TPerson>list=new ArrayList<TPerson>();
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
            	TPerson person=new TPerson();
            	person.setBid(rs.getInt("bid"));
            	person.setBirthdate(rs.getString("birth"));
            	person.setBirthlocation(rs.getString("birthlocation"));
            	person.setDeathtime(rs.getString("deathtime"));
            	person.setFamilyname(rs.getString("familyname"));
            	person.setGender(rs.getString("gender"));
            	person.setGennum(rs.getInt("gennum"));
            	person.setGid(rs.getInt("gid"));
            	person.setIntros(rs.getString("intros"));
            	person.setname(rs.getString("name"));
            	person.setislive(rs.getBoolean("islive"));
            	person.setPid(rs.getInt("pid"));
                list.add(person);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
    }
	
	public List<TChildex> findchildexlist(String sql,Object params[]) {
    	Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TChildex>list=new ArrayList<TChildex>();
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
            	TChildex childex=new TChildex();
            	childex.setPid(rs.getInt("pid"));
            	childex.setPerson(rs.getInt("person"));
                list.add(childex);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
    }
	
	public List<TChild> findchildlist(String sql,Object params[]) {
    	Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<TChild>list=new ArrayList<TChild>();
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
            	TChild child=new TChild();
            	child.setBid(rs.getInt("bid"));
            	child.setBirthdate(rs.getString("birth"));
            	child.setBirthlocation(rs.getString("birthlocation"));
            	child.setDeathtime(rs.getString("deathtime"));
            	child.setFamilyname(rs.getString("familyname"));
            	child.setGender(rs.getString("gender"));
            	child.setGennum(rs.getInt("gennum"));
            	child.setIntros(rs.getString("intros"));
            	child.setname(rs.getString("name"));
            	child.setislive(rs.getBoolean("islive"));
            	child.setPid(rs.getInt("pid"));
            	child.setManid(rs.getInt("manid"));
            	child.setWomenid(rs.getInt("womanid"));
            	child.setMarrytime(rs.getString("marrytime"));
            	child.setSid(rs.getInt("sid"));
            	child.setRank(rs.getInt("rank"));
            	child.setType(rs.getString("type"));
                list.add(child);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return list;
    }
	
	public TPerson getById(int fatherPid) {
		String sql="select * from person where person.pid=?";
		Object[] params= {fatherPid};
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        TPerson person=new TPerson();
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
            	person.setBirthdate(rs.getString("birth"));
            	person.setBirthlocation(rs.getString("birthlocation"));
            	person.setDeathtime(rs.getString("deathtime"));
            	person.setFamilyname(rs.getString("familyname"));
            	person.setGender(rs.getString("gender"));
            	person.setGennum(rs.getInt("gennum"));
            	person.setGid(rs.getInt("gid"));
            	person.setIntros(rs.getString("intros"));
            	person.setname(rs.getString("name"));
            	person.setislive(rs.getBoolean("islive"));
            	person.setPid(rs.getInt("pid"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils_DBCP.release(conn, ps, rs);
        }
        return person;
	}
	
	public int addspouse(int gid, int fatherPid, int motherPid) {
		String sql1="add any into spouse from genealogy where gid=?";
		Object[] params1= {gid};
		JdbcUtils.update(sql1, params1);
		String sql="select max(sid) from spouse";
		Object[] params= {};
		int max=findmax(sql,params);
		String sql2="update spouse set sid=?,manid=?,womanid=? where gid=? and sid IS NULL";
		Object[] params2= {max+1,fatherPid,motherPid,gid};
		JdbcUtils.update(sql2, params2);
		return max+1;
	}
	public void addchild(int pid, int sid,int fatherPid) {
		String sql="add any into child from person,spouse where person.pid=? and spouse.sid=?";
		Object[] params= {pid,sid};
		JdbcUtils.update(sql, params);
		String sql_="select max(sort) from child where manid=?";
		Object[] params_= {fatherPid};
		int max=findmax(sql_,params_);
		String sql2="update child set sort=? where pid=?";
		Object[] params2= {max+1,pid};
		JdbcUtils.update(sql2, params2);
	}
	public void addmate(int pid, int matePid) {
		String sql1="add into childex from child where pid =?";
		Object[] params1= {matePid};
		JdbcUtils.update(sql1, params1);
		String sql2="update childex set person=? where pid=? and person IS NULL";
		Object[] params2= {pid,matePid};
		JdbcUtils.update(sql2, params2);
	}
	
	public void deletePerson(String sql,String sql1, String sql2, Object[] params) {
		JdbcUtils.update(sql, params);
		JdbcUtils.update(sql1, params);
		JdbcUtils.update(sql2, params);
	}
}
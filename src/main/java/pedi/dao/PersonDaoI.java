package pedi.dao;

import java.io.Serializable;

import pedi.model.TPerson;
import pedi.model.TSpouse;
import pedi.model.TChild;
import pedi.model.TChildex;

import java.util.List;
import java.util.Map;


public interface PersonDaoI {
	public void save(TPerson tperson);
	public void update(TPerson person);
	public int findmax(String sql,Object params[]);
	public TPerson find(String sql,Object params[]);
	public List<TPerson> findlist(String sql,Object params[]);
	public List<TChildex> findchildexlist(String sql,Object params[]);
	public List<TChild> findchildlist(String sql,Object params[]);
	public List<Map> findcount(String sql,Object params[]);
	public void root(TPerson rootTI);
	public TPerson getById(int fatherPid);
	public int addspouse(int gid, int fatherPid, int motherPid);
	public void addchild(int pid, int sid,int fatherPid);
	public void addmate(int pid, int matePid);
	public void deletePerson(String sql,String sql1, String sql2, Object[] params);
}
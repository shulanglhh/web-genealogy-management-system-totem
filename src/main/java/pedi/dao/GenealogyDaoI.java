package pedi.dao;

import java.io.Serializable;
import java.util.List;

import pedi.model.TGenealogy;


public interface GenealogyDaoI {
	
	public TGenealogy find(String sql, Object params[]);
	public List<TGenealogy> findlist(String sql,Object params[]);
	public void save(TGenealogy genealogy);
	public void update(TGenealogy genealogy);
	public void excute(String sql,Object params[]);
	public int count(String sql,Object params[]);
	public int find(TGenealogy t);
}
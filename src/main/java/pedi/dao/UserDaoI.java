package pedi.dao;

import java.io.Serializable;

import pedi.model.TOwner;
import pedi.pageModel.User;


public interface UserDaoI {
	
	public TOwner find(String sql, Object params[]);
	public void save(TOwner owner);
	public void update(TOwner owner);
	public int find();
}

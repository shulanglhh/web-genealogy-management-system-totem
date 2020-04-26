package pedi.service;

import java.util.ArrayList;
import java.util.List;

import pedi.model.TGenealogy;
import pedi.model.TOwner;
import pedi.pageModel.Comboxlist;

public interface UserServiceI {

	public void saveUser(TOwner owner);
	public TOwner login(TOwner owner);
    public boolean checkUnique(String username);//验证用户名是否唯一
    public TOwner getUserbyid(int id);
    public void updateUser(TOwner user);
    public List<Comboxlist> showthegname(int uid);
}
package pedi.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pedi.dao.UserDaoI;
import pedi.dao.GenealogyDaoI;
import pedi.model.TGenealogy;
import pedi.model.TOwner;
import pedi.pageModel.Comboxlist;
import pedi.service.UserServiceI;

import com.opensymphony.xwork2.ActionContext;


@Transactional
@Service("userService")
public class UserServiceImpl implements UserServiceI {

	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
//	@Autowired
//	private BaseDaoI<TUser> userDao;
    private UserDaoI userDao;
	
	
	public UserDaoI getUserDao() {
		return userDao;
	}
	
	@Autowired
	public void setUserDao(UserDaoI userDao) {
		this.userDao = userDao;
	}
    private GenealogyDaoI genealogyDao;
	
	
	public GenealogyDaoI getGenealogyDao() {
		return genealogyDao;
	}
	
	@Autowired
	public void setGenealogyDao(GenealogyDaoI genealogyDao) {
		this.genealogyDao = genealogyDao;
	}
	
	@Override
	public void saveUser(TOwner owner) {
		int max=userDao.find();
		owner.setUid(max+1);
		userDao.save(owner);
		//Tuser t = new Tuser();
		//BeanUtils.copyProperties(user, t, new String[] { "pwd" });
		//t.setId(UUID.randomUUID().toString());
		//t.setCreatedatetime(new Date());
		//user.setPwd(user.getPwd());
		//userDao.save(user);
		//BeanUtils.copyProperties(t, user);
		//return user;
	}

	@Override
	public TOwner login(TOwner owner) {
		Object[] params = {owner.getUsername(),owner.getPassword()};
		TOwner t = userDao.find("select * from owner where username = ? and password = ?", params);
		if (t != null) {
			owner.setUid(t.getUid());
			//set input setting. added by phindy 20140627
//			user.setMaxdepth(t.getMaxdepth());
//			user.setDefaultalive(t.getDefaultalive());
//			user.setSaveremind(t.getSaveremind());
//			user.setInputsort(t.getInputsort());
//			user.setInputsimplesort(t.getInputsimplesort());
			return owner;
		}
		return null;
	}

	@Override
	public boolean checkUnique(String username) {
		Object[] params= {username};
		TOwner row=userDao.find("select * from owner where username= ?",params);
		if(row!=null)
		return false;
		else
		return true;
	}
	
	@Override
	public TOwner getUserbyid(int id) {
		Object[] params= {id};
		TOwner u=userDao.find("select * from owner where uid=?", params);
		return u;
	}
	
	@Override
	public void updateUser(TOwner user) {
		userDao.update(user);
		
	}
	
	public List<Comboxlist> showthegname(int uid) {
		List<Comboxlist> ul=new ArrayList<Comboxlist>();
		Comboxlist u=new Comboxlist();
		Object[] params= {uid};
		String sql="select * from genealogy where uid=?";
		List<TGenealogy> lt=genealogyDao.findlist(sql,params);
		for(int i=0;i<lt.size();i++)
		{
			TGenealogy t=lt.get(i);
		    u.setPid(t.getGid());
		    u.setText(t.getGname());
		    ul.add(u);
		}
		return ul;
	}
}
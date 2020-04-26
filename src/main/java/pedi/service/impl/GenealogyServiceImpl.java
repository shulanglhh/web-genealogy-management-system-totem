package pedi.service.impl;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pedi.dao.GenealogyDaoI;
import pedi.dao.UserDaoI;
import pedi.model.TGenealogy;
import pedi.model.TOwner;
import pedi.pageModel.DataGrid;
import pedi.pageModel.Genealogy;
import pedi.service.GenealogyServiceI;

import com.opensymphony.xwork2.ActionContext;

@Service
@Transactional
public class GenealogyServiceImpl  implements GenealogyServiceI {
//	private int MAX_DEPTH = 9;
//	@Autowired
//	private BaseDaoI<TGenealogy> genealogDao;
	 private GenealogyDaoI genealogyDao;
		
		
	public GenealogyDaoI getGenealogyDao() {
		return genealogyDao;
	}
		
	@Autowired
	public void setGenealogyDao(GenealogyDaoI genealogyDao) {
		this.genealogyDao = genealogyDao;
	}
	
	@Override
	public boolean creatnewgenealogy(TGenealogy t) {
		TGenealogy p = new TGenealogy();
		BeanUtils.copyProperties(t, p);
		String gnames = t.getGname();
		Object[] params= {gnames,t.getUid()};
		TGenealogy tmp = genealogyDao.find("select * from genealogy where gname=? and uid=?",params);
		genealogyDao.save(p);
		genealogyDao.update(p);
		return true;
		//为族谱
	}

	@Override
	public DataGrid showthepedigree() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int uid = (Integer)request.getSession().getAttribute("userid");
		DataGrid dg = new DataGrid();
		Object[] params = {uid};
		String sql1 = "select * from genealogy where uid=?";
		String sql2 = "select count(*) from genealogy where uid=?";
		List<TGenealogy> l = genealogyDao.findlist(sql1, params);
		dg.setTotal(new Long((long)genealogyDao.count(sql2, params)));
		dg.setRows(l);
		return dg;
	}

	@Override
	public boolean savethegenealogy(ArrayList<TGenealogy> deleted,
			ArrayList<TGenealogy> updated) {
		if (deleted != null) {
			for (TGenealogy tdeleted : deleted) {
				Integer gid = tdeleted.getGid();
				deletegidrel(gid.intValue());
			}
		}
		if (updated != null) {
			for (TGenealogy tupdated : updated) {
				String sql = "UPDATE Genealogy SET gname=?,Familyname=?, Tagname=?,Location=?,GenDesc=? WHERE gid=?";
				Object[] params = {tupdated.getGname(),tupdated.getFamilyname(),tupdated.getTangname(),tupdated.getLocation(),tupdated.getDescription(),tupdated.getGid()};
				genealogyDao.excute(sql,params);
			}
		}
		return true;
	}
	
	private boolean deletegidrel(int gid){
		Object[] params= {gid};
		genealogyDao.excute("DELETE FROM Genealogy WHERE gid=?", params);
	    return true;
	}
}
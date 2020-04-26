package pedi.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import pedi.dao.UserDaoI;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import pedi.model.TGenealogy;

import pedi.pageModel.Json;
import pedi.pageModel.DataGrid;

import pedi.service.GenealogyServiceI;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.logging.Logger;

@ParentPackage("basePackage")
@Namespace("/")
@Action(value = "genealogyAction")
public class GenealogyAction extends BaseAction<Object> implements ModelDriven<TGenealogy> {
	private TGenealogy genea = new TGenealogy();
	@Autowired
	private GenealogyServiceI genealogyService;

	public GenealogyServiceI getGenealogyService() {
		return genealogyService;
	}

	public void setGenealogyService(GenealogyServiceI genealogyService) {
		this.genealogyService = genealogyService;
	}

	private Logger logger;
	
	public void creatthenewPedigree() {
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		response.setCharacterEncoding("utf-8");
		String gname = request.getParameter("gname");
		String familyname = request.getParameter("familyname");
		String description = request.getParameter("description");
		String tangname = request.getParameter("tangname");
		String userid = request.getParameter("uid");
		String source=request.getParameter("source");
		String city=request.getParameter("city");
		String locationplace=request.getParameter("locationplace");
		locationplace=locationplace+city;
		if(locationplace==null||locationplace.equals("null")){
			locationplace="";
		}
		int uid = Integer.parseInt(userid);
		TGenealogy t = new TGenealogy();
		t.setGname(gname);
		t.setFamilyname(familyname);
		t.setDescription(description);
		t.setUid(uid);
		t.setTangname(tangname);
		t.setLocation(locationplace);
		int num = 0;
		boolean r = genealogyService.creatnewgenealogy(t);		
		Json j = new Json();
		if (r) {			
			j.setSuccess(true);
			
			j.setMsg("新建族谱成功"+num);
		} else {
			j.setSuccess(false);
			j.setMsg("族谱名称已经占用请重命名");
		}
		super.writeJson(j);
	}

	public void savethegenealogy() {
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		response.setCharacterEncoding("utf-8");
		String deleteds = request.getParameter("deleteds");
		String updateds = request.getParameter("updateds");
		ArrayList<TGenealogy> deleted = null;
		ArrayList<TGenealogy> updated = null;
		if (!deleteds.equals("undefined")) {
			deleted = JSON.parseObject(deleteds, new TypeReference<ArrayList<TGenealogy>>() {
			});
		}
		if (!updateds.equals("undefined")) {
			updated = JSON.parseObject(updateds, new TypeReference<ArrayList<TGenealogy>>() {
			});
		}

		boolean t = genealogyService.savethegenealogy(deleted, updated);
		Json j = new Json();
		if (t) {
			j.setSuccess(true);
			j.setMsg("保存成功");
		} else {
			j.setSuccess(false);
			j.setMsg("保存失败，请检查网络");
		}
		super.writeJson(j);
	}


	public void showthepedigree() {
		DataGrid dg=genealogyService.showthepedigree();
		super.writeJson(dg);
	}
	
	
	@Override
	public TGenealogy getModel() {
		// TODO Auto-generated method stub
		return genea;
	}
}
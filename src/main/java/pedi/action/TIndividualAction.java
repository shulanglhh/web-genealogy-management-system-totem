package pedi.action;

import java.sql.Timestamp;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import pedi.model.TPerson;
import pedi.model.TChild;
import pedi.pageModel.BaseMessage;
import pedi.pageModel.DataGrid;
import pedi.pageModel.Json;
import pedi.pageModel.PageIndividual;
import pedi.pageModel.RelativeInfo;
import pedi.pageModel.ResponseJson;
import pedi.service.DocServiceI;
import pedi.service.TIndividualServiceI;
import pedi.service.TRelationServiceI;

import com.opensymphony.xwork2.ModelDriven;

@Namespace("/")
@Action("tIndividualAction")
public class TIndividualAction extends BaseAction<TPerson> implements ModelDriven<TPerson> {
	static final Logger logger = LogManager.getLogger(TIndividualAction.class.getClass());
	private TPerson tperson = new TPerson();

	@Override
	public TPerson getModel() {
		// TODO Auto-generated method stub
		return tperson;
	}
	
	private int submittype, fatherpid, motherpid, matepid, curpid, savepid;
	private boolean isalien;
	private boolean formchanged;
	

	public int getSubmittype() {
		return submittype;
	}

	public void setSubmittype(int submittype) {
		this.submittype = submittype;
	}

	public int getFatherpid() {
		return fatherpid;
	}

	public void setFatherpid(int fatherpid) {
		this.fatherpid = fatherpid;
	}

	public int getMotherpid() {
		return motherpid;
	}

	public void setMotherpid(int motherpid) {
		this.motherpid = motherpid;
	}

	public int getMatepid() {
		return matepid;
	}

	public void setMatepid(int matepid) {
		this.matepid = matepid;
	}

	public int getCurpid() {
		return curpid;
	}

	public void setCurpid(int curpid) {
		this.curpid = curpid;
	}

	public int getSavepid() {
		return savepid;
	}

	public void setSavepid(int savepid) {
		this.savepid = savepid;
	}

	public boolean isIsalien() {
		return isalien;
	}

	public void setIsalien(boolean isalien) {
		this.isalien = isalien;
	}

	public boolean isFormchanged() {
		return formchanged;
	}

	public void setFormchanged(boolean formchanged) {
		this.formchanged = formchanged;
	}

	private TIndividualServiceI tindividualService;

	
	public TIndividualServiceI getTIndividualService() {
		return tindividualService;
	}
	@Autowired
	public void settindividualService(TIndividualServiceI tindividualService) {
		this.tindividualService = tindividualService;
	}
	
	public void addRootPerson(){
		String sRootName = ServletActionContext.getRequest().getParameter("rootName");
		String sRootSurname = ServletActionContext.getRequest().getParameter("rootSurname");
		String sGgenNum = ServletActionContext.getRequest().getParameter("rootGgen");
		String sPediId = ServletActionContext.getRequest().getParameter("pediId");
		ResponseJson rJson = new ResponseJson();
		int ggenNum = 0, pediId = 0;
		if(null != sGgenNum && !"".equals(sGgenNum)){
			ggenNum = Integer.parseInt(sGgenNum);
		}
		if(null != sPediId && !"".equals(sPediId)){
			pediId = Integer.parseInt(sPediId);
		}
		if(ggenNum>0 && pediId>0 && sRootName!=null && !"".equals(sRootName) 
				&& sRootSurname!=null && !"".equals(sRootSurname)){
			rJson = tindividualService.addRootPerson(ggenNum, pediId, sRootName, sRootSurname);
		}
		writeJson(rJson);
	}
	
	synchronized public void save() {
		//String[] surname=tIndividual.getSurname().split(",");
		//tIndividual.setSurname(surname[0]);
		String familyname=ServletActionContext.getRequest().getParameter("surname");
		String name=ServletActionContext.getRequest().getParameter("name");
		String gender=ServletActionContext.getRequest().getParameter("sex");
		String islive=ServletActionContext.getRequest().getParameter("islive");
		tperson.setFamilyname(familyname);
		tperson.setname(name);
		tperson.setGender(gender);
		if(islive.contains("true"))
			tperson.setislive(true);
		else
			tperson.setislive(false);
		ResponseJson json = new ResponseJson();
		int ggen = 0;		
		try {
			int submitType = submittype;//tIndividual.getSubmittype();
			int fatherPid = fatherpid;//tIndividual.getFatherpid();
			int motherPid = motherpid;//tIndividual.getMotherpid();
			int matePid = matepid;//tIndividual.getMatepid();
			int curPid = curpid;//tIndividual.getCurpid();//对未保存至数据库的人物，为空
			boolean isAlien = isalien;
			//int savePid = tIndividual.getSavepid();//上次保存成功的人物ID,useful?
			RelativeInfo prevRelInfo = new RelativeInfo();
			prevRelInfo.setCurPid(curPid);
			prevRelInfo.setFatherPid(fatherPid);
			prevRelInfo.setMotherPid(motherPid);
			prevRelInfo.setMatePid(matePid);
			prevRelInfo.setIsAlien(false);
			//返回给客户端的数据，初始化为0吗？？？
			int newCurPid = 0, 
					newFatherPid = 0, 
					newMotherPid = 0, 
					newMatePid = 0,
					savePid = 0;
			boolean newIsAlien = false;
			
			if(curPid==0&&fatherPid==0&&motherPid==0&&matePid==0){
				json.setSuccess(false);
				json.setMsg("未保存，选择一个节点再进行操作");
				writeJson(json);
				return ;
			}
			if(fatherpid>0) {
				ggen = tindividualService.getById(fatherPid).getGennum() + 1;//getGgen()得到的null就报错了！
			}
			else
				ggen=1;
			tperson.setGennum(ggen);							
			switch (submitType){
				//1:保存，2：添加子女， 3：添加兄妹， 4：添加配偶,5:侧室
				case 1: 
					if(isPidValid(curPid)){//如果是已存在的人物，则执行更新，而不是插入
						tperson.setPid(curPid);
						newCurPid = curPid; 
						if(formchanged){	
							
							tindividualService.updateIndividual(tperson);	
							//对于更新一个人物，需要更新人物关系么？？需要！！至少需要更新人物表的姓名、性别！//同时 如果一个人的性别改变了之后他原来的关系也要
						}
					}
					else{						
						tindividualService.saveIndividual(tperson);
						tindividualService.saveRelation(tperson.getGid(),tperson.getPid(), fatherPid, motherPid, matePid);
						newCurPid = tperson.getPid();
					}
					
					savePid = newCurPid;
					//newSavePid = tIndividual.getPid();
					newFatherPid = fatherPid;
					newMotherPid = motherPid;
					newMatePid = matePid;
					curPid = newCurPid;
					newIsAlien = isAlien;
				break;
				//添加子女。女儿和女婿也可添加子女！
				case 2: 
					if(isPidValid(curPid)){//如果是已存在的人物，则执行更新，而不是插入
						tperson.setPid(curPid);
						if(formchanged){							
							tindividualService.updateIndividual(tperson);	

						}
					}else{						
						tindividualService.saveIndividual(tperson);
					}
					//String sex = tIndividual.getSex();
					//不根据性别来判定fatherPid和motherPid。因为fatherPid可能是男也可能是女
					newFatherPid = tperson.getPid();
					newMotherPid = matePid;
					//newSavePid = tIndividual.getPid();
					newCurPid = 0;//未保存的人物，默认给0？
					newIsAlien = false;
				break;
				//添加兄妹，配偶不能添加兄妹和配偶，前端验证
				case 3: 
					if(isPidValid(curPid)){//如果是已存在的人物，则执行更新，而不是插入
						tperson.setPid(curPid);
						if(formchanged){
							tperson.setPid(curPid);
							tindividualService.updateIndividual(tperson);
						}
					}else{						
						tindividualService.saveIndividual(tperson);
					}
					newFatherPid = fatherPid;
					newMotherPid = motherPid;
					//newSavePid = tIndividual.getPid();
					newCurPid = 0;
					newIsAlien = false;
				break;
				//添加配偶，女儿不能添加配偶和子女！在前端验证
				//需要支持女儿添加配偶和子女！但是配偶不能添加配偶，需要验证。20140729
				case 4: 
					if(isPidValid(curPid)){//如果是已存在的人物，则执行更新，而不是插入
						tperson.setPid(curPid);
						newMatePid = curPid;//当前人物ID变成配偶ID
						if(formchanged){
							tperson.setPid(curPid);
							tindividualService.updateIndividual(tperson);
						}
					}else{
						tindividualService.saveIndividual(tperson);
						savePid = tperson.getPid();
						newMatePid = savePid;
					}
					newFatherPid = 0;
					newMotherPid = 0;
					//newSavePid = tIndividual.getPid();	
					newCurPid = 0;
					newIsAlien = true;
				break;
			}
			TPerson result=tindividualService.getById(tperson.getPid());
			PageIndividual pIndividual = new PageIndividual();
			pIndividual.setSurname(result.getFamilyname());
			pIndividual.setName(result.getname());
			pIndividual.setGid(result.getGid());
			pIndividual.setPid(result.getPid());
			pIndividual.setSex(result.getGender());
			pIndividual.setGgen((short)result.getGennum());
			pIndividual.setIslive(result.getlive());
			RelativeInfo relInfo = new RelativeInfo();
			relInfo.setCurPid(newCurPid);
			relInfo.setFatherPid(newFatherPid);
			relInfo.setMatePid(newMatePid);
			relInfo.setMotherPid(newMotherPid);
			relInfo.setIsAlien(newIsAlien);
			json.setObj(pIndividual);
			json.setSuccess(true);
			json.setRelInfo(relInfo);//返回关联人物信息
			json.setPrevRelInfo(prevRelInfo);//返回所保存的人物之关联信息,树节点保存信息时用
			json.setMsg(tperson.getname() + "保存成功");

		} catch (Exception e) {
			e.printStackTrace();
		}

		writeJson(json);
	}
	
	public boolean isPidValid(int pid){
		if(pid>0)
			return true;
		else
			return false;
	}

}
